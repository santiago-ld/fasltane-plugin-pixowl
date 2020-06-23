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
          "buildVersion" => params[:buildVersion].to_i,
          "version" => 
          {
            "major" => major,
            "minor" => minor,
            "patch" => patch
          }
        }

        jsonPretty = JSON.pretty_generate(json)
        
        #UI.message "#{params[:path]} :\n" + jsonPretty

         File.open(params[:jsonGamePath],"w") do |f|
           f.write(jsonPretty)
         end

         #JSON BUILD

        major = params[:version].split(".")[0].to_i
        minor = params[:version].split(".")[1].to_i
        patch = params[:version].split(".")[2].to_i
        json = 
        {
          "storePassword" => params[:storePassword],
          "aliasPassword" => params[:aliasPassword],
          "outputPath"    => params[:outputPath],
          "outputName"    => params[:outputName],
          "projectPath"   => params[:projectPath],
          "buildAAB"      => params[:buildAAB],
          "armv8a"        => params[:armv8a]
        }

        jsonPretty = JSON.pretty_generate(json)
        
        #UI.message "#{params[:path]} :\n" + jsonPretty

         File.open(params[:jsonBuidPath],"w") do |f|
           f.write(jsonPretty)
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
          FastlaneCore::ConfigItem.new(key: :jsonBuidPath,
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
                                       verify_block: proc do |value|
                                          #UI.user_error!("please set environment") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),

          FastlaneCore::ConfigItem.new(key: :qaMenu,
                                       env_name: "FL_BUILD_JSON_QA_MENU",
                                       description: "qa menu (cheats)",
                                       default_value: false,
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
                                       optional: false),

          FastlaneCore::ConfigItem.new(key: :outputName,
                                       env_name: "FL_BUILD_JSON_OUTPUTNAME",
                                       description: "filename",
                                       optional: false),

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
