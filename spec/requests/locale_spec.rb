require 'rails_helper'

describe 'locale switching' do
  it 'switches to English' do
    I18n.locale = :de
    get root_path, locale: 'en'
    expect(response.body).to include('Home')
  end

  it 'switches to German' do
    I18n.locale = :en
    get root_path, locale: 'de'
    expect(response.body).to include('Startseite')
  end

  it 'save locale in the session' do
    I18n.locale = :de
    get root_path, locale: 'en'
    expect(response.body).to include('Home')

    get root_path
    expect(response.body).to include('Home')

    get root_path, locale: 'de'
    expect(response.body).to include('Startseite')
  end
end