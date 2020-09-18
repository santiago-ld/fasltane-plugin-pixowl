module Fastlane
  module Actions
    module SharedValues
      BUILD_IOS_WITHOUT_FASTLANE_CUSTOM_VALUE = :BUILD_IOS_WITHOUT_FASTLANE_CUSTOM_VALUE
    end

    class BuildIosWithoutFastlaneAction < Action
      def self.run(params)
  
        begin

          scheme            = params[:scheme]
          configuration     = params[:configuration]
          workspacePath     = params[:workspacePath]
          clean             = "clean=no" 
          buildPath         = params[:buildPath]
          outputName        = params[:outputName]
          buildVersion      = params[:buildVersion]
          version           = params[:version]
          buildScripts      = params[:buildScripts]
          gameName          = params[:gameName]

          if params[:clean]
            clean       = "clean=yes" 
          end

          #sh "rm -rf #{file_to_delete}" 

          sh "#{buildScripts}/#3_build_game.sh #{scheme} #{configuration} #{clean} #{workspacePath} #{buildPath}"

          params[:exportList].each {
            |export_method_it| 
            sh "#{buildScripts}/#4_package.sh #{gameName} #{export_method_it} #{outputName} #{buildVersion} #{version}"
          }
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
        [
          FastlaneCore::ConfigItem.new(
            key: :scheme,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_SCHEME", 
            description: "scheme to build",
            default_value: "Unity-iPhone",
            optional: true),
          FastlaneCore::ConfigItem.new(
            key: :gameName,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_GAME_NAME" 
            description: "game name",
            optional: false),          
          FastlaneCore::ConfigItem.new(
            key: :workspacePath,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_WORKSPACE_PATH", 
            description: "path to the xcode workspace",
            optional: false),
          FastlaneCore::ConfigItem.new(
            key: :configuration,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_CONFIGURATION", 
            description: "configuration name",
            default_value: "Release",
            optional: true),
          FastlaneCore::ConfigItem.new(
            key: :clean,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_CLEAN",
            description: "clean before build?",
            is_string: false,
            default_value: false,
            optional: true),          
          FastlaneCore::ConfigItem.new(
            key: :buildPath,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_BUILD_PATH", 
            description: "path to save the app",
            default_value: "Release",
            optional: true),
          FastlaneCore::ConfigItem.new(
            key: :outputName,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_OUTPUT_NAME", 
            description: "output name",
            default_value: "outputName",
            optional: true),
          FastlaneCore::ConfigItem.new(
            key: :buildVersion,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_BUILD_VERSION", 
            description: "buildVersion",
            default_value: "0",
            optional: true),
          FastlaneCore::ConfigItem.new(
            key: :version,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_VERSION", 
            description: "version",
            default_value: "0.0.0",
            optional: true),
          FastlaneCore::ConfigItem.new(
            key: :exportList,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_EXPORT_LIST",
            description: "clean before build?",
            type: Array,
            optional: true),
          FastlaneCore::ConfigItem.new(
            key: :buildScripts,
            env_name: "FL_BUILD_IOS_WITHOUT_FASTLANE_BUILD_SCRIPT",
            description: "build script path",
            optional: false),
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['BUILD_IOS_WITHOUT_FASTLANE_CUSTOM_VALUE', 'A description of what this value contains']
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
