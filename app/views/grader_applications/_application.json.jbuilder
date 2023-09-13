json.extract! grader_application, :id, :name, :email, :course_id, :section_id, :schedule, :created_at, :updated_at
json.url grader_application_url(grader_application, format: :json)