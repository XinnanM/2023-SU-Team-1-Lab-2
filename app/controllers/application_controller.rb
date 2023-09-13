# Controllers for Application
class ApplicationController < ActionController::Base
    include Pagy::Backend
    # code for allowing users to choose their role; will need edited
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!

    # Checks if the current user is Admin. If not, deny access and return to the root page
    def is_admin
      if current_user && current_user.role != 'admin' || !current_user.user_approved
        redirect_to root_path, alert: 'Access denied. You must be an admin to access this page.'
      end
    end

    # Sends back admins who have yet been permitted to the root page
    def no_pending_admin
      if current_user && current_user.role == 'admin' && !current_user.user_approved
        redirect_to root_path, alert: 'Access denied. Pending admins cannot access this page.'
      end
    end

    private

    # Sets parameters that can be took in this page.
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    end

end
