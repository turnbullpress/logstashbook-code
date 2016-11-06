# From The Logstash Book
# The original of this file can be found at: http://logstashbook.com/code/index.html
#
require "logstash/outputs/base"
require "logstash/namespace"

class LogStash::Outputs::CowSay < LogStash::Outputs::Base
  config_name "cowsay"

  # The location of the CowSay log file.
  config :cowsay_log, :validate => :string, :default => "/var/log/cowsay.log"

  public
  def register
  end

  public
  def receive(event)
    msg = `cowsay #{event["message"]}`
    File.open(@cowsay_log, 'a+') { |file| file.write("#{msg}") }
  end
end
