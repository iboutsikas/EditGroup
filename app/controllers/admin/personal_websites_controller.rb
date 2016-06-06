class Admin::PersonalWebsitesController < Admin::DashboardController
  before_action :set_member, except: [:destroy, :update]
  before_action :set_personal_website, only: [:edit, :update, :destroy]

  # GET /personal_websites
  # GET /personal_websites.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: PersonalWebsiteDatatable.new(view_context,{ member: @member }) }
    end
  end

  def new
    @personal_website = @member.personal_websites.build
    @available_templates = WebsiteTemplate.find_by_sql [" select * from website_templates where id not in
                                                          (select website_template_id from personal_websites, members
                                                              where personal_websites.member_id = members.id and members.id = ?) ", @member.id ]

    respond_to do |format|
      if @available_templates.any?
        format.js { render 'admin/initializeForm', locals: {resource: @personal_website, form_path: "personal_websites/form"} }
      end
        format.js { render js: '$(".modal .modal-body").html("You have added all the available websites for this member. You can add a different website type from Website Templates");' }
    end
  end

  # GET /personal_websites/1/edit
  def edit
    @available_templates = []
    @available_templates << @personal_website.website_template
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @personal_website, form_path: "personal_websites/form" } }
    end
  end

  # POST /personal_websites
  # POST /personal_websites.json
  def create
    @personal_website = PersonalWebsite.new(personal_website_params)

    respond_to do |format|
      if @member.personal_websites << @personal_website
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'Personal Website Created!', text = 'Created #{@personal_website.website_template.website_name} for ' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @personal_website, form_path: "personal_websites/form" } }
      end
    end
  end

  # PATCH
  def create_multiple
    binding.pry
  end

  # PATCH/PUT /personal_websites/1
  # PATCH/PUT /personal_websites/1.json
  def update
    respond_to do |format|
      if @personal_website.update(personal_website_params)
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'info', title = 'Edit Successful', text = 'Edited #{@personal_website.website_template.website_name}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @personal_website, form_path: "personal_websites/form" } }
      end
    end
  end

  # DELETE /personal_websites/1
  # DELETE /personal_websites/1.json
  def destroy
    @personal_website.destroy
    respond_to do |format|
      format.js { render js: "redraw_table();
                              showNotification(type = 'error', title = 'Personal Website Deleted!', text = 'Deleted #{@personal_website.website_template.website_name}' );"  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal_website
      @personal_website = PersonalWebsite.find(params[:id])
    end

    def set_member
      if params[:member_id]
        @member = Member.find(params[:member_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_website_params
      params.require(:personal_website).permit(:website_template_id , :url, personal_website_attributes:[:id, :url, :website_template_id])
    end
end
