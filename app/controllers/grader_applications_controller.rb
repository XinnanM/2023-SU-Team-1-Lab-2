# Controller for Grader Application page
class GraderApplicationsController < ApplicationController
  before_action :set_grader_application, only: %i[ show edit update destroy ]
  before_action :authenticate_student, only: [:new, :create]
  before_action :no_instructor
  before_action :no_pending_admin

  # GET /grader_applications or /grader_applications.json
  def index
    @grader_applications = GraderApplication.all
    @pagy, @grader_applications = pagy(@grader_applications)
  end

  # GET /grader_applications/1 or /grader_applications/1.json
  def show
  end

  # GET /grader_applications/new
  def new
    @grader_application = GraderApplication.new
  end

  # GET /grader_applications/1/edit
  def edit
  end

  def create
    @grader_application = GraderApplication.new(grader_application_params)

    respond_to do |format|
      if @grader_application.save
        format.html { redirect_to grader_application_url(@grader_application), notice: "Grader application was successfully created." }
        format.json { render :show, status: :created, location: @grader_application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @grader_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grader_applications/1 or /grader_applications/1.json
  def update
    respond_to do |format|
      if @grader_application.update(grader_application_params)
        format.html { redirect_to grader_application_url(@grader_application), notice: "Grader application was successfully updated." }
        format.json { render :show, status: :ok, location: @grader_application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @grader_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grader_applications/1 or /grader_applications/1.json
  def destroy
    @grader_application.destroy
    respond_to do |format|
      format.html { redirect_to grader_applications_url, notice: "Grader application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_grader_application
    @grader_application = GraderApplication.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def grader_application_params
    params.require(:grader_application).permit(:first_name, :last_name, :email, :course_id, :section_id, :schedule, :grade_received, :days_of_the_week_available, :time_start_available, :time_end_available)
  end

  # Authenticate if the current user is a student
  def authenticate_student
    unless current_user&.student?
      redirect_to root_path, alert: 'You must be a student to apply for a grader position.'
    end
  end

  # Sends back instructor user back for pages that is not open for instructors
  def no_instructor
    if current_user && current_user.role == 'instructor'
      redirect_to root_path, alert: 'You do not have access for this page.'
    end
  end
end
