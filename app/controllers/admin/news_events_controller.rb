class Admin::NewsEventsController < Admin::DashboardController
  before_action :set_news_event, only: [:show, :edit, :update, :destroy]

  # GET /news_events
  # GET /news_events.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: NewsEventDatatable.new(view_context) }
    end
  end

  # GET /news_events/1
  # GET /news_events/1.json
  def show
  end

  # GET /news_events/new
  def new
    @news_event = NewsEvent.new
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: {resource: @news_event, form_path: "news_events/form" } }
    end
  end

  # GET /news_events/1/edit
  def edit
    respond_to do |format|
      format.js { render template: 'admin/initializeForm', locals: {resource: @news_event, form_path: "news_events/form"} }
    end
  end

  # POST /news_events
  # POST /news_events.json
  def create
    @news_event = NewsEvent.new(news_event_params)

    respond_to do |format|
      if @news_event.save
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'success', title = 'News-Event Created!', text = 'Created #{@news_event.title}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @news_event, form_path: "news_events/form" } }
      end
    end
  end

  # PATCH/PUT /news_events/1
  # PATCH/PUT /news_events/1.json
  def update
    respond_to do |format|
      if @news_event.update(news_event_params)
        format.js { render js: "hide_and_redraw();
                                showNotification(type = 'info', title = 'Edit Successful', text = 'Edited #{@news_event.title}' );" }
      else
        format.js { render 'admin/initializeForm', locals: {resource: @news_event, form_path: "news_events/form" } }
      end
    end
  end

  # DELETE /news_events/1
  # DELETE /news_events/1.json
  def destroy
    @news_event.destroy
    respond_to do |format|
      format.js { render js: "redraw_table();
                              showNotification(type = 'error', title = 'News-Event Deleted!', text = 'Deleted #{@news_event.title}' );"  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_event
      @news_event = NewsEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_event_params
      params.require(:news_event).permit(:date, :description, :title, :content)
    end
end
