module Shared
  module SkillParser

    private

    def parse_skills(skills_string)
      skills_string.to_s.split(',').map(&:strip)
    end
  end
end