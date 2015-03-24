require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Merchant::Commission do
  it "#by_orders" do
    session = Papapi::Session.new(script_url).login(merchant_login, merchant_password)
    commission = Papapi::Merchant::Commission.new(session)
    result = commission.by_orders(['ORD_123', 'test123'], '11111111')
    expect(result.keys.length).to eq(2)
    expect(result.has_key?('ORD_123')).to be true
    expect(result.has_key?('test123')).to be true
  end
end