class PublicationsController < ApplicationController

  before_action :set_publication, only: [:show]

  def index
    @publications = Publication.all
  end

  def show

  end

  def set_publication
    @publication = Publication.find(params[:id])
  end

end
