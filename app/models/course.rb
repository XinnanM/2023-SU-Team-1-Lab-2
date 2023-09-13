# frozen_string_literal: true

# Model of the Courses. Represent each course that being taught in the Ohio State.
# @contains Sections
# @key [Integer] course_id
# @requires course_id is UNIQUE
# @requires course_name must PRESENT
# @requires academic_career must PRESENT
# @requires catalog_number is of XXXX.XXH, XXX.XXH, XXXXH, XXXH, and variants without H
class Course < ApplicationRecord
  self.primary_key = :course_id
  default_scope { order(catalog_number: :asc) }
  has_many :sections
  validates :course_id, uniqueness: true
  validates :course_name, presence: true
  validates :academic_career, presence: true
  validate :valid_catalog_number_format

  # Overrides options which may cause confusion.
  # Returns: CourseID - CourseName (Catalog Number) - Academic Career
  def course_identifier
    "#{self.course_id} - (#{self.catalog_number})#{self.course_name} - #{self.academic_career}"
  end

  # Checks if the catalog number is in format of x.yz where x is a 3 or 4 digit integer (cannot start with 0), y is a 2 digit integer, and z is an uppercase alphabet.
  def valid_catalog_number_format
    return unless catalog_number.present?

    pattern = /\A[1-9]\d{2,3}(?:\.\d{2})?[A-Z]?\z/
    unless catalog_number =~ pattern
      errors.add(:catalog_number, "is not in the format x.yz where x is a 3 or 4 digit integer (cannot start with 0), y is a 2 digit integer, and z is an uppercase alphabet.")
    end
  end

  # Ransackable Attributes for sorting
  def self.ransackable_attributes(auth_object = nil)
    ["academic_career", "catalog_number", "course_description", "course_id", "course_name", "created_at", "short_description", "updated_at"]
  end

  # Ransackable Attributes for sorting
  def self.ransackable_associations(auth_object = nil)
    ["sections"]
  end
end
