class MembersController < ApplicationController
  before_action :authenticate_member!, except: [:index]
  before_action :set_member, only: [:edit, :update, :edit_profile]
  before_filter :allow_if_current_member, only: [:edit_profile,:edit, :update]

  def index
    # @members = Member.includes(:personal_websites,:participant,:person).where("members.person_id is not null and members.participant_id is not null")

    @members = Member.extended.where("members.person_id IS NOT NULL AND members.participant_id IS NOT NULL")
    @staff = []
    @students =[]
    @members.each do |member|
      if(member.isStudent)
        @students << member
      else
        @staff << member
      end
    end
  end

  def edit
    # unless @member.personal_websites.any?
    #   @personal_website = @member.personal_websites.build
    # end
    @member.build_unused_websites
    @authenticity_token  = form_authenticity_token
    render "members/edit_profile"
  end

  def update
    @member.update(member_params)

    # find new websites created
    if member_params[:personal_websites_attributes]
      member_params[:personal_websites_attributes].each do |key, website|

        if !website[:id] && !website[:url].empty? # create the new websites
          @member.personal_websites << PersonalWebsite.new(website)

        elsif website[:id] && !website[:url].empty? # update existing websites
          @member.personal_websites.find(website[:id]).update( website.except(:id) )

        elsif website[:id] && website[:url].empty? # delete existing websites that have no url
          PersonalWebsite.find(website[:id]).destroy
        end
      end
    end

    respond_to do |format|

      if member_params[:password]
        sign_in @member, bypass: true
      end

      format.html { redirect_to(edit_member_path(@member)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.extended.find(params[:id])
    end

    def allow_if_current_member
      redirect_to root_path unless current_member == @member
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:crop_x, :crop_y, :crop_w, :crop_h,:bio, :avatar, :id,:email, :password, :password_confirmation, :participant_id, :person_id, :invited_by_type,
                                     participant_attributes:[:id,:title,:administrative_title,:email],
                                     person_attributes: [:id,:firstName, :lastName],
                                     personal_websites_attributes: [ :id, :url, :website_template_id, :_destroy])
    end
end
