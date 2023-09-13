json.extract! course, :id, :course_id, :catalog_number, :course_description, :course_name, :academic_career, :created_at, :updated_at
json.url course_url(course, format: :json)
