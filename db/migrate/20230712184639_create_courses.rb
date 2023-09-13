class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses, id: false, primay_key: :course_id do |t|
      t.integer :course_id, null: false
      t.string :short_description
      t.string :catalog_number
      t.string :course_description
      t.string :course_name
      t.string :academic_career
      t.timestamps

      t.index :course_id, unique: true
    end
  end
end
