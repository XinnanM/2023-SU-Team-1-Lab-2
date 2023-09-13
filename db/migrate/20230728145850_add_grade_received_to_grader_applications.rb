class AddGradeReceivedToGraderApplications < ActiveRecord::Migration[7.0]
  def change
    #can only be valid letter grade
    add_column :grader_applications, :grade_received, :string
  end
end
