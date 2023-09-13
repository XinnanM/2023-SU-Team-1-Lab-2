# frozen_string_literal: true

# Section model of the course. Each section represents a class taught by different professor or in different time.\
# @belongs_to Course
# @key [Integer] section_id
# @requires section_id is UNIQUE and must PRESENT
# @requires campus must PRESENT
# @requires term_id must PRESENT
# @requires section_number is UNIQUE and must PRESENT with format of XXXX
# @requires meeting_days is at most 7-digits from 1-7 and number must be unique
# @requires course must PRESENT
# @requires end_time must AFTER start_time
# @updates catalog_number = self.course.catalog_number
class Section < ApplicationRecord
  self.primary_key = :section_id
  default_scope { order(catalog_number: :asc, section_number: :asc) }
  belongs_to :course, class_name: 'Course', foreign_key: 'course_id', required: false
  validates :section_id, uniqueness: true, presence: true
  validates :campus, presence: true
  validates :term_id, presence: true
  validates :section_number, presence: true
  validate :auto_fill_or_validate_section_number
  validate :validate_meeting_days
  validates :course, presence: true
  validate :end_time_after_start_time
  validates :instructor_email, allow_blank: true, allow_nil: true, format: { with: /\b[a-z]+\.([1-9][0-9]*)@osu\.edu\z/i, message: "Instructor email must follow the lastname.\#@osu.edu convention or leave blank." }
  before_save :update_field

  # When user enters number values for the days of the week available, ie 1 = Monday 2 = Tuesday etc.
  def format_days_of_week
    days_names = %w(Mon Tue Wed Thu Fri Sat Sun)
    formatted_days = days_of_week.chars.map { |day| days_names[day.to_i - 1] }
    formatted_days.join(', ')
    return 'Online, N/A or TBA' if (days_of_week == '') || formatted_days.nil?

    formatted_days
  end

   # If the info is nil, like for sections times, or if section is only, display "N/A or TBA" to the user
  def self.nil_wrapper(info)
    wrapped_info = info
    wrapped_info = 'N/A or TBA' if (info == '') || info.nil?
    wrapped_info
  end

  # Drop down section text that includes all information that is needed
  def section_identifier
    course_description = self.course.course_name
    course_description = self.course.short_description if !self.course.short_description.nil?
    time_start_str = self.time_start ? self.time_start.strftime("%I:%M %p") : ""
    time_end_str = self.time_end ? self.time_end.strftime("%I:%M %p") : ""
    "CSE #{self.course.catalog_number} - #{course_description}(#{self.section_number}) - #{self.instructor_name} - #{self.format_days_of_week} - #{time_start_str} - #{time_end_str} - #{self.location}, Grader Positions Remaining: #{self.num_required_graders - self.current_num_required_graders}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["campus", "catalog_number", "course_id", "created_at", "current_num_required_graders", "days_of_week", "instructor_email", "instructor_name", "location", "num_required_graders", "section_id", "section_number", "term_id", "time_end", "time_start", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["course"]
  end

   # Updates the related course and grader values when section is created
  def update_field
    course = Course.find_by(course_id: self.course_id)
    self.catalog_number = course&.catalog_number
    self.num_required_graders ||= 1
    self.current_num_required_graders ||= 0
    self.current_num_required_graders = [self.current_num_required_graders, 0].max
  end

  private

  # Validation that user is entering accurate integers that can be mapped.
  def validate_meeting_days
    return unless days_of_week.present?

    valid_digits = %w[1 2 3 4 5 6 7]
    invalid_chars = days_of_week.chars.uniq - valid_digits

    if invalid_chars.any?
      errors.add(:days_of_week, 'Meeting days should only contain digits 1 to 7.')
    elsif days_of_week.chars.uniq.size > 7
      errors.add(:days_of_week, 'Meeting days should have at most 7 distinct digits.')
    end
  end

   # Auto fills section number if blank, or validates that it is 4 digits
  def auto_fill_or_validate_section_number
    return if section_number.match?(/\A\d{4}\z/)

    self.section_number = self.section_number.rjust(4, '0') if section_number.length < 4
    if self.section_number.match?(/\A\d{4}\z/)
      return
    else
      errors.add(:section_number, "Section number can only be 4-digits. Actual: #{:section_number}")
    end
  end

  # Validates that the end time schedule is after the start time
  def end_time_after_start_time
    return if time_end.blank? || time_start.blank?
    errors.add(:time_end, "must be after the start time") if time_end < time_start
  end
end

