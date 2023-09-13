class AddStatusToGraderApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :grader_applications, :status, :string
  end
end
