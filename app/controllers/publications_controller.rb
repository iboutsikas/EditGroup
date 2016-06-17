class PublicationsController < ApplicationController

  before_action :set_publication, only: [:show]

  def index
    #@publications = Publication.all.includes(:journal, :conference, :authors)
    @publications = Publication.all.includes(:authors).references(:authors)
    pref = Preference.find_by_description("publication_display")

    if (pref.value == "timeline")
      render "publications-timeline"
    else
      @citation = Preference.find_by_description("citation_style").value
      render "publications-default"
    end
  end

  def show

  end

  def set_publication
    @publication = Publication.find(params[:id])
  end

  def dummy

  end
end
