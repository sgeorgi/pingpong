# Some useful basic helper methods
module ApplicationHelper

  #
  # Displays the alternate locale icon of the already enabled locale
  # @return a link_to element for changing locale
  # TODO: Make me pass in view tests
  #
  def locale_switch
    _locale = I18n.locale
    _new_locale = case _locale
                    when :en
                      'de'
                    when :de
                      'en'
                    else

                  end

    link_to image_tag("#{_new_locale}.png"), url_for(locale: _new_locale)
  end

  #
  # Checks if given Feature is active by consulting the FeatureToggle module.
  #
  # @example
  #   feature_on?(:super_feature) # => true
  #
  # @param _feature [String] the feature to check
  # @return [Boolean] feature toggle's state
  #
  def feature_on?(_feature)
    FeatureToggle.on?(_feature)
  end

  #
  # Checks if given Feature is inactive by consulting the FeatureToggle module.
  #
  # @example
  #   feature_off?(:super_feature) # => false
  #
  # @param _feature [Symbol] feature to check
  # @return [Boolean] feature toggle's state
  #
  def feature_off?(_feature)
    FeatureToggle.off?(_feature)
  end

  def error_for_model_and_attribute(_model, _attribute)
    if _model.errors[_attribute].any?
      content_tag :div, class: 'error-label' do
        "(#{_model.errors[_attribute].join(', ')})"
      end
    end
  end
end
