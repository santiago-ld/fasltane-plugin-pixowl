module Fastlane
  module Actions
    module SharedValues
      BUILD_IOS_CUSTOM_VALUE = :BUILD_IOS_CUSTOM_VALUE
    end

    class BuildIosAction < Action
      def self.run(params)
        export_method = params[:export_list].shift

        other_action.build_app scheme:params[:scheme],
          workspace: "#{params[:workspace]}",
          output_directory: "#{params[:output_path]}/ipa", 
          buildlog_path: "#{params[:output_path]}/log",
          output_name: "#{params[:output_name]}_#{export_method}",
          configuration: params[:configuration],
          # export_xcargs: "-allowProvisioningUpdates",
          # xcargs: "-allowProvisioningUpdates",
          clean: params[:clean],
          archive_path:"#{params[:output_path]}/archive/#{params[:output_name]}",
          export_method: export_method,
          include_bitcode: false,
          xcargs: params[:xcargs],
          export_options: 
          {
            uploadBitcode: false,
            uploadSymbols: false,
            compileBitcode: false
          }

        params[:export_list].each {
          |export_method_it| 
          UI.message "\tParameter export_to: #{export_method_it}"
          other_action.build_app scheme:params[:scheme],
            workspace: "#{params[:workspace]}",
            output_directory: "#{params[:output_path]}/ipa", 
            buildlog_path: "#{params[:output_path]}/log",
            output_name: "#{params[:output_name]}_#{export_method_it}",
            configuration: params[:configuration],
            clean: params[:clean],
            archive_path:"#{params[:output_path]}/archive/#{params[:output_name]}",
            export_method: export_method_it,
            include_bitcode: false,
            skip_build_archive: true,
            xcargs: params[:xcargs],
            export_options: 
            {
              uploadBitcode: false,
              uploadSymbols: false,
              compileBitcode: false
            }
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
          FastlaneCore::ConfigItem.new(key: :clean,
                                       env_name: "FL_BUILD_IOS_CLEAN",
                                       description: "clean before build?",
                                       is_string: false,
                                       default_value: false,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :workspace,
                                       env_name: "FL_BUILD_IOS_WORKSPACE", 
                                       description: "path to xcode workspace",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :output_path,
                                       env_name: "FL_BUILD_IOS_OUTPUT_PATH", 
                                       description: "output_path",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :output_name,
                                       env_name: "FL_BUILD_IOS_OUTPUT_NAME", 
                                       description: "path to xcode project",
                                       optional: false),

          FastlaneCore::ConfigItem.new(key: :scheme,
                                       env_name: "FL_BUILD_IOS_SCHEME", 
                                       description: "sheme name",
                                       default_value: "Unity-iPhone",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :configuration,
                                       env_name: "FL_BUILD_IOS_CONFIGURATION", 
                                       description: "configuration name",
                                       default_value: "Release",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :export_list,
                                       env_name: "FL_BUILD_IOS_EXPORT_LIST",
                                       description: "clean before build?",
                                       type: Array,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :xcargs,
                                       env_name: "FL_BUILD_IOS_XCARGS", 
                                       description: "defines",
                                       optional: true)
      



        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['BUILD_IOS_CUSTOM_VALUE', 'A description of what this value contains']
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
