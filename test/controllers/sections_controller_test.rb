require "test_helper"

class SectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section = sections(:one)
  end

  test "should get index" do
    get sections_url
    assert_response :success
  end

  test "should get new" do
    get new_section_url
    assert_response :success
  end

  test "should create section" do
    assert_difference("Section.count") do
      post sections_url, params: { section: { campus: @section.campus, catalog_number: @section.catalog_number, course_id: @section.course_id, current_num_required_graders: @section.current_num_required_graders, days_of_week: @section.days_of_week, instructor_email: @section.instructor_email, instructor_name: @section.instructor_name, location: @section.location, num_required_graders: @section.num_required_graders, section_id: @section.section_id, section_number: @section.section_number, term_id: @section.term_id, time_end: @section.time_end, time_start: @section.time_start } }
    end

    assert_redirected_to section_url(Section.last)
  end

  test "should show section" do
    get section_url(@section)
    assert_response :success
  end

  test "should get edit" do
    get edit_section_url(@section)
    assert_response :success
  end

  test "should update section" do
    patch section_url(@section), params: { section: { campus: @section.campus, catalog_number: @section.catalog_number, course_id: @section.course_id, current_num_required_graders: @section.current_num_required_graders, days_of_week: @section.days_of_week, instructor_email: @section.instructor_email, instructor_name: @section.instructor_name, location: @section.location, num_required_graders: @section.num_required_graders, section_id: @section.section_id, section_number: @section.section_number, term_id: @section.term_id, time_end: @section.time_end, time_start: @section.time_start } }
    assert_redirected_to section_url(@section)
  end

  test "should destroy section" do
    assert_difference("Section.count", -1) do
      delete section_url(@section)
    end

    assert_redirected_to sections_url
  end
end
