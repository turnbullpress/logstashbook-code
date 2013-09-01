# From The LogStash Book
# The original of this file can be found at: http://logstashbook.com/code/index.html
#
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::AddSuffix < LogStash::Filters::Base
  config_name "addsuffix"
  milestone 1

  # The suffix to be added to the message.
  config :suffix, :validate => :string

  # Nothing to register.
  public
  def register
  end

  public
  def filter(event)
    if @suffix
      msg = event["message"] + " " + @suffix
      event["message"] = msg
    end
  end
end
