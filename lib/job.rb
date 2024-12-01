# frozen_string_literal: true

require_relative 'shared/attribute_parser'
require_relative 'shared/validation'

class Job
  include Shared::AttributeParser
  include Shared::Validation

  attr_reader :id, :title, :required_skills

  def initialize(id:, title:, required_skills:)
    @id = parse_id(id)
    @title = parse_string(title)
    @required_skills = parse_skills(required_skills)

    validate_attributes
  end

  private

  def validate_attributes
    validate_id(id)
    validate_title(title)
  end
end
