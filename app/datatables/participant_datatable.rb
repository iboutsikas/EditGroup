class ParticipantDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :edit_admin_participant_path, :link_to, :admin_participant_path, :content_tag

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        'Participant.title',
        'Person.firstName',
        'Person.lastName',
        'Participant.administrative_title',
        'Participant.email'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
        'Participant.title',
        'Person.firstName',
        'Person.lastName',
        'Participant.administrative_title',
        'Participant.email'
    ]
  end

  private

  def data
    records.map do |record|
      [
          # comma separated list of the values for each cell of a table row
          # example: record.attribute,
          safe_show(record.title),
          safe_show(record.person.firstName),
          safe_show(record.person.lastName),
          safe_show(record.administrative_title),
          safe_show(record.email),
          link_to(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_participant_path(record),
                  remote: true,  class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("Participant")' ),

          link_to(("<i class='fa fa-trash-o'></i> Delete").html_safe, admin_participant_path(record),
                  remote: true, method: :delete, data: { confirm: "Participant #{record.person.full_name} is about to be permanently deleted from all Projects and from the Database. Note that they will also be removed from any Publications. Are you sure?" },
                  class: "btn btn-danger btn-xs deleteButton" )
      ]
    end
  end

  def get_raw_records
    # insert query here
    Participant.includes(:person).references(:person)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
