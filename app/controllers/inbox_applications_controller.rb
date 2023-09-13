# frozen_string_literal: true

# Controller for the Inbox.
class InboxApplicationsController < ApplicationController
  before_action :is_admin

  def index
    @application = GraderApplication.all
    @pagy, @application = pagy(@application)
  end

  def update
    @section = Section.find(params[:section_id])
    @application = GraderApplication.where(email: params[:email], section_id: params[:section_id])
    # Paginate the applications
    @pagy, @application = pagy(@application)

    if params[:id] == 'approve'
      @section.increment!(:current_num_required_graders, 1)
      if @section.num_required_graders < @section.current_num_required_graders
        @section.increment!(:num_required_graders, 1)
      end
      @application.update(status: 'Approved')
    else
      @application.update(status: 'Denied')
    end
    render 'inbox_applications/index'
  end
end
