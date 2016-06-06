class AuthorDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :link_to_if, :edit_admin_publication_author_path,
   :admin_publication_author_path, :content_tag, :fa_icon, :admin_publication_check_if_any_members_path

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
          isMember_show(record.person),
          safe_show(record.person.lastName),
          safe_show(record.person.firstName),
          link_to(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_publication_author_path(publication,record),
                  remote: true,  class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("Author")' ),
          link_to_if(record.person.isMember?,
            link_to(("<i class='fa fa-trash-o'></i> Remove From This Publication").html_safe, admin_publication_check_if_any_members_path(id: publication, author_id: record.id),
                    remote: true,
                    class: "btn btn-danger btn-xs deleteButton" )
            ) {
            link_to(("<i class='fa fa-trash-o'></i> Remove From This Publication").html_safe, admin_publication_author_path(publication,record),
                    remote: true, method: :delete,
                    data: { confirm: "Are you sure you want to remove #{record.person.full_name} from this publication?", confirm_button: "Yes, Remove It" },
                    class: "btn btn-danger btn-xs deleteButton" ) }
      ]
    end
  end

  def publication
    @publication = options[:publication]
  end

  def get_raw_records
    # insert query here
    Author.includes(:person).references(:person).where("publication_id = ?", publication.id)
  end

  # ==== Insert 'presenter'-like methods below if necessary
  # link_to(("<i class='fa fa-trash-o'></i> Remove From This Publication").html_safe, admin_publication_author_path(publication,record),
  #         remote: true, method: :delete,
  #         data: { confirm: "Are you sure you want to remove #{record.person.full_name} from this publication?", confirm_button: "Yes, Remove It" },
  #         class: "btn btn-danger btn-xs deleteButton" )
end
