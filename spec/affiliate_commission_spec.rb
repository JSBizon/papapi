require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Affiliate::Commission do
  it "#by_orders" do
    session = Papapi::Session.new(script_url).login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)
    commission = Papapi::Affiliate::Commission.new(session)
    result = commission.by_orders(['ORD_123', 'test123'])
    expect(result.keys.length).to eq(2)
    expect(result.has_key?('ORD_123')).to be true
    expect(result.has_key?('test123')).to be true
  end
end