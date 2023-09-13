require 'httparty'

# Helper class to fetch Courses from OSU API
class CourseFetcher
  # Import HTTParty for API fetching. By default it only search for CSE classes
  include HTTParty
  base_uri 'https://content.osu.edu/v2/classes/search'
  default_params q: 'cse', client: 'class-search-ui'
  format :json

  # Fetch the courses from given campus and term.
  # @param campus [String] 3-character code to spot campus
  # @param term [Integer] 4-digit code to spot term
  # @note Will get nothing if campus and term are invalid for the API
  def self.fetch(campus, term)
    page = 1
    loop do
      initial_response = get('', { query: { campus: campus, term: term, p: page } })

      break if initial_response.code != 200

      @response = initial_response['data']['courses']
      @response.each do |result|
        # puts result['course']['subject']
        if result['course']['subject'] == 'CSE'
          course_attributes = {
            course_id: result['course']['courseId'],
            course_name: result['course']['title'],
            catalog_number: result['course']['catalogNumber'],
            short_description: result['course']['shortDescription'],
            course_description: result['course']['description'],
            academic_career: result['course']['academicCareer']
          }

          course = Course.find_or_initialize_by(course_id: result['course']['courseId'])
          course.update(course_attributes)

          result['sections'].each do |result_section|
            meeting_days = ''
            meeting_days += '1' if result_section['meetings'][0]['monday']
            meeting_days += '2' if result_section['meetings'][0]['tuesday']
            meeting_days += '3' if result_section['meetings'][0]['wednesday']
            meeting_days += '4' if result_section['meetings'][0]['thursday']
            meeting_days += '5' if result_section['meetings'][0]['friday']
            meeting_days += '6' if result_section['meetings'][0]['saturday']
            meeting_days += '7' if result_section['meetings'][0]['sunday']

            section = Section.find_or_initialize_by(section_id: result_section['classNumber'])
            section_required_graders = 1
            section_current_graders = 0

            unless section.num_required_graders.nil?
              section_required_graders = section.num_required_graders
              puts section_required_graders
              puts section.num_required_graders
            end

            unless section.current_num_required_graders.nil?
              section_current_graders = section.current_num_required_graders
              puts section_current_graders
              puts section.current_num_required_graders
            end

            section_attributes = {
              section_id: result_section['classNumber'],
              section_number: result_section['section'],
              course_id: result_section['courseId'],
              catalog_number: result_section['catalogNumber'],
              term_id: result_section['termCode'],
              campus: result_section['campus'],
              time_start: result_section['meetings'][0]['startTime'],
              time_end: result_section['meetings'][0]['endTime'],
              location: result_section['meetings'][0]['buildingDescription'],
              instructor_name: result_section['meetings'][0]['instructors'][0]['displayName'],
              instructor_email: result_section['meetings'][0]['instructors'][0]['email'],
              days_of_week: meeting_days,
              num_required_graders: section_required_graders,
              current_num_required_graders: section_current_graders
            }
            section.update(section_attributes)
          end
        end
      end
      page += 1
    end
  end

  # Hard reset the database and then fetch new courses
  # @param campus [String] 3-character code to spot campus
  # @param term [Integer] 4-digit code to spot term
  # @note Will get nothing if campus and term are invalid for the API
  def self.clean_fetch(campus, term)
    self.clear
    self.fetch(campus, term)
  end

  # Debug method: Fetch courses for Columbus campus AU23 CSE courses
  def self.fetch_au23
    self.clear
    self.fetch('col', 1238)
  end

  # Hard reset the database.
  # @note will DELETE all courses and sections
  def self.clear
    Course.delete_all
    Section.delete_all
    Recommendation.delete_all
    GraderApplication.delete_all
  end

  # Get a test response to see what Campus and Term could be used for fetcher
  # @return {[Title, Term], [Title, Campus]} for drop-down menus in the UI
  def self.initial_response
    @initial_response = get('')
    if @initial_response.code == 200
      data = @initial_response.parsed_response['data']
      term_data = extract_items(data['filters'], 'Term', 'term')
      campus_data = extract_items(data['filters'], 'Campus', 'term')

      return {
        term_data: term_data,
        campus_data: campus_data
      }
    else
      puts "Error: Cannot retrieve current Term and Campus. Using Default options instead. Error code: #{response.code}"
      return nil
    end
  end

  private

  # Extract items from JSON
  def self.extract_items(filters, filter_title, filter_slug)
    filter_data = filters.find { |filter| filter['title'] == filter_title }
    return [] unless filter_data

    items = filter_data['items']
    extracted_data = items.map { |item| { 'title' => item['title'], filter_slug => item[filter_slug] } }
    return extracted_data
  end
end
