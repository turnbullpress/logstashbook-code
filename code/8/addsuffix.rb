# From The Logstash Book
# The original of this file can be found at: http://logstashbook.com/code/index.html
#
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::AddSuffix < LogStash::Filters::Base
  config_name "addsuffix"

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
    filter_matched(event)
  end
end
