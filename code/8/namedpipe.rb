require 'logstash/namespace'
require 'logstash/inputs/base'

class LogStash::Inputs::NamedPipe < LogStash::Inputs::Base
    config_name "namedpipe"
    plugin_status "experimental"

    # The pipe to read from
    config :pipe, :validate => :string, :required => true

    public
    def register
      @logger.info("Registering namedpipe input", :pipe => @pipe)
    end

    public
    def run(queue)
      @pipe = open(pipe, "r+")
      hostname = Socket.gethostname

      @pipe.each do |line|
        line = line.chomp
        source = "namedpipe://#{hostname}/#{pipe}"
        @logger.debug("Received line", :pipe => pipe, :line => line)
        e = to_event(line, source)
        if e
          queue << e
        end
      end
    end

    public
    def teardown
      @pipe.close
      finished
    end
end
