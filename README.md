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

    $ icwot <HOST>

It will:
1.  Register to the specified host by ` POST ` method and sending in the body informations how to contact the client.
 Currently, it is the uri needed for the host to send informations to the client.
2.  Start a [sinatra](http://www.sinatrarb.com) server on default port 4567. Logging messages will be saved by default to :
your-home-directory/log/icwot-msg.log

By default, the header of the ` POST ` method will have these values:

     content-type=application/json
     accept=application/json

You can change it by specifying the ` -c your-content-type ` and ` -a your-accept ` in the command line call. There are several
options for the commande line:

    icwot <host>
                -h print help
                -l the host is localhost
                -c the content-type value for the header application/json by default
                -a the accept value for the header  text/plain by default
                -p the port where to run the server
                -t the protocol to use http:// by default
                -l where to save the log. By default your-home-directory/log/icwot-{port}-msg.log
                host is where to register for the service.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
