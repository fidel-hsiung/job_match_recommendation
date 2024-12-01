# frozen_string_literal: true

require_relative 'shared/attribute_parser'
require_relative 'shared/validation'

class Jobseeker
  include Shared::AttributeParser
  include Shared::Validation

  attr_reader :id, :name, :skills

  def initialize(id:, name:, skills:)
    @id = parse_id(id)
    @name = parse_string(name)
    @skills = parse_skills(skills)

    validate_attributes
  end

  def display_name
    name.split(' ').first.strip
  end

  private

  def validate_attributes
    validate_id(id)
    validate_name(name)
  end
end
