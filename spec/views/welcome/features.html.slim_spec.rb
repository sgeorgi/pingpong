require 'rails_helper'

describe 'welcome/index.html.slim' do
  it 'renders without fail' do

    expect { render }.not_to raise_error
  end
end