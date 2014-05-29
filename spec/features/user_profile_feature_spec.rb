require 'spec_helper'

feature 'Working with the UserProfile', with_devise_user: true do
  scenario 'Successfully changing some attributes' do
    # Setup
    user_logs_in

    # Interaction
    click_link I18n.t('header.user.user_profile')
    fill_in :user_profile_name, with: 'Another Name'
    click_on I18n.t('update')

    # Result (Flash and unchanged field value)
    expect(page).to have_content(I18n.t('update_success'))
    expect(page.find_field('user_profile_name').value).to eq('Another Name')
  end

  scenario 'Failing validations on attempted update' do
    # Setup
    user_logs_in

    # Interaction
    click_link I18n.t('header.user.user_profile')
    fill_in :user_profile_name, with: ''
    click_on I18n.t('update')

    # Result (Flash, error message and unchanged field value)
    expect(page).to have_content(I18n.t('update_failure'))
    expect(page).to have_content(I18n.t('activerecord.errors.models.user_profile.attributes.name.blank'))
    expect(page.find_field('user_profile_name').value).to eq('')
  end
end