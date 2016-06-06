class PersonalWebsiteDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :edit_admin_member_personal_website_path, :admin_member_personal_website_path, :fa_icon,:content_tag, :image_tag

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        'WebsiteTemplate.website_name',
        'PersonalWebsite.url'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
        'WebsiteTemplate.website_name',
        'PersonalWebsite.url'
    ]
  end

  private

  def data
    records.map do |record|
      [
          # comma separated list of the values for each cell of a table row
          # example: record.attribute,
          "",
          logo_show(record.website_template, image_style="width: 29px; height: 29px;", default_image_style="font-size: 28.9px", div_class="website_logo"),
          safe_show(record.website_name),
          safe_show(record.url),
          link_to(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_member_personal_website_path(member,record),
                  remote: true,  class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("Personal Website")' ),
          link_to(("<i class='fa fa-trash-o'></i> Delete").html_safe, admin_member_personal_website_path(member,record),
                  remote: true, method: :delete, data: { confirm: 'Are you sure you want to delete this personal website?' }, class: "btn btn-danger btn-xs deleteButton" )
      ]
    end
  end

  def member
    @member = options[:member]
  end

  def get_raw_records
    # insert query here
    PersonalWebsite.where("member_id = ?", member.id).includes(:website_template).references(:website_template)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
