class Admin::JournalsController < Admin::DashboardController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: JournalDatatable.new(view_context) }
    end
  end

  def show
  end

  def new
    @journal = Journal.new
    @publication = @journal.build_publication

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @journal, form_path: "journals/form" } }
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @journal, form_path: "journals/form" } }
    end
  end

  def create
    @journal = Journal.new(journal_params.except(:publication_attributes))
    @journal.publication = Publication.new(journal_params[:publication_attributes])

    respond_to do |format|
      if @journal.save
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Journal Created!', text = 'Created #{journal_params[:publication_attributes][:title]}');" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @journal, form_path: "journals/form" } }
      end
    end
  end

  def update
    respond_to do |format|
      if @journal.update(journal_params)
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'info', title = 'Edit Successful', text = 'Edited #{@journal.publication.title}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @journal, form_path: "journals/form" } }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_journal
    @journal = Journal.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def journal_params
    params.require(:journal).permit(:title, :volume, :issue,:publication_id, publication_attributes: [:id,:title, :date, :pages, :abstract,:doi])
  end
end
