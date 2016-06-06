class PersonDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :link_to_if, :edit_admin_person_path, :admin_person_path, :content_tag

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        'Person.firstName',
        'Person.lastName'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
        'Person.firstName',
        'Person.lastName'
    ]
  end

  private

  def data
    records.map do |record|
      [
          # comma separated list of the values for each cell of a table row
          # example: record.attribute,
          safe_show(record.firstName),
          safe_show(record.lastName),
          link_to(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_person_path(record), remote: true,
                  class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("Author")' ),

          link_to(("<i class='fa fa-trash-o'></i> Delete").html_safe, admin_person_path(record), method: :delete,
                  remote: true, data: { confirm: "Author #{record.full_name} is about to be permanently deleted from all Publications and from the Database. Are you sure?" },
                  class: "btn btn-danger btn-xs deleteButton" )
      ]
    end
  end

  def get_raw_records
    # insert query here
    Person.where("people.id not in ( select members.person_id from members )")
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
