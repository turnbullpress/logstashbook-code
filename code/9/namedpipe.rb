# From The Logstash Book
# The original of this file can be found at: http://logstashbook.com/code/index.html
#
require 'logstash/namespace'
require 'logstash/inputs/base'

class LogStash::Inputs::NamedPipe < LogStash::Inputs::Base
    config_name "namedpipe"
    default :codec, "plain"

    # The pipe to read from
    config :pipe, :validate => :string, :required => true

    public
    def register
      @logger.info("Registering namedpipe input", :pipe => @pipe)
    end

    public
    def run(queue)
      @pipe = open(pipe, "r+")
      @pipe.each do |line|
        line = line.chomp
        host = Socket.gethostname
        path = pipe
        @logger.debug("Received line", :pipe => pipe, :line => line)
        @codec.decode(line) do |event|
          decorate(event)
          event["host"] = host
          event["path"] = path
          queue << event
        end
      end
    end

    def teardown
      @pipe.close
      finished
    end
end
