require File.join(File.dirname(__FILE__), 'pswincom/api')

module PSWinCom 
  def self.debug label, value
    puts "#{label}: #{value}" if PSWinCom::API.debug_mode
  end
end
