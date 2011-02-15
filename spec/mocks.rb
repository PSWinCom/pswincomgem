module PSWinCom
  
  def self.debug label, value; end

  class API
    class << self
      attr_accessor :api_host
    end
  end

  class XmlMock
    attr_accessor :xml
    def initialize xml
      @xml = xml
    end
  end
end

module Net
  class HTTP
    class << self
      attr_accessor :host, :port
    end
    def self.start host, port
      @host, @port = host, port
      yield HTTP.new(host, port)
    end
    def request post
      return post
    end 
  end
end
