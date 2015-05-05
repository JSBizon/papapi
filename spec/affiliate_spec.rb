require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Affiliate::Commission do
  it "#load" do
    session = Papapi::Session.new(script_url).login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)
    affiliate = Papapi::Affiliate.new(session)
    affiliate.load
    expect(affiliate.id).to eq('11111111')
    expect(affiliate[:username]).to eq('affiliate@example.com')
  end

  it "#load - by merchant session" do
    session = Papapi::Session.new(script_url).login(merchant_login, merchant_password)
    affiliate = Papapi::Affiliate.new(session)
    affiliate.id = '11111111'
    affiliate.load
    expect(affiliate.id).to eq('11111111')
    expect(affiliate[:username]).to eq('affiliate@example.com')
  end

  it "#save" do
    session = Papapi::Session.new(script_url, true).login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)
    affiliate = Papapi::Affiliate.new(session)
    affiliate.load
    expect(affiliate.id).to eq('11111111')
    affiliate[:data1] = 'http://google.com'
    affiliate[:data2] = 'Fake inc.'
    affiliate[:data3] = 'str. Fake'
    affiliate[:data4] = 'Fake'
    affiliate[:data5] = 'CA'
    affiliate[:data6] = 'USA'
    affiliate[:firstname] = 'papapi_a_test'
    affiliate.save
    expect(affiliate[:firstname]).to eq('papapi_a_test')
  end

  it "#save - by merchant session" do
    session = Papapi::Session.new(script_url, true).login(merchant_login, merchant_password)
    affiliate = Papapi::Affiliate.new(session)
    affiliate.id = '11111111'
    affiliate.load
    expect(affiliate.id).to eq('11111111')
    affiliate[:data1] = 'http://google.com'
    affiliate[:data2] = 'Fake inc.'
    affiliate[:data3] = 'str. Fake'
    affiliate[:data4] = 'Fake'
    affiliate[:data5] = 'CA'
    affiliate[:data6] = 'USA'
    affiliate[:firstname] = 'papapi_m_test'
    affiliate.save
    expect(affiliate[:firstname]).to eq('papapi_m_test')
  end

end