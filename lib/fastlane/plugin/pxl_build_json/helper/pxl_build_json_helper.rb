require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class PxlBuildJsonHelper
      # class methods that you define here become available in your action
      # as `Helper::PxlBuildJsonHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the pxl_build_json plugin helper!")
      end
    end
  end
end
