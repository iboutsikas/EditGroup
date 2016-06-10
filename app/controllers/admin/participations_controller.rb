require 'pry'

class Admin::ParticipationsController < Admin::DashboardController
  before_action :set_project
  before_action :set_participation, only: [:show, :edit, :update, :destroy]

  # GET /participations/index
  def index
    respond_to do |format|
      format.html
      format.json { render json: ParticipationDatatable.new(view_context,{ project: @project, token: form_authenticity_token }) }
    end
  end

  def show
  end

  # GET /participations/new
  def new
    @participant = @project.participants.build
    @person = @participant.build_person
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @participant, form_path: "participations/form_create_multiple" } }
    end
  end

  def new_from_db
    @participation = Participation.new({project_id: @project.id})
    @participants = Participant.includes(:person).references(:person).find_by_sql(
        ["select * from participants where participants.id not in (select participant_id from participations
                                                                     where participations.project_id = ?)", @project.id])

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: { resource: @participation, form_path: "participations/form_select_multiple", participants: @participants_list } }
    end
  end

  def edit
    @participant = @participation.participant
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: { resource: @participation, form_path: "participations/form" } }
    end
  end

  # POST
  def create_multiple

    number_of_people = params[:project][:participants_attributes].size
    successfully_created = 0

    if params[:project][:participants_attributes]

      params[:project][:participants_attributes].each do |key,val|

        if val[:participant] && val[:person]

          @participation = Participation.new(project_id: @project.id )
          participant_params_array = val[:participant].except(:_destroy, :id)
          person_params_array = val[:person].except(:_destroy, :id)
          @participation.participant = Participant.new( participant_params_array.permit(:title, :administrative_title, :email) )
          @participation.participant.person = Person.new( person_params_array.permit(:firstName, :lastName) )
          @project.participations << @participation
          successfully_created += 1
        end
      end
    end

    respond_to do |format|
      if number_of_people == 0
        format.js { render 'admin/initializeForm', locals: {resource: @participant, form_path: "authors/form_create_multiple" } }
      elsif number_of_people == successfully_created
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Project Participants Created!',
                                text = 'Created #{number_of_people} #{'participant'.pluralize(number_of_people)} for #{@project.title}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @participant, form_path: "authors/form_create_multiple" } }
      end
    end
  end

  def create_from_db
    params[:people].each do |id|
      unless id.empty?
        @participation = Participation.new(project_id: @project.id, participant_id: id )
        unless @participation.save
          respond_to do |format|
            format.js { render 'admin/initializeForm', locals: {resource: @participation, form_path: "participation/form_select_multiple" } }
          end
        end
      end
    end

    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'success', title = 'Members Added',
                              text = 'Added #{params[:people].size} #{'member'.pluralize(params[:people].size)} in project #{@project.title}');" }
    end
  end

  # PATCH/PUT /participations/1
  # PATCH/PUT /participations/1.json
  def update
    respond_to do |format|

      if participation_params[:priority]

        @participation.update(participation_params)
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'info', title = 'Edit Successful', text = 'Edited #{@participation.person.full_name}' );" }

      elsif @participation.participant.update( params[:participation][:participant].except(:person).permit(:title, :administrative_title, :email,:priority) ) &&
          @participation.participant.person.update( params[:participation][:participant][:person].permit(:firstName,:lastName) )

        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'info', title = 'Edit Successful', text = 'Edited #{@participation.person.full_name}' );" }
      else
        format.js { render 'admin/initializeForm', locals: { resource: @participation, form_path: "participations/form" } }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @participation.destroy
    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'error', title = 'Project Participant Removed!',
                              text = 'Removed #{@participation.person.full_name} from project #{@project.title}' );"  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participation
      @participation = Participation.find(params[:id])
    end

    def set_project
      if params[:project_id]
        @project = Project.find(params[:project_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participation_params
      params.require(:participation).permit(:title,:administrative_title, :email, :priority,participants_attributes: [:id,:title, :administrative_title, :email, person_attributes:[:firstName, :lastName] ] )
    end
end
