describe Fastlane::Actions::CarthageCacheFtpsAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The carthage_cache_ftps plugin is working!")

      Fastlane::Actions::CarthageCacheFtpsAction.run(nil)
    end
  end
end
