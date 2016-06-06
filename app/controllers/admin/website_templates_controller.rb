class Admin::WebsiteTemplatesController < Admin::DashboardController
  before_action :set_website_template, only: [:edit, :update, :destroy]

  # GET /personal_websites
  # GET /personal_websites.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: WebsiteTemplateDatatable.new(view_context) }
    end
  end

  def new
    @website_template = WebsiteTemplate.new

    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @website_template, form_path: "website_templates/form"} }
    end
  end

  # GET /personal_websites/1/edit
  def edit
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @website_template, form_path: "website_templates/form" } }
    end
  end

  # POST /personal_websites
  # POST /personal_websites.json
  def create
    @website_template = WebsiteTemplate.new(website_template_params)

    respond_to do |format|
      if @website_template.save
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Website Type Created!', text = 'Created #{@website_template.website_name}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @website_template, form_path: "website_templates/form" } }
      end
    end
  end

  # PATCH/PUT /personal_websites/1
  # PATCH/PUT /personal_websites/1.json
  def update
    respond_to do |format|
      if @website_template.update(website_template_params)
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'info', title = 'Edit Successful', text = 'Edited #{@website_template.website_name}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @website_template, form_path: "personal_websites/form" } }
      end
    end
  end

  # DELETE /personal_websites/1
  # DELETE /personal_websites/1.json
  def destroy
    @website_template.destroy
    respond_to do |format|
      format.js { render js: "hide_and_redraw();
                              showNotification(type = 'error', title = 'Website Type Deleted!', text = 'Deleted #{@website_template.website_name}' );"  }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_website_template
    @website_template = WebsiteTemplate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def website_template_params
    params.require(:website_template).permit(:website_name, :logo)
  end
end
