class JournalDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :admin_publication_authors_path,:link_to,
  :edit_admin_journal_path, :link_to, :admin_publication_path, :content_tag,
  :link_to_button_column

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        'Publication.title',
        'Publication.date',
        'Journal.title',
        'Journal.volume',
        'Journal.issue'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
        'Publication.title',
        'Publication.date',
        'Journal.title',
        'Journal.volume',
        'Journal.issue'
    ]
  end

  private

  def data
    records.map do |record|
      [
          # comma separated list of the values for each cell of a table row
          # example: record.attribute,
          "",
          safe_show(record.publication.title),
          safe_show(record.title),
          safe_show(record.publication.date.strftime("%B %Y")),
          safe_show(record.volume),
          safe_show(record.issue),
          link_to_button_column(("<i class='fa fa-users'></i> Add/Remove Authors").html_safe, admin_publication_authors_path(record.publication),
                  class: "btn btn-default btn-xs authorsButton"),
          link_to_button_column(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_journal_path(record), remote: true,
                  class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("Journal")'),
          link_to_button_column(("<i class='fa fa-trash-o'></i> Delete").html_safe, admin_publication_path(record.publication),
                  method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this journal?' }, class: "btn btn-danger btn-xs deleteButton" )
      ]
    end
  end

  def get_raw_records
    # insert query here
    Journal.includes(:publication).references(:publication)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
