class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #code for making students auto-approved
  before_create :set_user_approval
  # code for creating user roles
  enum role: [:student, :instructor, :admin]
  # code for restricting email domain to "osu.edu"
  validates :email, format: { with: /\b[a-z]+\.([1-9][0-9]*)@osu\.edu\z/i, message: "must follow the lastname.\#@osu.edu convention." }
  # validates first name and last name are not null
  validates :first_name, presence: true
  validates :last_name, presence: true
  private

  before_destroy :unregister_sections

  # Sets the user approval to be false before creation, except for the default users made with db:seed
  def set_user_approval
    if(self.email != 'admin.1@osu.edu' && self.email != 'studenttest.1@osu.edu' && self.email != 'instructortest.1@osu.edu')
      self.user_approved = false
    end
  end

  # When user deletes account, removes all recommendations and applications associated with that account
  def unregister_sections
    @recommendations = Recommendation.where(instructor_email: self.email).or(Recommendation.where(student_email: self.email))
    @applications = GraderApplication.where(email: self.email)

    @applications.each do |app|
      if (app.status == 'Approved')
        Section.find_by(section_id: app.section_id).decrement(:current_num_required_graders, 1)
      end
    end

    @recommendations.each(&:delete)
    @applications.each(&:delete)
  end

end
