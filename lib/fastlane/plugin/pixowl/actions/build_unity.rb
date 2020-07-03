module Fastlane
  module Actions
    module SharedValues
      BUILD_UNITY_CUSTOM_VALUE = :BUILD_UNITY_CUSTOM_VALUE
    end

    class BuildUnityAction < Action

      # def self.printParams(params)
     
      #   UI.log()
      # end

      def self.genericCmd(params)
        build_cmd = "#{params[:executable]}"
        build_cmd << " -projectPath \"#{params[:unityProjectPath]}\"" unless params[:unityProjectPath].nil?
        build_cmd << " -quit" if params[:quit]
        build_cmd << " -batchmode" if params[:batchmode]
        build_cmd << " -nographics" if params[:nographics]
      #  build_cmd << " -outputPath \"#{params[:outputPath]}\"" unless params[:outputPath].nil?
      #  build_cmd << " -outputName \"#{params[:outputName]}\"" unless params[:outputName].nil?

        # build_cmd << " -username \"#{params[:username]}\"" unless params[:username].nil?
        # build_cmd << " -password \"#{params[:password]}\"" unless params[:password].nil?  
        # build_cmd << " -env \"#{params[:env]}\"" unless params[:env].nil?
        # build_cmd << " -version \"#{params[:version]}\"" unless params[:version].nil?
        # build_cmd << " -logfile #{params[:logFile]}"

        build_cmd << " -logfile"
        build_cmd
      end

      def self.androidCmd(params)
        build_cmd = genericCmd(params)
        #build_cmd << " -storePassword \"#{params[:storePassword]}\"" unless params[:storePassword].nil?
        #build_cmd << " -keyPassword \"#{params[:keyPassword]}\"" unless params[:keyPassword].nil?
        build_cmd << " -executeMethod buildUtil.PerformBuildAndroid"
        build_cmd
      end

      def self.iosCmd(params)
        build_cmd = genericCmd(params)
        build_cmd << " -projectName \"#{params[:xcodeProjName]}\"" unless params[:xcodeProjName].nil?
        build_cmd << " -executeMethod buildUtil.PerformBuildiOs"
        build_cmd
      end

      def self.osxCmd(params)
        build_cmd = genericCmd(params)
        build_cmd << " -executeMethod buildUtil.PerformBuilOsx"
        build_cmd
      end

      def self.run(params)
      
        platnam = lane_context[SharedValues::PLATFORM_NAME].to_s

        if (platnam == "ios")
            FastlaneCore::CommandExecutor.execute(  command: iosCmd(params),
                                        print_all: true,
                                        error: proc do |error_output|
                                        #UI.error ("error_output = #{error_output}")
                                        return error_output
                                        end)
        elsif (platnam == "android")
            FastlaneCore::CommandExecutor.execute(  command: androidCmd(params),
                                                    print_all: true,
                                                    error: proc do |error_output|
                                                     # UI.error ("error_output = #{error_output}")
                                                    # handle error here
                                                    return error_output
                                                    end)
        elsif (platnam == "mac")
            FastlaneCore::CommandExecutor.execute(  command: osxCmd(params),
                                                    print_all: true,
                                                    error: proc do |error_output|
                                                   #   UI.error ("error_output = #{error_output}")
                                                    # handle error here
                                                    return error_output
                                                    end)
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "unity android or ios"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
      [
          FastlaneCore::ConfigItem.new(key: :executable,
                                  env_name: "FL_UNITY_EXECUTABLE",
                               description: "Path to Unity executable",
                             default_value: "/Applications/Unity/Hub/Editor/2018.4.20f1/Unity.app/Contents/MacOS/Unity"),

          FastlaneCore::ConfigItem.new(key: :logFile,
                                  env_name: "FL_UNITY_LOG_FILE",
                               description: "log file",
                                  optional: false),

          FastlaneCore::ConfigItem.new(key: :batchmode,
                                  env_name: "FL_UNITY_BATCHMODE",
                               description: "Should run command in batch mode",
                             default_value: true,
                                 is_string: false),
          
          FastlaneCore::ConfigItem.new(key: :nographics,
                                  env_name: "FL_UNITY_NOGRAPHICS",
                               description: "Should run unity in non graphics environment",
                             default_value: true,
                                 is_string: false),

          FastlaneCore::ConfigItem.new(key: :unityProjectPath,
                                  env_name: "FL_UNITY_PROJECT_PATH",
                               description: "Path to Unity project",
                             default_value: "#{Dir.pwd}",
                                  optional: true),

          FastlaneCore::ConfigItem.new(key: :quit,
                                  env_name: "FL_UNITY_QUIT",
                               description: "Should quit Unity after execution",
                             default_value: true,
                                 is_string: false),

          FastlaneCore::ConfigItem.new(key: :execute_method,
                                  env_name: "FL_UNITY_EXECUTE_METHOD",
                               description: "Method to execute",
                                  optional: true),

          FastlaneCore::ConfigItem.new(key: :background,
                                  env_name: "FL_UNITY_BACKGROUND",
                               description: "Should run command in background (adding &)",
                             default_value: false,
                                 is_string: false),

          FastlaneCore::ConfigItem.new(key: :version,
                                  env_name: "FL_UNITY_VERSION",
                               description: "version string",
                             default_value: "0.0.0",                               
                                  optional: false),

          FastlaneCore::ConfigItem.new(key: :buildVersion,
                                  env_name: "FL_UNITY_BUILD_VERSION",
                               description: "version number",
                             default_value: 0,
                                  optional: false),
          FastlaneCore::ConfigItem.new(key: :env,
                                  env_name: "FL_UNITY_ENV",
                               description: "environment",
                                  optional: false),

          FastlaneCore::ConfigItem.new(key: :xcodeProjName,
                                  env_name: "FL_UNITY_XCODE_PROJECT_NAME",
                               description: "xcode ios project name",
                                  optional: true),

          FastlaneCore::ConfigItem.new(key: :outputPath,
                                  env_name: "FL_UNITY_OUTPUT_PATH",
                               description: "path to the build",
                                  optional: false),

          FastlaneCore::ConfigItem.new(key: :outputName,
                                  env_name: "FL_UNITY_OUTPUT_NAME",
                               description: "filename of the build",
                                  optional: false),

          # FastlaneCore::ConfigItem.new(key: :storePassword,
          #                         env_name: "FL_UNITY_XCODE_STORE_PASS",
          #                      description: "android sign store pass",
          #                         optional: true),

          # FastlaneCore::ConfigItem.new(key: :keyPassword,
          #                         env_name: "FL_UNITY_XCODE_KEY_PASS",
          #                      description: "android sign key pass",
          #                         optional: true)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['BUILD_UNITY_CUSTOM_VALUE', 'A description of what this value contains']

        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["saderPixowl"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
      end
    end
  end
end
