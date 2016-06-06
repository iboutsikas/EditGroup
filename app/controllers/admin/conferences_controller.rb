class Admin::ConferencesController < Admin::DashboardController
  before_action :set_conference, only: [:show, :edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json { render json: ConferenceDatatable.new(view_context) }
    end
  end

  def show
  end

  def new
    @conference = Conference.new
    @publication = @conference.build_publication

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @conference, form_path: "conferences/form" } }
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @conference, form_path: "conferences/form" } }
    end
  end

  def create
    @conference = Conference.new(conference_params.except(:publication_attributes))
    @conference.publication = Publication.new(conference_params[:publication_attributes])

    respond_to do |format|
      if @conference.save
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Conference Created!', text = 'Created #{conference_params[:publication_attributes][:title]}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @conference, form_path: "conferences/form" } }
      end
    end
  end

  def update
    respond_to do |format|
      if @conference.update(conference_params)
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'info', title = 'Edit Successful', text = 'Edited #{@conference.publication.title}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @conference, form_path: "conferences/form" } }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conference
    @conference = Conference.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def conference_params
    params.require(:conference).permit(:name, :publisher, :location, :publication_id, publication_attributes: [:id,:title, :date, :pages, :abstract,:doi])
  end
end
