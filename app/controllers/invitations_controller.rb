class InvitationsController < Devise::InvitationsController

  def edit
    set_minimum_password_length if respond_to? :set_minimum_password_length

    @participant = resource.build_participant
    @person = resource.build_person
    #@personal_websites = resource.personal_websites.build
    @available_websites = WebsiteTemplate.all
    resource.build_unused_websites
    resource.invitation_token = params[:invitation_token]

    render 'members/invitations/edit'
  end

  # PUT /resource/invitation
  def update
    raw_invitation_token = update_resource_params[:invitation_token]

    self.resource = resource_class.accept_invitation!(update_resource_params)
    invitation_accepted = resource.errors.empty?

    resource.update(update_resource_params.slice(:personal_websites_attributes))

    yield resource if block_given?

    if invitation_accepted
      resource.participant.person_id = resource.person_id
      if Devise.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_accept_path_for(resource)
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, :location => new_session_path(resource_name)
      end
    else
      resource.build_unused_websites

      resource.invitation_token = raw_invitation_token
      respond_with_navigational(resource){ render 'members/invitations/edit' }
    end
  end

  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
      end

      respond_to do |format|
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Member Invited!', text = 'Invited #{resource.person.full_name}' );" }
      end
    else
      respond_to do |format|
        format.js { render 'admin/initializeForm', locals: {resource: @member, form_path: "members/form_invite", javascript_to_run: "bind_student_member_selection_to_dates();" } }
      end
    end
  end

end
