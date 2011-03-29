require File.dirname(__FILE__) + '/../lib/pswincom/request'
require 'rubygems'
require 'rspec'

module PSWinCom
  describe Request, "#xml" do
    
    it "produces correct XML without messages" do
      request = Request.new :user => "User", :passwd => "password"
      request.xml.should == 
        "<?xml version=\"1.0\"?>\r\n" + 
        "<SESSION><CLIENT>User</CLIENT><PW>password</PW><MSGLST></MSGLST></SESSION>"
    end

    it "produces correct XML with single minimal message" do
      request = Request.new :user => "Bob", :passwd => "123"
      request.add :text => "A message", :receiver => 12345678
      request.xml.should ==
        "<?xml version=\"1.0\"?>\r\n" + 
        "<SESSION><CLIENT>Bob</CLIENT><PW>123</PW><MSGLST>" + 
        "<MSG><ID>1</ID><TEXT>A message</TEXT><RCV>12345678</RCV></MSG>" +
        "</MSGLST></SESSION>"
    end

    it "produces correct XML with single complete message" do
      request = Request.new :user => "Bob", :passwd => "123"
      request.add :text => "A delayed message", :receiver => 88888888,
        :sender => 'FooBar',
        :tariff => 500,
        :TTL => 4,
        :deliverytime => Time.utc(2011, 02, 15, 13, 30)
      request.xml.should ==
        "<?xml version=\"1.0\"?>\r\n" + 
        "<SESSION><CLIENT>Bob</CLIENT><PW>123</PW><MSGLST>" + 
        "<MSG>" +
        "<ID>1</ID><TEXT>A delayed message</TEXT><RCV>88888888</RCV>" + 
        "<SND>FooBar</SND><TTL>4</TTL><TARIFF>500</TARIFF><DELIVERYTIME>201102151330</DELIVERYTIME>" +
        "</MSG>" +
        "</MSGLST></SESSION>"
    end

    it "produces correct XML with multiple messages" do
      request = Request.new :user => "Bob", :passwd => "123"
      request.add :text => "A message", :receiver => 12345678
      request.add :text => "Another message", :receiver => 23456789
      request.xml.should ==
        "<?xml version=\"1.0\"?>\r\n" + 
        "<SESSION><CLIENT>Bob</CLIENT><PW>123</PW><MSGLST>" + 
        "<MSG><ID>1</ID><TEXT>A message</TEXT><RCV>12345678</RCV></MSG>" +
        "<MSG><ID>2</ID><TEXT>Another message</TEXT><RCV>23456789</RCV></MSG>" +
        "</MSGLST></SESSION>"
    end
  end
end

