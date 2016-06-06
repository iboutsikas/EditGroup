class WebsiteTemplateDatatable < AjaxDatatablesRails::Base

  include Admin::DashboardHelper

  def_delegators :@view, :link_to, :edit_admin_website_template_path, :admin_website_template_path, :fa_icon, :content_tag, :image_tag

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        'WebsiteTemplate.website_name'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
        'WebsiteTemplate.website_name'
    ]
  end

  private

  def data
    records.map do |record|
      [
          "",
          logo_show(record, image_style="width: 29px; height: 29px;", default_image_style="font-size: 28.9px", div_class="website_logo"),
          safe_show(record.website_name),
          link_to(("<i class='fa fa-pencil'></i> Edit").html_safe, edit_admin_website_template_path(record), remote: true,
                  class:"btn btn-info btn-xs editButton", onclick: 'editButtonPressed("Website Template")' ),
          link_to(("<i class='fa fa-trash-o'></i> Delete").html_safe, admin_website_template_path(record), remote: true,
                  method: :delete, data: { confirm: 'Are you sure you want to delete this website type? ' }, class: "btn btn-danger btn-xs deleteButton" )
      ]
    end
  end

  def get_raw_records
    # insert query here
    WebsiteTemplate.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
