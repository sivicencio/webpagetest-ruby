# Webpagetest Ruby Wrapper

This gem is a Ruby wrapper for the main features of [Webpagetest](http://www.webpagetest.org/) REST API.
Features included so far:
- Run tests with all [specified](https://sites.google.com/a/webpagetest.org/docs/advanced-features/webpagetest-restful-apis#TOC-Parameters) parameters of the API.
- Check test status
- Get available test locations

This gem is inspired by [Susuwatari](https://github.com/moviepilot/susuwatari) gem, so several ideas were taken from there (it's like a rewrite with some modifications). There were two main reasons to create a new `Webpagetest` gem:
- Susuwatari uses [Rest client](https://github.com/rest-client/rest-client) to make HTTP requests, but this gem uses [Faraday](https://github.com/lostisland/faraday) instead, since it's more flexible and extensible in terms of HTTP connection.
- Susuwatari `Client` class is focused on test runs, but no general-purpose wrapper has been built so far (for example, locations were missing).

## Installation

Add this line to your application's Gemfile:

    gem 'webpagetest'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install webpagetest

## Usage
All you require to use the gem is a Webpagetest API key in order to run tests. You can ask your own by emailing Patrick Meenan, like he explains in [Webpagetest docs](https://sites.google.com/a/webpagetest.org/docs/advanced-features/webpagetest-restful-apis).

Basically, you need to instantiate an object of `Webpagetest` class, and then use it to interact with the API.

```ruby
require 'webpagetest'

wpt = Webpagetest.new(k: your_api_key)

# Run test

# Get test result
test = wpt.test_result("some_test_id")


# Locations
locations = wpt.locations
locations.keys.values # => ["Dulles_IE6", "Dulles_IE7", "Sydney:Chrome", "Sydney:Firefox", ...]
```

## Contribution
This gem is just a starting point wrapper, so much work can be done from here.

Any contribution is appreciated. Just fork this repository and submit the appropriate pull request if you want to add features to this gem.
