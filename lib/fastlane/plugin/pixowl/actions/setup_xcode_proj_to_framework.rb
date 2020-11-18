
require "json"
require 'securerandom'

module Fastlane
  module Actions
    module SharedValues
      SETUP_XCODE_PROJ_TO_FRAMEWORK_CUSTOM_VALUE = :SETUP_XCODE_PROJ_TO_FRAMEWORK_CUSTOM_VALUE
    end

    class SetupXcodeProjToFrameworkAction < Action

      def self.createPBXBuildFileObject(id, fileRef)

        jsonData = {id => {
          "isa" => "PBXBuildFile",
          "fileRef" => fileRef,
          "settings" => {
            "ATTRIBUTES" => [
                  "Public"
            ]
          }
        }
        }
        return jsonData
      end

      def self.generateID()
        uuidArray =  SecureRandom.uuid.upcase.split("-")
        id = uuidArray[1] + uuidArray[2]+ uuidArray[3]+ uuidArray[4]
        return id
      end

      def self.getIdInList(json, key, value)
        objects = getObject(json, "objects")
        objects.each do |object|
          values = objects[object[0]]
          values.each  do |keysInValue|
            if (keysInValue[0] == key)
              keysInValue[1].each do |valuesInArray|
                if (valuesInArray == value)
                   return object[0]
                end
              end
            end
          end
        end
        return false
      end

      def self.getObject(json, key)
        return json[key]
      end


      def self.getPBXResourcesBuildPhase(json, _PBXNativeTargetId)
        obj = getObject(json, "objects")
        framework = getObject(obj, _PBXNativeTargetId)
        phases =  getObject(framework, "buildPhases")
        phases.each do |key|
          phase = getObject(obj, key)
          isa =  getObject(phase, "isa")
          if (isa == "PBXResourcesBuildPhase")
            return key
          end
        end
      end

      def self.getId(json, key, value)
        json.each do |obj|
          val = getObject(obj[1], key)
          if (val  == value)
            return obj[0]
          end
        end
      end

      def self.run(params)
        begin
          #sh "cp #{params[:xcode_proj_filepath]} #{params[:xcode_proj_filepath]}.back"#back
          sh "plutil -convert json #{params[:xcode_proj_filepath]}"
          UI.message("setupXcode json parser begin")
          #sh "cp #{params[:xcode_proj_filepath]} #{params[:xcode_proj_filepath]}.back_json" #back json
          file = File.open params[:xcode_proj_filepath]
          
          data = file.read
          file.close

          data.sub! "process_symbols.sh", 'usymtool\" -symbolPath \"../../build/archive.xcarchive/dSYMs/UnityFramework.framework.dSYM\"\necho Upload Dsym end.'
          data.sub! "process_symbols.sh", 'usymtool\" -symbolPath \"../../build/archive.xcarchive/dSYMs/UnityFramework.framework.dSYM\"\necho Upload Dsym end.'

          json = JSON.parse(data)
          #jsonPretty =  JSON.pretty_generate(json)
          #File.write("#{params[:xcode_proj_filepath]}.back_json", jsonPretty)

          objects = getObject(json, "objects")

          keyDataFolderFileRef                = getId(objects,"path" , "Data")
          keyDataFolderFile                   = getId(objects,"fileRef" , keyDataFolderFileRef)
          _PBXNativeTargetId                  = getId(objects,"productType" , "com.apple.product-type.framework")
          keyProductApplication               = getId(objects,"productType" , "com.apple.product-type.application")
          _PBXResourcesBuildPhaseApplication  = getIdInList(json,"files" , keyDataFolderFile)
          _PBXHeadersBuildPhase               = getId(objects,"isa" , "PBXHeadersBuildPhase")
          #_PBXShellScriptBuildPhases           = getId(objects, "shellScript", "$PROJECT_DIR/process_symbols.sh")



          _PBXResourcesBuildPhaseFramework    = getPBXResourcesBuildPhase(json, _PBXNativeTargetId)
          _NativeCallProxyId                  = getId(objects,"name" , "NativeCallProxy.h")




          #
          #puts _PBXShellScriptBuildPhases
        #   _PBXShellScriptBuildPhases.each do |key|
        #   _PBXShellScriptBuildPhase = getObject(obj, key)
        #   isa =  getObject(phase, "isa")
        #   if (isa == "PBXResourcesBuildPhase")
        #     return key
        #   end
        # end


          #delete folder data from headers resource build phase list for application
          rbpa = getObject(objects,_PBXResourcesBuildPhaseApplication )
          filesrbpa =  getObject(rbpa,"files" )
          filesrbpa.delete(keyDataFolderFile)

          #add folder data to headers resource build phase list for framework
          rbpf = getObject(objects,_PBXResourcesBuildPhaseFramework )
          filesrbpf =  getObject(rbpf,"files" )
          filesrbpf.push(keyDataFolderFile)

          newId = generateID()
          fileHeaderBuildPhase = getObject(objects, _PBXHeadersBuildPhase)
          fileHeaderBuildPhaseListFiles = getObject(fileHeaderBuildPhase, "files")
          fileHeaderBuildPhaseListFiles.push(newId)
          fileObj = createPBXBuildFileObject(newId, _NativeCallProxyId)
          # puts fileObj.to_json
          objects.merge!(fileObj)

          jsonPretty =  JSON.pretty_generate(json)
         



         File.write("#{params[:xcode_proj_filepath]}", jsonPretty)

          UI.message("setupXcode json parser end")

        rescue => ex
          UI.error("setupXcode json parser error: #{ex}")
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "get a unity xcode project 'app' and setup to project 'framework'"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        ""
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
           FastlaneCore::ConfigItem.new(key: :xcode_proj_filepath,
                                        env_name: "FL_SETUP_XCODE_PROJ_TO_FRAMEWORK_XCODE_PROJ_FILEPATH", # The name of the environment variable
                                        description: "path to xcode proj to export", # a short description of this parameter
                                        is_string: true,
                                        optional:false
                                        ),


          # FastlaneCore::ConfigItem.new(key: :development,
          #                              env_name: "FL_SETUP_XCODE_PROJ_TO_FRAMEWORK_DEVELOPMENT",
          #                              description: "Create a development certificate instead of a distribution one",
          #                              is_string: false, # true: verifies the input is a string, false: every kind of value
          #                              default_value: false) # the default value if the user didn't provide one
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['SETUP_XCODE_PROJ_TO_FRAMEWORK_CUSTOM_VALUE', 'A description of what this value contains']
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
