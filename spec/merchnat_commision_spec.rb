require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Merchant::Commission do
  let(:session) { Papapi::Session.new(script_url).login(merchant_login, merchant_password) }

  it "#create" do
    commission = Papapi::Merchant::Commission.new(session)
    commission.create('11111111', '11111111', 1.0, '5535d2d7','U')
  end

  it "#by_orders" do
    commission = Papapi::Merchant::Commission.new(session)
    result = commission.by_orders(['ORD_123', 'test123'], '11111111')
    expect(result.keys.length).to eq(2)
    expect(result.has_key?('ORD_123')).to be true
    expect(result.has_key?('test123')).to be true
  end
end