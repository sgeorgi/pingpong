require 'spec_helper'

describe PingPongTablesController do
  describe 'GET #index (JSON)' do
    before(:each) do
      allow(PingPongTable).to receive(:all).and_return(build :ping_pong_table)
      get :index, format: :json
    end

    it 'returns with status 200' do
      expect(response.status).to be == 200
    end

    it 'render parseable JSON' do
      expect { JSON.parse(response.body) }.not_to raise_error
    end
  end
end