require File.dirname(__FILE__) + '/../lib/pswincom/utility/options'
require 'rubygems'
require 'rspec'

module PSWinCom
  module Utility

    class Options
      class << self
        # Faking the config file in order 
        # to test use of default values
        def load_defaults
          YAML.load(<<EOF 
username: Jonny
password: XYZ
from: TheBoss
host: http://sms5.pswin.com:81/
EOF
)
        end
      end
    end
    
    describe Options do
      describe "parse" do

        it "should parse recipient and message" do
          options = Options.parse(["12345678", "This is a message"])
          options.recipient.should == "12345678"
          options.message.should == "This is a message"
        end

        it "should parse username" do
          Options.parse(
            ["-u", "Bob", "12345678", "This is a message"]).
            username.should == "Bob"
        end

        it "should parse password" do
          Options.parse(
            ["--password", "p@ssw0rd", "12345678", "This is a message"]).
            password.should == "p@ssw0rd"
        end

        it "should parse sender" do
          Options.parse(
            ["--from", "FOO", "12345678", "This is a message"]).
            from.should == "FOO"
        end
        
        it "should parse host" do
          Options.parse(
            ["--host", "http://sms3.pswin.com/", "12345678", "This is a message"]).
            host.should == "http://sms3.pswin.com/"
        end

        it "should use defaults from config" do
          options = Options.parse(["12345678", "This is a message"])
          options.username.should == "Jonny"
          options.password.should == "XYZ"
          options.from.should == "TheBoss"
          options.host.should == "http://sms5.pswin.com:81/"
        end

      end
    end
  end
end
