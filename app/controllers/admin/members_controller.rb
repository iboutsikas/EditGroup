require 'json'
class Admin::MembersController < Admin::DashboardController
  before_action :set_member, only: [:show, :edit, :update, :destroy, :change_password, :resend_invitation, :destroy_check_for_publications, :edit_profile_page]

  def index
    respond_to do |format|
      format.html
      format.json { render json: MemberDatatable.new(view_context,{ current_member: current_member }) }
    end
  end

  def invites_index
    respond_to do |format|
      format.html
      format.json { render json: InviteStatusDatatable.new(view_context) }
    end
  end

  def student_members_index
    respond_to do |format|
      format.html
      format.json { render json: StudentMembersDatatable.new(view_context, { current_member: current_member }) }
    end
  end

  def show
    @websites = @member.personal_websites
  end

  def new
    @member = Member.new
    @participant = @member.build_participant
    @person = @member.build_person
    @personal_websites = @member.personal_websites.build

    if params[:type] == "student"
      @member.isStudent = true
      @student_member = true
    end

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @member, form_path: "members/form" } }
    end
  end

  def edit
    unless @member.personal_websites.any?
      @personal_website = @member.personal_websites.build
    end
    respond_to do |format|
      if @member.isStudent
        @student_member = true
      else
        @edit = true
      end
      format.js { render 'admin/initializeForm', locals: {resource: @member, form_path: "members/form"} }
    end
  end

  # Display the form for setting a new member password
  def change_password
    respond_to do |format|
      @change_password = true
      format.js { render 'admin/initializeForm', locals: {resource: @member, form_path: "members/form" } }
    end
  end

  def create
    @member = Member.new(member_params.except(:person_attributes, :participant_attributes))
    @member.participant = Participant.new(member_params[:participant_attributes])
    @member.person = Person.new(member_params[:person_attributes])

    @member.avatar = AvatarUploader.new(member_params[:avatar])
    respond_to do |format|
      if @member.save
        @member.participant.person_id = @member.person_id
        @member.participant.save

        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Member Created!', text = 'Created #{@member.full_name}' );"  }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @member, form_path: "members/form" } }
      end
    end
  end

  def invite
    @member = Member.new
    @member.person = Person.new

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @member, form_path: "members/form_invite" } }
    end
  end

  def resend_invitation
    respond_to do |format|
      if @member.resend_invitation(current_member)
        format.js { render js: "redraw_table();
                              showNotification(type = 'success', title = 'Invitation Resent', text = 'Reasent invitation at: #{@member.email}' );"  }
      else
        logger.info "Invitation resend failed"
        format.js { render js: 'redraw_table()' }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'info', title = 'Edit Successful', text = 'Edited #{@member.full_name}' );" }
      else
        unless member_params[:person_attributes]
          @change_password = true
        end
        format.js { render 'admin/initializeForm', locals: {resource: @member, form_path: "members/form" } }
      end
    end
  end

  def destroy_check_for_publications
############ RIGHT NOW IT IS RETURNING ALL THE PUBLICATIONS FOR THE MEMBER. FIX
    #@publications = @member.publications_to_delete
    @publications = []

    respond_to do |format|
      if ( @publications.any? )
        @publications_string = @publications.map { |p| "<li>" + p.title + "</li>" }.join(" ")
        format.js { render "admin/initialize_confirmation_modal",
          locals: { modal_type: "member_remove_publications", member_id: @member.id, publications_string_array: @publications_string, member_name: @member.full_name } }
      else
        format.js { render "admin/initialize_confirmation_modal",
          locals: { modal_type: "member_remove", member_id: @member.id } }
      end
    end
  end

  def destroy_with_publications

    logger.info "destroy with publications"
    @publications = @member.publications_to_delete

    @publications.each { |p| p.destroy }

    @member.destroy

    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'error', title = 'Member Deleted!', text = 'Deleted #{@member.full_name}' );"  }
    end
  end

  def destroy
    full_name = @member.full_name
    @member.destroy

    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'error', title = 'Member Deleted!', text = 'Deleted #{full_name}' );"  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:bio, :avatar, :id,:email, :password, :password_confirmation, :isAdmin, :isStudent, :member_from, :member_to, :participant_id, :person_id, :invited_by_type,
                                     participant_attributes:[:id,:title,:administrative_title,:email],
                                     person_attributes: [:id,:firstName, :lastName],
                                     personal_websites_attributes: [ :id, :url, :website_template_id, :_destroy] )
    end
end
