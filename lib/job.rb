# frozen_string_literal: true

require_relative 'shared/skills_parser'

class Job
  include Shared::SkillParser

  attr_reader :id, :title, :required_skills

  def initialize(id:, title:, required_skills:)
    @id = id.to_i
    @title = title.to_s
    @required_skills = parse_skills(required_skills)
  end
end