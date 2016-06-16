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
    @projects = Project.all
  end

  def publications
    #@journals = Journal.all
    #@conferences = Conference.all
    #@conferences = Conference.includes(:authors, :publication)
    @citation_style = Preference.find_by_description('citation_style').value

    @publications = Publication.all.includes(:authors, :conference, :journal)
  end

  def newsevents
    @news = NewsEvent.all.order(date: :desc).group_by{|year| year.date.year}
  end

  def contact
  end
end
