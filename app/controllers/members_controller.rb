require 'pry'

class MembersController < ApplicationController
  before_action :authenticate_member!, except: [:index,:show]
  before_action :set_member, only: [:show, :edit, :update, :destroy, :edit_profile]
  before_filter :allow_if_current_member, only: [:edit_profile]

  # GET /members
  # GET /members.json
  def index
    @members = Member.includes(:personal_websites,:participant,:person)
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @websites = @member.personal_websites
  end

  # GET /members/new
  def new
    @member = Member.new
    @participant = @member.build_participant
    @person = @member.build_person
    @personal_website = resource.personal_websites.build
  end

  # GET /members/1/edit
  def edit
  end

  def edit_profile
    unless @member.personal_websites.any?
      @personal_website = @member.personal_websites.build
    end
    respond_to do |format|
      @edit = true
      format.html
    end
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params.except(:person_attributes, :participant_attributes))
    @member.participant = Participant.new(member_params[:participant_attributes])
    @member.person = Person.new(member_params[:person_attributes])

    respond_to do |format|
      if @member.save
        @member.participant.person_id = @member.person_id

        format.js { render js: 'hide_and_redraw()' }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @member, form_path: "members/form" } }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)

        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    def allow_if_current_member
      redirect_to root_path unless current_member == @member
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:isAdmin,:author_id, participant_attributes:[:title,:administrative_title,:email],person_attributes: [:firstName, :lastName])
    end
end
