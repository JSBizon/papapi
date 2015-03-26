require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Affiliate::Commission do
  let(:commission) { described_class.new(Papapi::Session.new(script_url).
                                            login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)) }

  it "#by_orders" do
    result = commission.by_orders(['ORD_123', 'test123'])
    expect(result.keys.length).to eq(2)
    expect(result.has_key?('ORD_123')).to be true
    expect(result.has_key?('test123')).to be true
  end

  it "#by_orders(empty)" do
    result = commission.by_orders([])
    expect(result.keys.length).to eq(0)
  end
end