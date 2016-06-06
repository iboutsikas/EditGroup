class Admin::PeopleController < Admin::DashboardController
  before_action :set_person, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: PersonDatatable.new(view_context,{ current_member: current_member }) }
    end
  end

  def new
    @person = Person.new

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @person, form_path: "people/form"} }
    end
  end

  # GET /People/1/edit
  def edit
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @person, form_path: "people/form"} }
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.js { render js: 'hide_and_redraw()' }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @person, form_path: "people/form"} }
      end
    end
  end

  def destroy
    @person.destroy
    respond_to do |format|
      format.js { render js: 'redraw_table()'  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:person,:person,:id, :firstName, :lastName)
    end
end
