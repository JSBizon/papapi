require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Affiliate::Commission do
  it "#send" do
    session = Papapi::Session.new(script_url).login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)
    commission = Papapi::Affiliate::Commission.new(session)

  end
end