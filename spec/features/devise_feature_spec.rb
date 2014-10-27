require 'rails_helper'

# email = 'test@test.com'
# password = 'ABC123xyz!!'

feature 'Devise', with_devise_user: true do
  scenario 'Existing User logs in and logs out' do
    pending 'Feature :user_login is disabled' unless FeatureToggle.on?(:user_login)
    user_logs_in

    click_link I18n.t('header.user.logout')
    expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
  end

  scenario 'User registers and confims via Email' do
    pending 'Feature :user_login is disabled' unless FeatureToggle.on?(:user_login)
    ActionMailer::Base.deliveries = []

    visit '/'
    click_link I18n.t('header.user.signup')

    fill_in :user_email, with: 'test2@test.com'
    fill_in :user_password, with: 'ABC123xyz!!'
    fill_in :user_password_confirmation, with: 'ABC123xyz!!'
    click_button I18n.t('devise.ui.sign_up')

    expect(page).to have_content(I18n.t('devise.registrations.signed_up_but_unconfirmed'))
    expect(ActionMailer::Base.deliveries.last.to).to eq(['test2@test.com'])

    user_visits_link_in_email(ActionMailer::Base.deliveries.last)
    expect(page).to have_content(I18n.t('devise.confirmations.confirmed'))
  end

  scenario 'User changes password' do
    pending 'Feature :user_login is disabled' unless FeatureToggle.on?(:user_login)
    user_logs_in

    click_link I18n.t('header.user.profile')

    fill_in :user_password, with: 'DBC123xyz!!'
    fill_in :user_password_confirmation, with: 'DBC123xyz!!'
    fill_in :user_current_password, with: 'ABC123xyz!!'
    click_button I18n.t('update')

    expect(page).to have_content(I18n.t('devise.registrations.updated'))
  end

  scenario 'User changes email address and confirms' do
    pending 'Feature :user_login is disabled' unless FeatureToggle.on?(:user_login)
    ActionMailer::Base.deliveries = []

    user_logs_in

    click_link I18n.t('header.user.profile')
    fill_in :user_current_password, with: 'ABC123xyz!!'
    fill_in :user_email, with: 'another@email.com'
    click_button I18n.t('update')

    expect(page).to have_content(I18n.t('devise.registrations.update_needs_confirmation'))
    expect(ActionMailer::Base.deliveries.last.to).to eq(['another@email.com'])

    user_visits_link_in_email(ActionMailer::Base.deliveries.last)
    expect(page).to have_content(I18n.t('devise.confirmations.confirmed'))
  end

  scenario 'User forgets password' do
    pending 'Feature :user_login is disabled' unless FeatureToggle.on?(:user_login)
    ActionMailer::Base.deliveries = []

    visit '/'
    click_link I18n.t('header.user.login')
    click_link I18n.t('devise.ui.forgot_password')

    expect(page).to have_css('h2', text: I18n.t('devise.ui.forgot_your_password'))
    fill_in :user_email, with: 'test@test.com'
    click_button I18n.t('devise.ui.send_reset_link')

    expect(page).to have_content(I18n.t('devise.passwords.send_instructions'))
    expect(ActionMailer::Base.deliveries.last.to).to eq(['test@test.com'])

    user_visits_link_in_email(ActionMailer::Base.deliveries.last)
    expect(page).to have_content(I18n.t('devise.ui.change_your_password'))

    fill_in :user_password, with: '1234567!'
    fill_in :user_password_confirmation, with: '1234567!'
    click_button I18n.t('devise.ui.change_your_password')

    expect(page).to have_content(I18n.t('devise.passwords.updated'))
  end

  scenario 'User requests another confirmation mail' do
    pending 'Feature :user_login is disabled' unless FeatureToggle.on?(:user_login)
    ActionMailer::Base.deliveries = []

    visit '/'
    click_link I18n.t('header.user.signup')

    fill_in :user_email, with: 'test2@test.com'
    fill_in :user_password, with: 'ABC123xyz!!'
    fill_in :user_password_confirmation, with: 'ABC123xyz!!'
    click_button I18n.t('devise.ui.sign_up')

    expect(page).to have_content(I18n.t('devise.registrations.signed_up_but_unconfirmed'))
    expect(ActionMailer::Base.deliveries.last.to).to eq(['test2@test.com'])

    visit '/'
    click_link I18n.t('header.user.login')
    click_link I18n.t('devise.ui.no_confimation_mail')
    fill_in :user_email, with: 'test2@test.com'
    click_on I18n.t('devise.ui.resend_cofirmation')

    expect(ActionMailer::Base.deliveries.size).to be == 2
    expect(ActionMailer::Base.deliveries.last.to).to eq(['test2@test.com'])

    user_visits_link_in_email(ActionMailer::Base.deliveries.last)
    expect(page).to have_content(I18n.t('devise.confirmations.confirmed'))
  end
end