# Papapi

A gem for access to the Post Affiliate Pro API.

## Getting started example

###Create session as merchant

```ruby
session = new Papapi::Session("http://demo.postaffiliatepro.com/scripts/server.php");
session.login("merchant@example.com", "demo")
```

###Create session as affiliate in debug mode

```ruby
session = new Papapi::Session("http://demo.postaffiliatepro.com/scripts/server.php",true);
session.login("affiliate@example.com", "demo")
```

###Get information about affiliate

```ruby
affiliate = Papapi::Affiliate.new(session)
affiliate.load()
affiliate[:username]
```

###Get information about merchant

```ruby
merchant = Papapi::Merchant.new(session)
merchant.load()
merchant[:username]
```

More documentation, and examples can be found [there](https://support.qualityunit.com/712031-API)




