class PublicationsController < ApplicationController
  include ApplicationHelper
  before_action :set_publication, only: [:show]

  def index
    pref = Preference.find_by_description("publication_display")

    if (pref.value == "timeline")
      @publications = Publication.all.eager_load(:authors)
                                     .eager_load(:people)
      render "publications-timeline"
    else
      @citation = Preference.find_by_description("citation_style").value
      @pages = Preference.find_by_description("pagination_publications").value

      if params.length > 2
        @publications = Publication.search(params)
                                   .paginate(:page => params[:page], :per_page => @pages)
                                   .eager_load(authors: :person)
     else
        @publications = Publication.paginate(:page => params[:page], :per_page => @pages)
                                  .eager_load(authors: :person)
     end

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
