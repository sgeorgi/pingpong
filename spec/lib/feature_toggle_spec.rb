require 'spec_helper'

describe FeatureToggle do
  describe '#on?' do
    it 'returns true for :test_feature if enabled' do
      allow(YAML).to receive(:load_file).and_return({ 'test_feature' => true })
      expect(FeatureToggle.on?(:test_feature)).to be_true
    end

    it 'returns false for :test_feature if disabled' do
      allow(YAML).to receive(:load_file).and_return({ 'test_feature' => false })
      expect(FeatureToggle.on?(:test_feature)).to be_false
    end

    it 'returns nil for undefined feature' do
      expect(FeatureToggle.on?(:undefined)).to be_false
    end
  end

  describe '#off?' do
    it 'returns true for activated :test_feature if disabled' do
      allow(YAML).to receive(:load_file).and_return({ 'test_feature' => false })
      expect(FeatureToggle.off?(:test_feature)).to be_true
    end

    it 'returns false for activated :test_feature if enabled' do
      allow(YAML).to receive(:load_file).and_return({ 'test_feature' => true })
      expect(FeatureToggle.off?(:test_feature)).to be_false
    end

    it 'returns true for undefined feature' do
      expect(FeatureToggle.off?(:undefined)).to be_true
    end
  end
end