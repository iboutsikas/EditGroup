class PublicationsController < ApplicationController

  before_action :set_publication, only: [:show]

  def index
    @publications = Publication.all
    pref = Preference.find_by_description("publication_display")

    if (pref.value == "timeline")
      render "publications-timeline"
    else
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
