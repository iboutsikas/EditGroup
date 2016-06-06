class NewsEventDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :admin_news_event_path,:link_to, :edit_admin_news_event_path, :link_to, :content_tag

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        'NewsEvent.date',
        'NewsEvent.title',
        'NewsEvent.description'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
        'NewsEvent.date',
        'NewsEvent.title'
    ]
  end

  private

  def data
    records.map do |record|
      [
          # comma separated list of the values for each cell of a table row
          # example: record.attribute,
          safe_show(record.date),
          safe_show(record.title),
          safe_show(record.description),
          link_to(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_news_event_path(record), remote: true,
                  class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("News-Events")'),
          link_to(("<i class='fa fa-trash-o'></i> Delete").html_safe, admin_news_event_path(record), method: :delete,
                  remote: true, data: { confirm: 'Are you sure?' }, class: "btn btn-danger btn-xs deleteButton" )
      ]
    end
  end

  def get_raw_records
    # insert query here
    NewsEvent.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
