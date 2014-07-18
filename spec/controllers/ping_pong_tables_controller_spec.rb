require 'spec_helper'

describe PingPongTablesController do
  describe 'GET #index (JSON)' do
    let(:center) { [53.5779706, 10.0027104] }
    let(:edge) { [53.5779706, 10.0027104] }

    before(:each) do
      allow(PingPongTable).to receive(:find_for_center_and_edge).and_return(build :ping_pong_table)
      get :index, c: center, e: edge, format: :json
    end

    it 'returns with status 200' do
      expect(response.status).to be == 200
    end

    it 'render parseable JSON' do
      expect { JSON.parse(response.body) }.not_to raise_error
    end

    it 'calls PingPongTable.find_for_center_and_zoom' do
      expect(PingPongTable).to have_received(:find_for_center_and_edge).with(center, edge)
    end
  end
end