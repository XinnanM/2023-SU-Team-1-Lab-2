class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections, id:false, primary_key: :section_id do |t|
      t.integer :section_id, null: false
      t.string :section_number
      t.integer :course_id
      t.string :catalog_number
      t.string :term_id
      t.string :campus
      t.string :days_of_week
      t.string :time_start
      t.string :time_end
      t.string :location
      t.string :instructor_name
      t.string :instructor_email
      t.integer :current_num_required_graders
      t.integer :num_required_graders
      t.timestamps

      t.index :section_id, unique: true
    end
  end
end
