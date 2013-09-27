require 'uri'
require 'net/http'

module PSWinCom
  class HttpSender
    API_HOST = 'http://gw2-fro.pswin.com:81/'

    def initialize
      @host = API.api_host || API_HOST
      PSWinCom.debug "Host", @host
    end

    def send request
      url = URI.parse @host
      post = Net::HTTP::Post.new(url.path)
      post.body = request.xml.encode("ISO-8859-1")
      post.content_type = 'text/xml charset=ISO-8859-1'
      Net::HTTP.start(url.host, url.port) {|http| http.request(post)}
    end
  end
end
