require 'spec_helper'

describe PingPongTable do
  describe 'ATTRIBUTES' do
    let(:ping_pong_table) { PingPongTable.new }

    [:longitude, :latitude, :street, :street_number, :postal_code, :city].each do |_attribute|
      it "has attribute ##{_attribute}" do
        expect(ping_pong_table).to have_attribute(_attribute)
      end
    end
  end

  describe 'VALIDATIONS' do
    let(:ping_pong_table) { PingPongTable.new }

    [:street, :street_number, :postal_code, :city].each do |_attribute|
      it "validates presence of attribute ##{_attribute}" do
        expect(ping_pong_table).to validate_presence_of(_attribute)
      end
    end
  end

  describe 'CALLBACKS' do
    describe 'after_validation :geocode, if: ...' do
      it 'calls method #geocode after validating' do
        _ping_pong_table = build :ping_pong_table
        expect(_ping_pong_table).to receive(:geocode)
        _ping_pong_table.valid?
      end

      it 'geocodes lat/lng after validation' do
        _ping_pong_table = build :ping_pong_table
        _ping_pong_table.valid?
        expect(_ping_pong_table.latitude).not_to be_nil
      end

      it 'does not geocode when address components are incomplete' do
        _ping_pong_table = build :ping_pong_table, street_number: nil
        expect(_ping_pong_table).not_to receive(:geocode)
        _ping_pong_table.valid?
      end

      it 'does not geocode again' do
        _ping_pong_table = build :ping_pong_table
        _ping_pong_table.valid?
        expect(_ping_pong_table).not_to receive(:geocode)
        _ping_pong_table.valid?
      end
    end
  end

  describe '#address' do
    it 'returns a fixed combination of attributes' do
      _ping_pong_table = build :ping_pong_table

      expect(_ping_pong_table.address).to eq("#{_ping_pong_table.street} #{_ping_pong_table.street_number}," +
                                               " #{_ping_pong_table.postal_code} #{_ping_pong_table.city}")
    end
  end
end