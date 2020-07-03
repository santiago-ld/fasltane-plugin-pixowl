module Fastlane
  module Actions
    module SharedValues
      DELETE_TEMP_FILES_CUSTOM_VALUE = :DELETE_TEMP_FILES_CUSTOM_VALUE
    end

    class DeleteTempFilesAction < Action
      def self.run(params)

        params[:list].each {
        |file_to_delete| 
           begin
             sh "rm -rf #{file_to_delete}" 
           rescue => ex
             UI.error(ex)
           end

        }
  
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          # FastlaneCore::ConfigItem.new(key: :api_token,
          #                              env_name: "FL_DELETE_TEMP_FILES_API_TOKEN", # The name of the environment variable
          #                              description: "API Token for DeleteTempFilesAction", # a short description of this parameter
          #                              verify_block: proc do |value|
          #                                 UI.user_error!("No API token for DeleteTempFilesAction given, pass using `api_token: 'token'`") unless (value and not value.empty?)
          #                                 # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
          #                              end),
          # FastlaneCore::ConfigItem.new(key: :development,
          #                              env_name: "FL_DELETE_TEMP_FILES_DEVELOPMENT",
          #                              description: "Create a development certificate instead of a distribution one",
          #                              is_string: false, # true: verifies the input is a string, false: every kind of value
          #                              default_value: false) # the default value if the user didn't provide one

          FastlaneCore::ConfigItem.new(key: :list,
                                       env_name: "FL_DELETE_TEMP_FILES_LIST",
                                       description: "clean before build?",
                                       type: Array,
                                       optional: false),


        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['DELETE_TEMP_FILES_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Your GitHub/Twitter Name"]
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :ios
      end
    end
  end
end
