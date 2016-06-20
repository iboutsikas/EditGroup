class HomeController < ApplicationController

  def index

  end

  def about
  end

  def projects
    pages = Preference.find_by_description('pagination_projects').value.to_i
    @projects = Project.all.paginate(:page => params[:page], :per_page => pages).eager_load(participations: [{participant: :person}])
  end

  def publications
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

  def moutsounes
    
  end
end
