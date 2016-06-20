class PublicationsController < ApplicationController
  include ApplicationHelper
  before_action :set_publication, only: [:show]

  def index
    pref = Preference.find_by_description("publication_display")

    if (pref.value == "timeline")
      @citation = Preference.find_by_description("citation_style").value
      @publications = Publication.all.eager_load(authors: :people)
      @citation_list = generate_citations(@publications, @citation)
      render "publications-timeline"
    else
      @citation = Preference.find_by_description("citation_style").value
      @pages = Preference.find_by_description("pagination_publications").value.to_i

      @publications = Publication.search(params)
                                 .paginate(:page => params[:page], :per_page => @pages)
                                 .eager_load(authors: :person)

     @citation_list = generate_citations(@publications, @citation)

     render "publications-default"
    end
  end

  def show

  end

  private

    def set_publication
      @publication = Publication.find(params[:id])
    end

end
