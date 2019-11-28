require 'vwo'

class VWOService

  class UserStorage

    @@user_storage = {}

    # Abstract method, must be defined to fetch the
    # User dict corresponding to the user_id.
    #
    # @param[String]        :user_id            ID for user which needs to be retrieved.
    # @param[String]        :campaign_key       Campaign key
    # @return[Hash]         :user_obj           Object representing the user.
    #
    def get(user_id, campaign_key)
      # example code to fetch it
      # You could also fetch from DB like User.find_by_vwo_id(user_id).settings
      @@user_storage[user_id]
    end

    # Abstract method, must be to defined to save
    # The user dict sent to this method.
    # @param[Hash]    :user_obj     Object representing the user.
    #
    def set(user_obj)
      # example code to set it
      # You could also set in DB i.e User.find(id).update_attributes(user_id: user_obj[:userId], settings: user_obj)
      @@user_storage[user_obj[:userId]] = user_obj
    end
  end

  def self.start_logger
    ::VWO::Logger.class_eval do
      # Override this method to handle logs in a custom manner
      def log(level, message)
        # Modify message for custom logging
        message = "Custom message #{message}"
        ::VWO::Logger.class_variable_get('@@logger_instance').log(level, message)
      end
    end
  end

  def self.stop_logger
    ::VWO::Logger.class_eval do
      def log(level, message)
        message = "#{Time.now} #{message}"
        ::VWO::Logger.class_variable_get('@@logger_instance').log(level, message)
      end
    end
  end


  def self.get_vwo_instance
    @@vwo_client_instance ||= VWO.new(VwoRubySdkRailsExample.credentials[:account_id], VwoRubySdkRailsExample.credentials[:sdk_key], nil, nil, false)
  end

  def self.get_vwo_user_storage_instance
    @@vwo_client_instance ||= VWO.new(VwoRubySdkRailsExample.credentials[:account_id], VwoRubySdkRailsExample.credentials[:sdk_key], nil, user_storage=UserStorage.new, false)
  end
end
