class ChangeNameToFirstNameAndAddLastNameToGraderApplications < ActiveRecord::Migration[7.0]
  def change
    rename_column :grader_applications, :name, :first_name
    add_column :grader_applications, :last_name, :string
  end
end
