json.extract! recommendation, :id, :instructor_email, :course_id, :section_id, :student_email, :testimonial, :created_at, :updated_at
json.url recommendation_url(recommendation, format: :json)
