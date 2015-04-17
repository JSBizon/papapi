require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Affiliate::Commission do

  it "#load" do
    session = Papapi::Session.new(script_url,true).login(merchant_login, merchant_password)
    merchant = Papapi::Merchant.new(session)
    merchant.load()
    expect(merchant[:username]).to eq('merchant@example.com')
  end

  it "#create_affiliate" do
    session = Papapi::Session.new(script_url, true).login(merchant_login, merchant_password)
    merchant = Papapi::Merchant.new(session)

    affiliate = merchant.create_affiliate({
                                  :username => 'user@example.com',
                                  :rpassword => 'password',
                                  :firstname => 'Tom',
                                  :lastname => 'Foolery',
                                  :url => 'http://playpen.com/models/tom-foolery',
                                  :company => 'Foolery INC',
                                  :street => '875 Rodeo Drive',
                                  :city => 'Beverly Hills',
                                  :state => 'CA',
                                  :country => 'US',
                                  :zip => '90210',
                                  :phone => '3234789181',
                                  :refid => 'tom-foolery',
                                  :rstatus => 'A'
                              })


    expect(affiliate[:username]).to eq('user@example.com')
    expect(affiliate[:refid]).to eq('tom-foolery')

    merchant.remove_affiliate(affiliate[:Id])

  end

  it "#list_fields" do
    session = Papapi::Session.new(script_url,true).login(merchant_login, merchant_password)
    merchant = Papapi::Merchant.new(session)
    fields = merchant.list_fields

    expect(fields[:parentuserid][:formfieldid]).to eq('1')
    end
end