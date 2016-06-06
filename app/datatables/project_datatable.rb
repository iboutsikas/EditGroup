class ProjectDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :content_tag,:admin_project_path,:link_to, :edit_admin_project_path, :link_to, :admin_project_participations_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        'Project.title',
        'Project.motto',
        'Project.description',
        'Project.date_started',
        'Project.website',
        'Project.video'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Project.title', 'Project.motto']
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        "",
        safe_show(record.title),
        safe_show(record.motto),
        safe_show(record.description),
        safe_show(record.date_started),
        safe_show(record.website),
        safe_show(record.video),
        link_to(("<i class='fa fa-users'></i> Participants").html_safe, admin_project_participations_path(record),
            class: "btn btn-default btn-xs participantsButton", id: "participantButton"),

        link_to(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_project_path(record), remote: true,
                class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("Project")'),

        link_to(("<i class='fa fa-trash-o'></i> Delete").html_safe, admin_project_path(record), method: :delete,
                remote: true, data: { confirm: 'Are you sure you want to delete this project?' }, class: "btn btn-danger btn-xs deleteButton" )
      ]
    end
  end

  def get_raw_records
    # insert query here
    Project.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
