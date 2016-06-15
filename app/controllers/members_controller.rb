class MembersController < ApplicationController
  before_action :authenticate_member!, except: [:index]
  before_action :set_member, only: [:edit, :update, :edit_profile]
  before_filter :allow_if_current_member, only: [:edit_profile,:edit, :update]

  def index
    @members = Member.includes(:personal_websites,:participant,:person)
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

  def edit
    unless @member.personal_websites.any?
    @personal_website = @member.personal_websites.build
    end

    @edit  = true
    render "members/edit_profile"

    # respond_to do |format|
    #   @edit = true
    #   render "edit_profile"
    # end
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
