require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::FormRequest do

  context "load affiliate details" do
    it "#send" do
      affiliate_session = Papapi::Session.new(script_url).login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)
      request = Papapi::FormRequest.new('Pap_Affiliates_Profile_PersonalDetailsForm', 'load', affiliate_session)
      response = request.send
      expect(response[:username]).to eql('affiliate@example.com')
      expect(response['username']).to eql('affiliate@example.com')
    end
  end
end