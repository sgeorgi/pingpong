#
# Simple Module that serves as a Feature Toggle. Features are declared in config/features.yml
# and can be checked against e.g. FeatureToggle.on?(:super_service) 
#
module FeatureToggle
  #
  # Returns wheter a specified feature is toggled
  # 
  # @example
  #  FeatureToggle.on?(:super_feature) => false
  # 
  # @param [String or Symbol] _feat feature identifier
  # @return [Boolean] toggle state
  #
  def self.on?(_feat)
    load_from_yaml
    @features[_feat.to_s]
  end

  #
  # Returns wheter a specified feature is NOT toggled
  #
  # @example
  #  FeatureToggle.on?(:super_feature) => true
  # 
  # @param [String or Symbol] _feat feature identifier
  # @return [Boolean] toggle state
  #
  def self.off?(_feat)
    load_from_yaml
    ! on?(_feat)
  end

  def self.load_from_yaml
    file = File.join(Rails.root, 'config/features.yml')
    raise 'Feature File not found (config/features.yml)' unless File.exists?(file)
    @features = YAML.load_file(file)
  end
end
