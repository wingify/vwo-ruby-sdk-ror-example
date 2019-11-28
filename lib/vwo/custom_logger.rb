# Basic Custom Logging Before Starting App

class VWO
  class CustomLogger
    def initialize(logger_instance)
      # Only log info logs and above, no debug
      @@logger_instance = logger_instance || Logger.new(STDOUT, level: :info)
    end
    
    def log(level, message)
      # Basic Modification
      message = "#{Time.now} #{message}"
      @@logger_instance.log(level, message)
    end
  end
end
