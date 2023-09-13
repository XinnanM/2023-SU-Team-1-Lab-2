require "application_system_test_case"

class SectionsTest < ApplicationSystemTestCase
  setup do
    @section = sections(:one)
  end

  test "visiting the index" do
    visit sections_url
    assert_selector "h1", text: "Sections"
  end

  test "should create section" do
    visit sections_url
    click_on "New section"

    fill_in "Campus", with: @section.campus
    fill_in "Catalog number", with: @section.catalog_number
    fill_in "Course", with: @section.course_id
    fill_in "Current num required graders", with: @section.current_num_required_graders
    fill_in "Days of week", with: @section.days_of_week
    fill_in "Instructor email", with: @section.instructor_email
    fill_in "Instructor name", with: @section.instructor_name
    fill_in "Location", with: @section.location
    fill_in "Num required graders", with: @section.num_required_graders
    fill_in "Section", with: @section.section_id
    fill_in "Section number", with: @section.section_number
    fill_in "Term", with: @section.term_id
    fill_in "Time end", with: @section.time_end
    fill_in "Time start", with: @section.time_start
    click_on "Create Section"

    assert_text "Section was successfully created"
    click_on "Back"
  end

  test "should update Section" do
    visit section_url(@section)
    click_on "Edit this section", match: :first

    fill_in "Campus", with: @section.campus
    fill_in "Catalog number", with: @section.catalog_number
    fill_in "Course", with: @section.course_id
    fill_in "Current num required graders", with: @section.current_num_required_graders
    fill_in "Days of week", with: @section.days_of_week
    fill_in "Instructor email", with: @section.instructor_email
    fill_in "Instructor name", with: @section.instructor_name
    fill_in "Location", with: @section.location
    fill_in "Num required graders", with: @section.num_required_graders
    fill_in "Section", with: @section.section_id
    fill_in "Section number", with: @section.section_number
    fill_in "Term", with: @section.term_id
    fill_in "Time end", with: @section.time_end
    fill_in "Time start", with: @section.time_start
    click_on "Update Section"

    assert_text "Section was successfully updated"
    click_on "Back"
  end

  test "should destroy Section" do
    visit section_url(@section)
    click_on "Destroy this section", match: :first

    assert_text "Section was successfully destroyed"
  end
end
