require 'pry'

class Admin::PreferencesController < Admin::DashboardController

  before_action :set_preference, only: [:update]

  include Admin::CitationStylesHelper

  def preferences
    @citation_style = Preference.find_by_description('citation_style')
    @styles = all_styles.values

    respond_to do |format|
      format.html
    end
  end

  def update
    @new_value = all_styles.key(params[:value])

    respond_to do |format|
      if @preference.update(value: @new_value)
        format.js { render js: "showNotification('success', 'Citation Style Changed', 'Now using #{params[:value]}');" }
      else
        format.js { render js: "showNotification('error', 'Error!, 'An error has occured while editing the citation style.);" }
      end

    end
  end

  private

  def set_preference
    @preference = Preference.find(preference_params[:id])
  end

  def preference_params
    params.require(:preference).permit(:id, :citation_style)
  end
end
