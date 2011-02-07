%w( request
    httpsender
).each do |lib|
    require File.join(File.dirname(__FILE__), lib)
end

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
      @user, @password = user, password 
    end

    def send_sms to, text, args={}      
      request = create_request to, text, args
      sender = HttpSender.new 
      PSWinCom.debug "Request", request.xml
      result = sender.send(request) unless self.class.test_mode
      PSWinCom.debug "Result", result
      return result
    end

    def create_request to, text, args
      request = Request.new :user => @user, :passwd => @password      
      request.add({:text => text, :receiver => to }.merge(args))
    end
  end
end
