# frozen_string_literal: true

class Job
  attr_reader :id, :title, :required_skills

  def initialize(id:, title:, required_skills:)
    @id = id.to_i
    @title = title.to_s
    @required_skills = required_skills.to_s.split(',').map(&:strip)
  end
end