require 'rails_helper'

describe ApplicationHelper do
  describe '#feature_on?' do
    it 'returns true for :test_feature' do
      allow(YAML).to receive(:load_file).and_return({ 'test_feature' => true })
      expect(feature_on?(:test_feature)).to be_truthy
    end

    it 'returns false for :undefined' do
      expect(feature_on?(:undefined)).to be_falsey
    end
  end

  describe '#feature_off?' do
    it 'returns false for :test_feature' do
      allow(YAML).to receive(:load_file).and_return({ 'test_feature' => true })
      expect(feature_off?(:test_feature)).to be_falsey
    end

    it 'returns true for :undefined' do
      expect(feature_off?(:undefined)).to be_truthy
    end
  end

  describe '#locale_switch' do
    # it 'returns a link to switch locales' do
    #   expect(helper.locale_switch).to eq("")
    # end
    pending 'ActionController::UrlGenerationError: No route matches {:locale=>"en"}'
  end

  describe '#error_for_model_and_attribute' do
    #
    # Specially crafted to check error on UserProfile#name in this test example
    #
    it 'renders a div with the error message' do
      user_profile = UserProfile.new
      user_profile.name = nil
      user_profile.valid?

      expect(helper.error_for_model_and_attribute(user_profile, :name)).
        to eq("<div class=\"error-label\">(#{I18n.t('activerecord.errors.models.user_profile.attributes.name.blank')})</div>")
    end
  end
end