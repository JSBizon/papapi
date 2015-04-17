require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Affiliate::Commission do
  it "#load" do
    session = Papapi::Session.new(script_url).login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)
    affiliate = Papapi::Affiliate.new(session)
    affiliate.load()
    expect(affiliate.id).to eq('11111111')
    expect(affiliate[:username]).to eq('affiliate@example.com')
  end
end