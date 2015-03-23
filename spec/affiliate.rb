require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Affiliate::Commission do
  it "#send" do
    session = Papapi::Session.new(script_url).login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)
    affiliate = Papapi::Affiliate.new(session)
    affiliate.load()
    expect(affiliate.id).to be eql('11111111')
  end
end