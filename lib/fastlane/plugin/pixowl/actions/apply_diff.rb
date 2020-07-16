module Fastlane
  module Actions
    module SharedValues
      APPLY_DIFF_CUSTOM_VALUE = :APPLY_DIFF_CUSTOM_VALUE
    end

    class ApplyDiffAction < Action
      def self.run(params)
        begin
          Dir.chdir(params[:pathToApply]) do
            sh "git apply #{params[:diffPath]}" 
          end
        rescue => ex
         UI.error(ex)
        end
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
    

          FastlaneCore::ConfigItem.new(key: :diffPath,
                                       env_name: "FL_APPLY_DIFF_PATH_DIFF",
                                       description: "path to the diff file",
                                       is_string: true, 
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :pathToApply,
                                       env_name: "FL_APPLY_DIFF_PATH_TO_APPLY",
                                       description: "path to apply the .diff",
                                       is_string: true,
                                       optional: false)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['APPLY_DIFF_CUSTOM_VALUE', 'A description of what this value contains']
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
