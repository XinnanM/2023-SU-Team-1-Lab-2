class Recommendation < ApplicationRecord

  belongs_to :section
  validate :unique_pair_and_section
  validates :section, presence: true
  validates :instructor_email, presence: true, format: { with: /\b[a-z]+\.([1-9][0-9]*)@osu\.edu\z/i, message: "Instructor email must follow the lastname.\#@osu.edu convention." }
  validates :student_email, presence: true, format: { with: /\b[a-z]+\.([1-9][0-9]*)@osu\.edu\z/i, message: "Student email must follow the lastname.\#@osu.edu convention." }
  validate :validate_non_student_role
  before_save :verify_user_is_present

  private
# Validates that instructor is not submitting a recommendation to a student they already recommended for their section.
  def validate_non_student_role
    existing_user = User.find_by(email: self.student_email)
    if existing_user && (existing_user.role == "admin" || existing_user.role == "instructor")
      errors.add(:base, 'Recommendation cannot be sent to admins or instructors!')
    end
  end

# If instructor makes a recommednation and the student does not have an email, creates an email with temp name and password
  def verify_user_is_present
    existing_user = User.find_by(email: self.student_email)
    if !existing_user
      User.create(email: self.student_email, password: "123123", password_confirmation: "123123", role: "student", first_name: "Brutus", last_name: "Buckeye")
    end
  end

# Validates that student does not already have a recommendation for this section
  def unique_pair_and_section
    existing_application = Recommendation.find_by(section: self.section, student_email: self.student_email)

    if existing_application && existing_application != self
      errors.add(:base, 'This student already has a recommendation of this section.')
    end
  end
end
