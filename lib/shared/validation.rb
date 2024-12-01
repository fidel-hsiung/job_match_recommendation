module Shared
  module Validation

    private

    def validate_id(id)
      raise ArgumentError, 'ID must be a positive number' unless id && id > 0
    end

    def validate_name(name)
      raise ArgumentError, 'Name must exists' if name.empty?
    end

    def validate_title(title)
      raise ArgumentError, 'Title must exists' if title.empty?
    end
  end
end
