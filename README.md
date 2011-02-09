PSWinCom Ruby Gem
=================

A Ruby interface to the [PSWinCom SMS Gateway](http://pswin.com/english/products/gateway).

Installation
------------

    gem install pswincom

Basic Usage
-----------
To use this gem, you will need sign up for a Gateway account with PSWinCom. Demo account are available.

This piece of code demonstrates how to send a simple SMS message:

    require 'rubygems'
    require 'pswincom'

    api = PSWinCom::API.new 'username', 'password'
    api.send_sms 4712345678, 'This is a test SMS' 

Properties
----------
Receiver and message text are the two mandatory properties when sending a message. You may specify additional properties by using a hash as the last argument to `send_sms`.

For instance this is how you would specify a sender:

    api.send_sms 4712345678, 'This is a test', :sender => 'Ruby'

Properties currently supported are:

* :sender
* :TTL - time to live in minutes
* :deliverytime - a Time object specifying when to send the message

Specifying Host
---------------
The gem is set to use a particular PSWinCom SMS Gateway by default. The host can be changed globaly by setting api_host:

    PSWinCom::API.api_host = 'http://some.server/sms'

Modes
-----
For testing purposes the API provides a couple of modes you can set globally to control how the gem works.

    PSWinCom::API.test_mode = true

.. will make you use the API without actually sending any messages.

    PSWinCom::API.debug_mode = true

.. will make the API output debug information to standard out.

License
-------
This code is free to use under the terms of the MIT license.
