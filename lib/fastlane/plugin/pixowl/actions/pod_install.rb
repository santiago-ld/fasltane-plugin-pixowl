module Fastlane
  module Actions
    module SharedValues
      POD_INSTALL_CUSTOM_VALUE = :POD_INSTALL_CUSTOM_VALUE
    end

    class PodInstallAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        #UI.message "Parameter API Token: #{params[:api_token]}"

        
        Dir.chdir("#{params[:path]}") do
        #pwd
        sh "pod install"
        end
        
      

        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::POD_INSTALL_CUSTOM_VALUE] = "my_val"
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
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "FL_POD_INSTALL_PATH", # The name of the environment variable
                                       description: "xproj path", # a short description of this parameter
                                       verify_block: proc do |value|
                                          UI.user_error!("No path for PodInstallAction given, pass using `path: '.\\path\\to\\xcodeproj\\'`") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['POD_INSTALL_CUSTOM_VALUE', 'A description of what this value contains']
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
