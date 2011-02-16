%w( request
    httpsender
).each do |lib|
    require File.join(File.dirname(__FILE__), lib)
end
require 'rexml/document'

module PSWinCom
  class API
    class << self
      attr_accessor :test_mode
      attr_accessor :debug_mode
      attr_accessor :api_host
    end

    self.test_mode = false;
    self.debug_mode = false;

    def initialize user, password
      if user.to_s.empty? or password.to_s.empty?
        raise ArgumentError, "You must specify username and password" 
      end
      @user, @password = user, password
      @request = Request.new :user => @user, :passwd => @password      
    end

    def send_sms to = nil, text = nil, args={}
      add_sms(to, text, args) unless (to.nil? || text.nil?)

      # Check if there are any messages to send
      if REXML::Document.new(@request.xml).
          root.get_elements('MSGLST/MSG').count == 0
        raise ArgumentError, 'There are no SMS to send'
      end
      
      sender = HttpSender.new
      PSWinCom.debug "Request", @request.xml
      
      unless self.class.test_mode
        result = sender.send(@request) 
        PSWinCom.debug "Result", result.body
      end
      
      return result
    end

    def add_sms to, text, args = {}
      @request.add({:text => text, :receiver => to }.merge(args))
    end
  end
end
