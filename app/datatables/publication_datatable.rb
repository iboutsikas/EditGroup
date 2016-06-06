class PublicationDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :admin_publication_authors_path,:link_to, :edit_admin_publication_path, :link_to, :admin_publication_path, :content_tag

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        'Publication.title',
        'Publication.date'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
        'Publication.title',
        'Publication.date'
    ]
  end

  private

  def data
    records.map do |record|
      [
          # comma separated list of the values for each cell of a table row
          # example: record.attribute,
          safe_show(record.title),
          safe_show(record.date),
          safe_show(record.type),
          link_to(("<i class='fa fa-users'></i> Add/Remove Authors").html_safe, admin_publication_authors_path(record),
                  class: "btn btn-default btn-xs authorsButton"),

          link_to(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_publication_path(record), remote: true,
                  class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("Publication")'),

          link_to(("<i class='fa fa-trash-o'></i> Delete").html_safe, admin_publication_path(record), method: :delete,
                  remote: true, data: { confirm: 'Are you sure?' }, class: "btn btn-danger btn-xs deleteButton" )
      ]
    end
  end

  def get_raw_records
    # insert query here
    Publication.includes(:conference, :journal).references(:conference, :journal)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
