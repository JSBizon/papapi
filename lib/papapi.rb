require 'net/http'
require 'uri'
require 'json'

Dir[File.dirname(__FILE__) + '/papapi/*.rb'].each {|file| require file }

module Papapi

end
