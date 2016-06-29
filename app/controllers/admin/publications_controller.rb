class Admin::PublicationsController < Admin::DashboardController
  before_action :set_publication, only: [:check_if_any_members, :edit, :update, :destroy, :new_people, :create_people]

  # GET /publications
  # GET /publications.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: PublicationDatatable.new(view_context) }
    end
  end

  # GET /publications/new
  def new
    @publication = Publication.new

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @publication, form_path: "publications/form" } }
    end
  end

  def new_from_bibtex
    @publication = Publication.new

    respond_to do |format|
      format.js { render 'add_from_bibtex' }
    end
  end

  # GET /publications/1/edit
  def edit
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @publication, form_path: "publications/form" } }
    end
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.js { render js: 'hide_and_redraw()' }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @publication, form_path: "publications/form" } }
      end
    end
  end

  def create_from_bibtex
    @publication = Publication.new
    @publication.create_from_bibtex(publication_params[:bibtex_entry])

    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'success', title = 'Created from BibTeX!', text = 'Created #{@publication.title}}' );" }
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.js { render js: 'hide_and_redraw()' }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @publication, form_path: "publications/form" } }
      end
    end
  end

  def check_if_any_members
    @members = @publication.return_member_authors

    @author = Author.find(params[:author_id])

    respond_to do |format|
      if ( @members.size == 1 )
        format.js { render "admin/initialize_confirmation_modal",
          locals: { modal_type: "remove_publication", publication_id: @publication.id, author_id: @author.id } }
      else
        format.js { render "admin/initialize_confirmation_modal",
          locals: { modal_type: "remove_author", publication_id: @publication.id, author_id: @author.id } }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy

    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'error', title = 'Publication Deleted!', text = 'Deleted #{@publication.title}' );"  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:bibtex_entry, :id,:title, :date, :pages, :abstract, :doi, author_attributes: [:publication_id,:person_id],
                                          people_attributes: [ person:[:id, :firstName, :lastName, :_destroy]])
    end
end
