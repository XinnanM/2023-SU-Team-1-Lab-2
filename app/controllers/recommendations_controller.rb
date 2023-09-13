# Controller for the recommendation
class RecommendationsController < ApplicationController
  before_action :set_recommendation, only: %i[ show edit update destroy ]
  before_action :no_student

  # GET /recommendations or /recommendations.json
  def index
    @recommendations = Recommendation.all
    @pagy, @recommendations = pagy(@recommendations)
  end

  # GET /recommendations/1 or /recommendations/1.json
  def show
  end

  # GET /recommendations/new
  def new
    @recommendation = Recommendation.new
  end

  # GET /recommendations/1/edit
  def edit
  end

  # POST /recommendations or /recommendations.json
  def create
    @recommendation = Recommendation.new(recommendation_params)
    respond_to do |format|
      if @recommendation.save

        format.html { redirect_to recommendation_url(@recommendation), notice: "Recommendation was successfully created." }
        format.json { render :show, status: :created, location: @recommendation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recommendations/1 or /recommendations/1.json
  def update
    respond_to do |format|
      if @recommendation.update(recommendation_params)
        format.html { redirect_to recommendation_url(@recommendation), notice: "Recommendation was successfully updated." }
        format.json { render :show, status: :ok, location: @recommendation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommendations/1 or /recommendations/1.json
  def destroy
    @recommendation.destroy

    respond_to do |format|
      format.html { redirect_to recommendations_url, notice: "Recommendation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recommendation_params
    params.require(:recommendation).permit(:instructor_email, :course_id, :section_id, :student_email, :testimonial)
  end

  # Send student back to root page for admin/instructor only page
  def no_student
    if current_user && current_user.role == 'student' || !current_user.user_approved
      redirect_to root_path, alert: 'Access denied. Students cannot access this page.'
    end
  end
end
