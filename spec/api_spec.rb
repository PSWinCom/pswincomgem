require File.dirname(__FILE__) + '/../lib/pswincom/api'
require File.dirname(__FILE__) + '/mocks'
require 'rubygems'
require 'rspec'

module PSWinCom
  describe API do
    describe "test_mode" do
      it "should be false by default" do
        API.test_mode.should == false
      end
      it "should be settable" do
        API.test_mode = true
        API.test_mode.should == true
      end
    end
    describe "debug_mode" do
      it "should be false by default" do
        API.debug_mode.should == false
      end
      it "should be settable" do
        API.debug_mode = true
        API.debug_mode.should == true
      end
    end
    describe "#initialize" do
      it "should fail if username or password is missing" do
        lambda { API.new(nil, nil) }.should raise_error
        lambda { API.new("user", nil) }.should raise_error
        lambda { API.new(nil, "password") }.should raise_error
        lambda { API.new("", "") }.should raise_error
      end
    end
    describe "#add_sms" do
      it "should add all messages to request" do
        api = API.new "user", "password"
        api.add_sms 123, "A"
        api.add_sms 456, "B", :TTL => 3

        api.instance_eval do
          @request.instance_eval do
            @messages.size.should == 2
            @messages[0][:receiver].should == 123
            @messages[1][:text].should == "B"
            @messages[1][:TTL].should == 3
          end
        end
      end
    end
    describe "#send_sms" do
      it "should send message" do
        API.test_mode = false;  
        api = API.new "user", "passwd"
        result = api.send_sms 12345, "A test message", :sender => 1111,
          :tariff => 500, :servicecode => 15001
        result.body.should == 
          "<?xml version=\"1.0\"?>\r\n" + 
          "<SESSION><CLIENT>user</CLIENT><PW>passwd</PW><MSGLST>" + 
          "<MSG><ID>1</ID><TEXT>A test message</TEXT><RCV>12345</RCV><SND>1111</SND>" +
          "<TARIFF>500</TARIFF><SERVICECODE>15001</SERVICECODE></MSG></MSGLST></SESSION>"
      end
      it "should send previously added messages as well" do
        API.test_mode = false;  
        api = API.new "user", "passwd"
        api.add_sms 1, "A"
        result = api.send_sms 2, "B"
        result.body.should == 
          "<?xml version=\"1.0\"?>\r\n" + 
          "<SESSION><CLIENT>user</CLIENT><PW>passwd</PW><MSGLST>" + 
          "<MSG><ID>1</ID><TEXT>A</TEXT><RCV>1</RCV></MSG>" + 
          "<MSG><ID>2</ID><TEXT>B</TEXT><RCV>2</RCV></MSG>" + 
          "</MSGLST></SESSION>"
      end      
      it "should send previously added messages when no arguments" do
        API.test_mode = false;  
        api = API.new "user", "passwd"
        api.add_sms 1, "A"
        api.add_sms 2, "B"
        result = api.send_sms
        result.body.should == 
          "<?xml version=\"1.0\"?>\r\n" + 
          "<SESSION><CLIENT>user</CLIENT><PW>passwd</PW><MSGLST>" + 
          "<MSG><ID>1</ID><TEXT>A</TEXT><RCV>1</RCV></MSG>" + 
          "<MSG><ID>2</ID><TEXT>B</TEXT><RCV>2</RCV></MSG>" + 
          "</MSGLST></SESSION>"
      end
      it "should fail if no messages has been added" do
        api = API.new "user", "passwd"
        lambda { result = api.send_sms }.should raise_error
      end
    end
  end
end
