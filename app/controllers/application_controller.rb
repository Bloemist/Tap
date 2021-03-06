class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, flash: { error: message_for(exception) }
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  private

  def message_for exception
    if exception.subject.class == Order && [:new, :create].include?(exception.action)
      "Betaal uw fucking schulden!"
    else
      exception.message
    end
  end
end
