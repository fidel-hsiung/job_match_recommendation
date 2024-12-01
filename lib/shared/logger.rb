module Shared
  module Logger
    def log(message)
      puts "[LOG] #{message}"
    end

    def log_error(message)
      puts "[ERROR] #{message}"
    end
  end
end