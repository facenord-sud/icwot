# Icwot

RESTfull [sinatra](http://www.sinatrarb.com) server providing inversion of control for logging messages from another RESTfull application web-server

## Installation

Add this line to your application's Gemfile:

    gem 'icwot'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install icwot

## Usage

In a terminal run:

    $ icwot

It will start a [sinatra](http://www.sinatrarb.com) server on port 4567. Logging messages will be saved to : your-home-directory/log/icwot-msg.log

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
