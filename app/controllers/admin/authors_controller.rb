class Admin::AuthorsController < Admin::DashboardController
  before_action :set_publication
  before_action :set_author, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: AuthorDatatable.new(view_context,{ publication: @publication }) }
    end
  end

  def new
    @person = @publication.people.build

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @person, form_path: "authors/form_create_multiple"} }
    end
  end

  def new_from_db
    @author = Author.new({publication_id: @publication.id})
    @people = Person.find_by_sql(["select * from people where people.id not in
                                        (select authors.person_id from authors where authors.publication_id = ?)", @publication.id])

    respond_to do |format|
      format.js { render 'admin/initializeForm',
        locals: { resource: @author, form_path: "authors/form_select_multiple", people: @people_list } }
    end

  end

  def edit
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @author, form_path: "authors/form" } }
    end
  end


  def create_multiple
    number_of_people = params[:publication][:people_attributes].size
    successfully_created = 0

    if params[:publication][:people_attributes]

      params[:publication][:people_attributes].each do |key,val|

        if val[:person]
          @author = Author.new(publication_id: @publication.id )
          person_params_array = val[:person].except(:_destroy, :id)
          @author.person = Person.new( person_params_array.permit(:firstName, :lastName) )
          @publication.authors << @author
          successfully_created += 1

        end
      end
    end

    respond_to do |format|
      if number_of_people == 0
        format.js { render 'admin/initializeForm', locals: {resource: @person, form_path: "authors/form_create_multiple" } }
      elsif number_of_people == successfully_created
        logger.info "success"
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Authors Created!',
                                text = 'Created #{number_of_people} #{'author'.pluralize(number_of_people)} for #{@publication.title}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @person, form_path: "authors/form_create_multiple" } }
      end
    end
  end

  def create_from_db
    params[:people].each do |id|
      unless id.empty?
        @author = Author.new(publication_id: @publication.id, person_id: id)
        unless @author.save
          respond_to do |format|
            format.js { render 'admin/initializeForm', locals: {resource: @author, form_path: "authors/select_multiple" } }
          end
        end
      end
    end

    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'success', title = 'Members Added',
                              text = 'Added #{params[:people].size} #{'member'.pluralize(params[:people].size)} in #{@publication.title}');"}
    end
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'info', title = 'Edit Successful', text = 'Edited #{@author.person.full_name}' );" }
      else
        format.js { render 'admin/initializeForm', locals: { resource: @author, form_path: "authors/form_create_multiple" } }
      end
    end
  end

  def destroy
    @author.destroy
    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'error', title = 'Author Removed!', text = 'Removed #{@author.person.full_name}' );"  }
    end
  end

  def delete_publication
    @publication.destroy

    redirect_to admin_publications_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author = Author.find(params[:id])
  end

  def set_publication
    if params[:publication_id]
      @publication = Publication.find(params[:publication_id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def author_params
    params.require(:author).permit(:person_id, :publication_id,
      person_attributes: [:id, :firstName, :lastName],
      people_attributes: [ person:[:id, :firstName, :lastName, :_destroy]])
  end
end
