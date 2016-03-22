class PeopleController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /People
  # GET /People.json
  def index
    @people = Person.all
  end

  # GET /People/1
  # GET /People/1.json
  def show
  end

  # GET /People/new
  def new
    @person = Person.new
  end

  # GET /People/1/edit
  def edit
  end

  # POST /People
  # POST /People.json
  def create
    @person = Person.new(author_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /People/1
  # PATCH/PUT /People/1.json
  def update
    respond_to do |format|
      if @person.update(author_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: person }
      else
        format.html { render :edit }
        format.json { render json: person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /People/1
  # DELETE /People/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:person).permit(:firstName, :lastName, project_participant_attributes: [:person_id, :title, :administrative_title, :email])
    end
end
