PSWinCom Ruby Gem
=================

A Ruby interface to the [PSWinCom SMS Gateway API](http://pswin.com/english/products/gateway).

Installation
------------
The PSWinCom Ruby API comes as a gem. Install it with gem install. Other than the ruby default libraries the only dependency is the [builder gem](https://rubygems.org/gems/builder) (which will be installed automatically for you).

    gem install pswincom

Basic Usage
-----------
To use this gem, you will need sign up for a Gateway account with PSWinCom. Demo account are available.

This piece of code demonstrates how to send a simple SMS message:

    require 'rubygems'
    require 'pswincom'

    api = PSWinCom::API.new 'username', 'password'
    api.send_sms '4712345678', 'This is a test SMS' 

Advanced Usage
--------------
Receiver and message text are the two mandatory properties when sending a message. You may specify additional properties by using a hash as the last argument to `send_sms`.

For instance this is how you would specify a sender:

    api.send_sms '4712345678', 'This is a test', :sender => 'Ruby'

Properties currently supported are:

* :sender
* :TTL - time to live in seconds
* :deliverytime - a Time object specifying when to send the message

License
-------
This code is free to use under the terms of the MIT license.
