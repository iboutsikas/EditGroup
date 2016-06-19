class PublicationsController < ApplicationController

  before_action :set_publication, only: [:show]

  def index
    pref = Preference.find_by_description("publication_display")

    if (pref.value == "timeline")
      @publications = Publication.all.includes(:authors).references(:authors)
      render "publications-timeline"
    else
      @citation = Preference.find_by_description("citation_style").value
      pages = Preference.find_by_description("pagination_publications").value
      @publications = Publication.search(params)
                                 .paginate(:page => params[:page], :per_page => pages)
                                 .includes(:authors).references(:authors)

      render "publications-default"
    end
  end

  def show

  end

  private

    def set_publication
      @publication = Publication.find(params[:id])
    end

    def dummy

    end
end
