# frozen_string_literal: true

require_relative 'shared/skills_parser'

class Jobseeker
  include Shared::SkillParser

  attr_reader :id, :name, :skills

  def initialize(id:, name:, skills:)
    @id = id.to_i
    @name = name.to_s
    @skills = parse_skills(skills)
  end
end