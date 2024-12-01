module Shared
  module AttributeParser

    private

    def parse_id(id)
      Integer(id, exception: false)
    end

    def parse_string(temp_string)
      temp_string.to_s.strip
    end

    def parse_skills(skills_string)
      skills_string.to_s.split(',').map(&:strip)
    end
  end
end