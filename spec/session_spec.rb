require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Session do
  let(:session) { described_class.new(script_url) }

  context "as merchant" do
    it "#login ok" do
      expect(session.id).to be_nil
      session.login(merchant_login, merchant_password)
      expect(session.id).to_not be_nil
      expect(session.id.length).to be > 8
      expect(session.is_merchant?).to be true
    end

    it "#login not ok" do
      expect { session.login("bad login", "bad password") }.to raise_error
    end
  end

  context "as affiliate" do
    it "#login ok" do
      expect(session.id).to be_nil
      session.login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)
      expect(session.id).to_not be_nil
      expect(session.id.length).to be > 8
      expect(session.is_affiliate?).to be true
    end

    it "#login not ok" do
      expect { session.login("bad login", "bad password", Papapi::Session::AFFILIATE) }.to raise_error
    end
  end
end