class Admin::PreferencesController < Admin::DashboardController

  before_action :set_preference, only: [:update]

  include Admin::CitationStylesHelper

  def preferences
    @citation_style = Preference.find_by_description('citation_style')
    @styles = all_styles.values

    @show_timeline = Preference.find_by_description('show_timeline')
    @timeline_values = ["true", "false"]

    respond_to do |format|
      format.html
    end
  end

  def update
    case @preference.description
    when "citation_style"
      @new_value = all_styles.key(params[:value])
    else
      @new_value = params[:value]
    end

    respond_to do |format|
      if @preference.update(value: @new_value)
        format.js { render js: "showNotification('success', 'Preferences Updated', 'Now using #{@new_value}');" }
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
    params.require(:preference).permit(:id, :value,:citation_style)
  end
end
