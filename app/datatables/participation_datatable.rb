class ParticipationDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :edit_admin_project_participation_path, :link_to, :admin_project_participation_path, :content_tag

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
          "",
          isMember_show(record.person),
          safe_show(record.participant.title),
          safe_show(record.person.firstName),
          safe_show(record.person.lastName),
          safe_show(record.participant.administrative_title),
          safe_show(record.participant.email),
          priority_show(record.priority, "participation","participations/#{record.id}", token),
          link_to(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_project_participation_path(project,record),
                  remote: true,  class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("Participant")' ),

          link_to(("<i class='fa fa-trash-o'></i> Remove From this Project").html_safe, admin_project_participation_path(project,record),
                  remote: true, method: :delete, data: { confirm: 'Are you sure yo want to delete this project participant?' }, class: "btn btn-danger btn-xs deleteButton" )
      ]
    end
  end

  def project
    @project = options[:project]
  end

  def token
    @token = options[:token]
  end

  def get_raw_records
    # insert query here
    #Participation.joins(:participant,:person).where("project_id = ?", project.id)
    Participation.includes(:participant).references(:participant).includes(:person).references(:person).where("project_id = ?", project.id)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
