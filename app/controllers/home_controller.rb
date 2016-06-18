class HomeController < ApplicationController

  def index

  end

  def about
  end

  # def members
  #   @members = Member.all
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: MemberDatatable.new(view_context) }
  #   end
  # end

  def projects
    pages = Preference.find_by_description('pagination_projects').value.to_i
    @projects = Project.all.paginate(:page => params[:page], :per_page => pages).includes(:participants).references(:participants)
  end

  def publications
    #@journals = Journal.all
    #@conferences = Conference.all
    #@conferences = Conference.includes(:authors, :publication)
    @citation_style = Preference.find_by_description('citation_style').value
    
    @publications = Publication.all.includes(:authors, :conference, :journal)
  end

  def newsevents
    pages = Preference.find_by_description('pagination_news').value.to_i
    logger.info pages
    @news = NewsEvent.all.paginate(:page => params[:page], :per_page => pages).order(date: :desc)
    @news_hash = @news.group_by{|year| year.date.year}
  end

  def contact
  end
end
