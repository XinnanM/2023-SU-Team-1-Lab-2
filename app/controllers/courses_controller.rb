# frozen_string_literal: true
require 'ransack'
# Controller of the Course. Handles business operations here
class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]
  before_action :is_admin, only: %i[ new edit create destroy ]

  # GET /courses or /courses.json
  def index
    @q = Course.ransack(params[:q])
    @courses = @q.result
    @pagy, @courses = pagy(Course.ransack(params[:q]).result(distinct: true))
  end

  # GET /courses/1 or /courses/1.json
  def show
    @p = Section.where(course_id: @course.course_id).ransack(params[:p])
    @sections = @p.result
    @pagy, @sections = pagy(Section.where(course_id: @course.course_id).ransack(params[:q]).result(distinct: true))
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    @course.course_id = generate_course_id if @course.course_id.nil?

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: 'Course has been successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:course_id, :catalog_number, :course_description, :course_name, :academic_career)
  end

  # Assign course id for new courses. Always assign 100000 to the current maximum +1.
  def generate_course_id
    max_course_id = Course.maximum(:course_id)
    return max_course_id.nil? ? 100000 : max_course_id + 1
  end

end
