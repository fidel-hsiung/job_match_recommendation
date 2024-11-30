# frozen_string_literal: true

class Jobseeker
  attr_reader :id, :name, :skills

  def initialize(id:, name:, skills:)
    @id = id.to_i
    @name = name.to_s
    @skills = skills.to_s.split(',').map(&:strip)
  end
end