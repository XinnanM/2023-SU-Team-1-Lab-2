class CreateGraderApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :grader_applications do |t|
      t.string :name
      t.string :email
      t.integer :course_id
      t.integer :section_id
      t.text :schedule

      t.timestamps
    end
  end
end
