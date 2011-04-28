require 'rubygems'
require 'builder'

module PSWinCom
  class Request
	  TIME_FORMAT = "%Y%m%d%H%M"
    def initialize args
      @user, @passwd = args[:user], args[:passwd]
      @messages = []		
    end
    def add args
      # Only accept servicecode when there is a tariff associated
      # with the message
      if args[:servicecode] && args[:tariff].nil?
        raise ArgumentError, "A message with a servicecode also needs a tariff"
      end
      
      @messages << args
      self
    end
    def xml
      builder = Builder::XmlMarkup.new
      "<?xml version=\"1.0\"?>\r\n" + 
        builder.SESSION { |s| s.CLIENT(@user); s.PW(@passwd); s.MSGLST { |lst| constr_msglst(lst) }; }
    end
    private
      def constr_msglst lst
        @messages.each_with_index do |args, id| 
          lst.MSG { |m| constr_msg(m, args, id) }
        end
      end
      def constr_msg m, args, id
        m.ID id+1
        m.TEXT args[:text]
        m.RCV args[:receiver]
        m.SND args[:sender] if args[:sender]
        m.TTL args[:TTL] if args[:TTL]
        m.TARIFF args[:tariff] if args[:tariff]
        m.SERVICECODE args[:servicecode] if args[:servicecode]
        m.DELIVERYTIME args[:deliverytime].strftime(TIME_FORMAT) if args.include? :deliverytime
      end
  end
end
