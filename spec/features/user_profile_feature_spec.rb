require 'spec_helper'

feature 'Working with the UserProfile', with_devise_user: true do
  scenario 'Successfully changing some attributes' do
    pending 'Feature :user_login and :user_profile are disabled' unless FeatureToggle.on?(:user_login) and FeatureToggle.on?(:user_profile)
    # Setup
    user_logs_in

    # Interaction
    click_link I18n.t('header.user.user_profile')
    fill_in :user_profile_name, with: 'Another Name'
    fill_in :user_profile_profile_address_attributes_street_1, with: 'A street name and number'
    fill_in :user_profile_profile_address_attributes_postal_code, with: 12345
    fill_in :user_profile_profile_address_attributes_city, with: 'The city where I live in'

    click_on I18n.t('update')

    # Result (Flash and unchanged field value)
    expect(page).to have_content(I18n.t('update_success'))
    expect(page.find_field('user_profile_name').value).to eq('Another Name')
  end

  scenario 'Failing validations on attempted update' do
    pending 'Feature :user_login and :user_profile are disabled' unless FeatureToggle.on?(:user_login) and FeatureToggle.on?(:user_profile)
    # Setup
    user_logs_in

    # Interaction
    click_link I18n.t('header.user.user_profile')
    fill_in :user_profile_name, with: ''
    fill_in :user_profile_profile_address_attributes_street_1, with: 'A street name and number'
    fill_in :user_profile_profile_address_attributes_postal_code, with: 12345
    fill_in :user_profile_profile_address_attributes_city, with: 'The city where I live in'
    click_on I18n.t('update')

    # Result (Flash, error message and unchanged field value)
    expect(page).to have_content(I18n.t('update_failure'))
    expect(page).to have_content(I18n.t('activerecord.errors.models.user_profile.attributes.name.blank'))
    expect(page.find_field('user_profile_name').value).to eq('')
  end
end