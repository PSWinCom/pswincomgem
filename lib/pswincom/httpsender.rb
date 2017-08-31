require 'uri'
require 'net/http'

module PSWinCom
  class HttpSender
    API_HOST = 'http://xml.pswin.com/'

    def initialize
      @host = API.api_host || API_HOST
      PSWinCom.debug "Host", @host
    end

    def send request
      url = URI.parse @host
      post = Net::HTTP::Post.new(url.path)
      post.body = request.xml.encode('utf-8')
      post.content_type = 'application/xml charset=utf-8'
      Net::HTTP.start(url.host, url.port) {|http| http.request(post)}
    end
  end
end
