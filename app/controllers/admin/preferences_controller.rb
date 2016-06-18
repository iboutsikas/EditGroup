class Admin::PreferencesController < Admin::DashboardController

  before_action :set_preference, only: [:update]

  include Admin::CitationStylesHelper

  def preferences
    preferences = Preference.all

    preferences.each do |p|
      case p.description

      when 'citation_style'
        @citation_style = p
        @styles = all_styles.values
      when 'publication_display'
        @publication_display = p
        @timeline_values = ["timeline", "default"]
      when 'pagination_publications'
        @pagination_publications = p
        @pagination_publications_values = [*1...99]
      when 'pagination_news'
        @pagination_news = p
        @pagination_news_values = [*1...99]
      when 'pagination_projects'
        @pagination_projects = p
        @pagination_projects_values = [*1...99]
      end

      # @citation_style = Preference.find_by_description('citation_style')
      # @styles = all_styles.values
      #
      # @publication_display = Preference.find_by_description('publication_display')
      # @timeline_values = ["timeline", "default"]
      #
      #
      # @pagination_publications = Preference.find_by_description('pagination_publications')
      # @pagination_publications_values = [*1...99]
      #
      # @pagination_news = Preference.find_by_description('pagination_news')
      # @pagination_news_values = [*1...99]
      #
      # @pagination_projects = Preference.find_by_description('pagination_projects')
      # @pagination_projects_values = [*1...99]
    end

    respond_to do |format|
      format.html
    end
  end

  def update
    case @preference.description
    when "citation_style"
      @new_value = all_styles.key(preference_params[:value])
    else
      @new_value = preference_params[:value]
    end

    respond_to do |format|
      if @preference.update(value: @new_value)
        format.js { render js: "showNotification('success', 'Preferences Updated', '#{@preference.description.humanize} is now set to #{@new_value.capitalize}');" }
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
