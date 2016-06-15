class InviteStatusDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :link_to_if, :admin_member_resend_invitation_path,
  :admin_member_path, :content_tag, :link_to_button_column, :boolean_show


  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        "Person.full_name",
        "Member.email",
        "Member.isAdmin",
        "Member.invitation_sent_at",
        "Member.invitation_accepted_at",
        "Member.invitation_status"
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
        "Person.full_name",
        "Member.email",
        "Member.isAdmin",
        "Member.invitation_sent_at",
        "Member.invitation_accepted_at",
        "Member.invitation_status"
    ]
  end

  private

  def data
    records.map do |record|
      [
          # comma separated list of the values for each cell of a table row
          # example: record.attribute,
          "",
          safe_show(record.person.full_name),
          safe_show(record.email),
          boolean_show(record.isAdmin),
          boolean_show(record.isStudent),
          invitation_sent_to_string(record),
          invitation_accepted_to_string(record),
          invitation_status_to_string(record),
          link_to_if(!record.invitation_pending?, ("<i class='fa fa-envelope-o' aria-hidden='true'></i> Resend Invitation").html_safe, '#', remote: true,
                  class:"btn btn-info btn-xs resendButton disabled", data: { tdclass: "buttonColumn" }) {
                  link_to_button_column(("<i class='fa fa-envelope-o' aria-hidden='true'></i> Resend Invitation").html_safe,
              admin_member_resend_invitation_path(record.id), remote: true, method: 'post', class:"btn btn-info btn-xs resendButton")
               } ,
          link_to_if(!record.invitation_pending?, ("<i class='fa fa-trash-o'></i> Cancel Invitation").html_safe, "#", method: :delete,
                  remote: true, data: { confirm: 'Are you sure you want to cancel this invitation?', tdclass: "buttonColumn" }, class: "btn btn-danger btn-xs cancelInvitationButton disabled" ) {
            link_to_button_column(("<i class='fa fa-trash-o'></i> Cancel Invitation").html_safe, admin_member_path(record), method: :delete,
               remote: true, data: { confirm: 'Are you sure?' }, class: "btn btn-danger btn-xs cancelInvitationButton" )  } ,
      ]
    end
  end

  def get_raw_records
    # insert query here
    #Member.includes(:participant).references(:participant).includes(:person).references(:person).where("members.invited_by_type is not null ")
    Member.includes(:participant).references(:participant).includes(:person).references(:person).where("members.invited_by_type is not null ")
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
#link_to(("<i class='fa fa-envelope-o' aria-hidden='true'></i> Resend Invitation").html_safe,
        #admin_member_resend_invitation_path(record.id), remote: true, class:"btn-info btn-xs", disable: record.invitation_pending?),
