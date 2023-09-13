class RenameScheduleAndAddTimeColumnsToGraderApplications < ActiveRecord::Migration[7.0]
  def change
    change_column :grader_applications, :schedule, :string
    rename_column :grader_applications, :schedule, :days_of_the_week_available
    add_column :grader_applications, :time_start_available, :time
    add_column :grader_applications, :time_end_available, :time
  end
end
