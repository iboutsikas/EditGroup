class Admin::DashboardController < ApplicationController
  layout 'dashboard'

  before_filter :authenticate_member!
  before_filter do
    redirect_to root_path unless current_member && current_member.isAdmin?
  end

  def index
  end

  def preferences
    respond_to do |format|
      format.html
    end
  end

end
