describe Fastlane::Actions::PixowlAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The pixowl plugin is working!")

      Fastlane::Actions::PixowlAction.run(nil)
    end
  end
end
