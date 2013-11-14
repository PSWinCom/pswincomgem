require File.dirname(__FILE__) + '/../lib/pswincom/httpsender'
require File.dirname(__FILE__) + '/mocks'
require 'rubygems'
require 'rspec'

module PSWinCom

  describe HttpSender do
    describe "#initialize" do
      it "uses default host" do
        HttpSender.new.instance_variable_get(:@host).should == 'http://gw2-fro.pswin.com:81/'
      end
      it "uses custom host if specified" do
        API.api_host = 'http://google.com/'
        HttpSender.new.instance_variable_get(:@host).should == 'http://google.com/'
      end
    end
    describe "#send" do
      it "sends to specified host and port" do
        API.api_host = 'http://server.com:8081/'
        HttpSender.new.send(XmlMock.new(""))
        Net::HTTP.host.should == "server.com"
        Net::HTTP.port.should == 8081      
      end
      it "sends XML with correct content type" do
        post = HttpSender.new.send(XmlMock.new("<xml>foo</xml>"))
        post.body.should == "<xml>foo</xml>"
        post.content_type.should == 'text/xml charset=ISO-8859-1'
      end
    end
  end
end

