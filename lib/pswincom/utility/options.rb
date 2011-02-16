require 'optparse'
require 'ostruct'
require 'yaml'

module PSWinCom
  module Utility
    class Options
      class << self
        
        def parse(args)          
          @options = self.default_options
          parser = OptionParser.new do |opts|
            opts.banner = "Usage: sms [options] recipient(s) message"
            opts.separator "  Recipients can be a comma-separated list, up to 100 max."
            opts.separator ""
            opts.separator "Specific options:"
          
            opts.on('-u', '--username USERNAME',
              "Specify the pswincom username (overrides ~/.pswincom setting)") do |username|
               @options.username = username 
            end
          
            opts.on('-p', '--password PASSWORD',
              "Specify the pswincom password (overrides ~/.pswincom setting)") do |password|
               @options.password = password
            end
                      
            opts.on('-f', '--from NAME_OR_NUMBER',
              "Specify the name or number that the SMS will appear from") do |from|
               @options.from = from 
            end
            
            opts.on('-s', '--host URL',
              "Specify the gateway endpoint to use") do |host|
              @options.host = host
            end

            opts.on('-d', '--debug') do
               PSWinCom::API.debug_mode = true
            end

            opts.on('-t', '--test') do
               PSWinCom::API.test_mode = true
            end
          
            opts.on_tail('-h', '--help', "Show this message") do
              puts opts
              exit
            end          
          end
          
          #@options.recipient = args[-2].split(',').map { |r| r.gsub(/^\+/, '') } rescue nil
          @options.recipient = args[-2]
          @options.message   = args[-1]
          
          parser.parse!(args)
        
          if (@options.message.nil? || @options.recipient.nil?)
            puts "You must specify a recipient and message!"
            puts parser
            exit
          end

          return @options
        
        rescue OptionParser::MissingArgument => e
          switch_given = e.message.split(':').last.strip
          puts "The #{switch_given} option requires an argument."
          puts parser
          exit
        end
      
        def default_options
          options = OpenStruct.new          
          config = load_defaults
          options.username = config['username']
          options.password = config['password']
          options.from     = config['from']
          options.host     = config['host']
          return options
        rescue Errno::ENOENT
          return options
        end

        def load_defaults
          config_file = File.open(File.join(ENV['HOME'], '.pswincom'))
          YAML.load(config_file)
        end
        
      end
    end
  end
end

