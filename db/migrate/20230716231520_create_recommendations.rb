class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.string :instructor_email
      t.integer :course_id
      t.integer :section_id
      t.string :student_email
      t.string :testimonial

      t.timestamps
    end
  end
end
