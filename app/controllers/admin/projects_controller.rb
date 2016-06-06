class Admin::ProjectsController < Admin::DashboardController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: ProjectDatatable.new(view_context) }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @project, form_path: "projects/form" } }
    end
  end

  # GET /projects/1/edit
  def edit
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @project, form_path: "projects/form" } }
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Project Created!', text = 'Created #{@project.title}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @project, form_path: "projects/form" } }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Edit Successful', text = 'Edited #{@project.title}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @project, form_path: "projects/form" } }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'error', title = 'Project Deleted!', text = 'Deleted #{@project.title}' );"  }
    end
  end

  def new_participants
    @participant = @project.participants.build

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @participant,form_path: "participation/form" } }
    end
  end

  def create_participants
    number_of_people = publication_params[:participants].size
    successfully_created = 0

    if publication_params[:participants]

      publication_params[:participants].each do |key,val|

        if val[:person]
          @author = Author.new(publication_id: @publication.id )
          @person = Person.new(val[:person].except(:_destroy))
          @author.person = @person
          @publication.authors << @author
          successfully_created += 1
        end
      end
    end

    respond_to do |format|
      if number_of_people == 0
        format.js { render 'admin/initializeForm', locals: {resource: @person, form_path: "people/form" } }
      elsif number_of_people == successfully_created
        format.js { render js: 'hide_and_redraw()' }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @person, form_path: "people/form" } }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:id,:title, :motto, :description, :date_started,
       :website, :video, participant_attributes:[:title,:administrative_title,:email],
       person_attributes: [:firstName, :lastName])
    end
end
