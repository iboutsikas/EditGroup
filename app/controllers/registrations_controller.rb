class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    @participant = resource.build_participant
    @person = resource.build_person
    @personal_websites = resource.personal_websites.build
    #@website_template = @personal_website.build_website_template
    set_minimum_password_length
    yield resource if block_given?
    respond_with self.resource

  end

  def create
    #@member = Member.accept_invitation!(invitation_token: sign_up_params[:invitation_token], email: sign_up_params[:email],
     #                                   password: sign_up_params[:password], isAdmin: sign_up_params[:isAdmin])
    #@member.participant = Participant.new(sign_up_params[:participant_attributes])
    #@member.person = Person.new(sign_up_params[:person_attributes])
    #@member.update(personal_websites_attributes: sign_up_params[:personal_websites_attributes])
    @member = Member.find_by_email(sign_up_params[:email])
    if @member.update(sign_up_params.except(:invitation_token))
      @member = Member.accept_invitation!(invitation_token: sign_up_params[:invitation_token], email: sign_up_params[:email],
                                                                           password: sign_up_params[:password])
      @member.participant.person_id = @member.person_id
      flash[:notice] = "Welcome #{@member.person.full_name}! You have successfully signed up."
      redirect_to root_url
    else
      render 'members/invitations/edit'
    end
  end

  private
    def sign_up_params
      params.require(:member).permit(:invitation_token, :email, :password, :password_confirmation,:isAdmin, :bio, participant_attributes:[:title,:administrative_title,:email],person_attributes: [:firstName, :lastName],personal_websites_attributes: [:id,:website_template_id,:url,:_destroy])
    end

    def account_update_params
      params.require(:member).permit(:email, :password, :password_confirmation, :current_password, :isAdmin, :bio, participant_attributes:[:title,:administrative_title,:email],person_attributes: [:firstName, :lastName],person_attributes: [:firstName, :lastName],personal_websites_attributes: [:id,:website_template_id,:url,:_destroy])
    end
end
