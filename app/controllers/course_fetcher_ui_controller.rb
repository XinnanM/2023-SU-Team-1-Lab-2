# Controller for Course Fetcher UI
class CourseFetcherUiController < ApplicationController
  before_action :is_admin
  def index
  end

  # Fetch course by user's command. Return message if either field is not filled.
  def fetch_courses
    campus = params[:campus].presence || params[:custom_campus].presence
    term = params[:term].presence || params[:custom_term].presence

    if campus.blank? || term.blank?
      redirect_to course_fetcher_ui_index_path, alert: 'Please select a valid campus and term.'
    elsif !campus.is_a?(String)
      redirect_to course_fetcher_ui_index_path, alert: 'Campus must be a string.'
    elsif !term.to_s.match?(/\A\d+\z/)
      redirect_to course_fetcher_ui_index_path, alert: 'Term must be an integer.'
    else
      CourseFetcher.clean_fetch(campus, term.to_i)
      redirect_to course_fetcher_ui_index_path, notice: 'Courses fetched successfully!'
    end
  end

  # Spare method: update the database using most recent message.
  def update_courses
    campus = params[:campus].presence
    term = params[:term].presence

    if campus.blank? || term.blank?
      redirect_to course_fetcher_ui_index_path, alert: 'Please select a valid campus and term.'
    elsif !campus.is_a?(String)
      redirect_to course_fetcher_ui_index_path, alert: 'Campus must be a string.'
    elsif !term.to_s.match?(/\A\d+\z/)
      redirect_to course_fetcher_ui_index_path, alert: 'Term must be an integer.'
    else
      CourseFetcher.fetch(campus, term.to_i)
      redirect_to course_fetcher_ui_index_path, notice: 'Courses fetched successfully!'
    end
  end
  
end
