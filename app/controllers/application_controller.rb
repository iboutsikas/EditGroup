class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # customize the redirect path after a successfull sign in
  def after_sign_in_path_for(resource)
    if resource.isAdmin?
      admin_path
    else
      root_path
    end
  end


  protected

  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:invite).concat [:isAdmin, :isStudent, :invited_by_type,person_attributes:[:firstName,:lastName]]

    devise_parameter_sanitizer.for(:accept_invitation).concat [:bio, :avatar, :email, :password, :password_confirmation, :participant_id, :person_id,
                                                               participant_attributes:[:id,:title,:administrative_title,:email],
                                                               person_attributes: [:id,:firstName, :lastName],
                                                               personal_websites_attributes: [ :id, :url, :website_template_id, :_destroy]]
  end

end
