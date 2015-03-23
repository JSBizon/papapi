# Papapi

A gem to interface for Post Affiliate Pro API.

# Getting started example

Create session as merchant

session = new Papapi::Session("http://demo.postaffiliatepro.com/scripts/server.php");
session.login("merchant@example.com", "demo")

Create session as affiliate in debug mode

session = new Papapi::Session("http://demo.postaffiliatepro.com/scripts/server.php",true);
session.login("affiliate@example.com", "demo")

Get information about affiliate

affiliate = Papapi::Affiliate.new(session)
affiliate.load()
affiliate[:username]





