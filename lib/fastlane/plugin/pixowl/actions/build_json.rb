require 'json'


module Fastlane
  module Actions
    module SharedValues
      BUILD_JSON_CUSTOM_VALUE = :BUILD_JSON_CUSTOM_VALUE
    end

    class BuildJsonAction < Action
      def self.run(params)
        major = params[:version].split(".")[0].to_i
        minor = params[:version].split(".")[1].to_i
        patch = params[:version].split(".")[2].to_i

        json = 
        {
          "env" => params[:env],
          "qaMenu" => params[:qaMenu],
          "unityStandalone" => params[:unityStandalone],
          "buildVersion" => params[:buildVersion].to_i,
          "version" => 
          {
            "major" => major,
            "minor" => minor,
            "patch" => patch
          }
        }

        jsonPretty = JSON.pretty_generate(json)
        File.open(params[:jsonGamePath],"w") do |f|
           f.write(jsonPretty)
        end
       
        #JSON BUILD
        major = params[:version].split(".")[0].to_i
        minor = params[:version].split(".")[1].to_i
        patch = params[:version].split(".")[2].to_i

        json = 
        {
          "storePassword"                 => params[:storePassword],
          "aliasPassword"                 => params[:aliasPassword],
          "keyPath"                       => params[:keyPath],
          "keyAlias"                      => params[:keyAlias],
          "outputPath"                    => params[:outputPath],
          "outputName"                    => params[:outputName],
          "projectPath"                   => params[:projectPath],
          "buildAAB"                      => params[:buildAAB],
          "armv8a"                        => params[:armv8a],
          "exportAsGoogleAndroidProject"  => params[:exportAsGoogleAndroidProject],
          "generatedProjOutputPath"       => params[:generatedProjOutputPath]
        }

        jsonPretty = JSON.pretty_generate(json)
        File.open(params[:jsonBuildPath],"w") do |f|
          f.write(jsonPretty)
        end


      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "generate the build configuration json"
      end

      def self.details
        ""
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :jsonBuildPath,
                                       env_name: "FL_BUILD_JSON_BUILD_PATH", # The name of the environment variable
                                       description: "path to build configuration json", # a short description of this parameter
                                       optional: false,
                                       verify_block: proc do |value|
                                       end),
          FastlaneCore::ConfigItem.new(key: :jsonGamePath,
                                       env_name: "FL_BUILD_JSON_GAME_PATH", # The name of the environment variable
                                       description: "path to game configuration json", # a short description of this parameter
                                       optional: false,
                                       verify_block: proc do |value|
                                       end),
          FastlaneCore::ConfigItem.new(key: :env,
                                       env_name: "FL_BUILD_JSON_ENVIRONMENT", # The name of the environment variable
                                       description: "QA-QA1-DEV-CS-GD-PROD", # a short description of this parameter
                                       default_value: "QA",
                                       optional: true,
                                       verify_block: proc do |value|
                                          #UI.user_error!("please set environment") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),

          FastlaneCore::ConfigItem.new(key: :qaMenu,
                                       env_name: "FL_BUILD_JSON_QA_MENU",
                                       description: "qa menu (cheats)",
                                       default_value: false,
                                       optional: true,
                                       is_string: false),

          FastlaneCore::ConfigItem.new(key: :unityStandalone,
                                       env_name: "FL_BUILD_JSON_UNITY_STANDALONE",
                                       description: "unityStandalone",
                                       default_value: false,
                                       optional: true,
                                       is_string: false),

          FastlaneCore::ConfigItem.new(key: :version,
                                       env_name: "FL_BUILD_JSON_VERSION",
                                       description: "the string version",
                                       optional: false), # the default value if the user didn't provide one

          FastlaneCore::ConfigItem.new(key: :buildVersion,
                                       env_name: "FL_BUILD_JSON_BUILD_VERSION",
                                       description: "the int build version",
                                       optional: false), # the default value if the user didn't provide one

          FastlaneCore::ConfigItem.new(key: :storePassword,
                                       env_name: "FL_BUILD_JSON_STORE_PASS",
                                       description: "android sign store pass",
                                       default_value: "",
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :aliasPassword,
                                       env_name: "FL_BUILD_JSON_KEY_PASS",
                                       description: "android sign key pass",
                                       default_value: "",
                                       optional: true),


          FastlaneCore::ConfigItem.new(key: :buildAAB,
                                       env_name: "FL_BUILD_JSON_BUILD_AAB",
                                       description: "aab",
                                       default_value: false,
                                       optional: true,
                                       is_string: false),

          FastlaneCore::ConfigItem.new(key: :armv8a,
                                       env_name: "FL_BUILD_JSON_ARMV8A",
                                       description: "true ARMV8A-IL2CPP, false ARMV7-MONO",
                                       default_value: true,
                                       optional: true,
                                       is_string: false),
          
          FastlaneCore::ConfigItem.new(key: :outputPath,
                                       env_name: "FL_BUILD_JSON_OUTPUTPATH",
                                       description: "output path",
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :outputName,
                                       env_name: "FL_BUILD_JSON_OUTPUTNAME",
                                       description: "filename",
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :projectPath,
                                       env_name: "FL_BUILD_JSON_PROJECTPATH",
                                       description: "xcode project path",
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :keyPath,
                                       env_name: "FL_BUILD_JSON_KEYSTORE_PATH",
                                       description: "keystore path",
                                       default_value: "",
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :keyAlias,
                                       env_name: "FL_BUILD_JSON_KEYSTORE_ALIAS",
                                       description: "keystore alias",
                                       default_value: "",
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :exportAsGoogleAndroidProject,
                                       env_name: "FL_BUILD_JSON_EXPORT_ANDROISTUDIO",
                                       description: "set true to export android version into a androidstudio project",
                                       default_value: false,
                                       optional: true,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :generatedProjOutputPath,
                                       env_name: "FL_BUILD_JSON_GENERATED_PROJ_OUTPUT_PATH",
                                       description: "xcode or androidstudio path to generate, on android only work with exportAsGoogleAndroidProject = true",
                                       optional: true)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['BUILD_JSON_CUSTOM_VALUE', 'A description of what this value contains']
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
