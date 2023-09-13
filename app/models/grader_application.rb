class GraderApplication < ApplicationRecord
  before_create :set_status_to_pending
  belongs_to :section
  validates :section, presence: true
  validates :grade_received, presence: true, length: { maximum: 2, minimum: 1 }
  validates :grade_received, inclusion: { in: %w(A A- B+ B B- C+ C C- D+ D E a a- b+ b b- c+ c c- d+ d e PA pa I i EM em K k NP np PE pe S s U u W w) }
  validate :end_time_after_start_time
  validate :unique_pair_and_section, on: :create

  # When user enters number values for the days of the week available, ie 1 = Monday 2 = Tuesday etc.
  def format_days_of_week
    days_names = %w(Mon Tue Wed Thu Fri Sat Sun)
    formatted_days = days_of_the_week_available.chars.map { |day| days_names[day.to_i - 1] }
    formatted_days.join(', ')
    return 'N/A' if (days_of_the_week_available == '') || formatted_days.nil?
    formatted_days
  end

  private

  # Validates that the end time schedule is after the start time
  def end_time_after_start_time
    return if time_end_available.blank? || time_start_available.blank?
    errors.add(:time_end_available, "must be after the start time") if time_end_available <= time_start_available
  end

  def set_status_to_pending
    self.status = 'Pending'
  end

   # Validates that user is not submitting an application to a section they already applied for.
  def unique_pair_and_section
    existing_application = GraderApplication.find_by(section: self.section, email: self.email)

    if existing_application && existing_application != self
      errors.add(:base, "You have already submit an application of this section.")
    end
  end

end
