# Controller for the Permission Request

class PermissionRequestsController < ApplicationController
  before_action :is_admin

  # GET /permission_requests or /permission_requests.json
  def index
    @user = User.where(user_approved: false)
    @pagy, @user = pagy(@user)
  end

  def update
    @user = User.where(email: params[:email])
    if params[:id] == "approve"
      @user.update(user_approved: true)
    else
      @user.update(role: 0)
      @user.update(user_approved: false)
    end
    render "permission_requests/index"
  end
end
