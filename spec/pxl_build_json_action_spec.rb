describe Fastlane::Actions::PxlBuildJsonAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The pxl_build_json plugin is working!")

      Fastlane::Actions::PxlBuildJsonAction.run(nil)
    end
  end
end
