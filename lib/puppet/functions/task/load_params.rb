require 'puppet'
require 'json'
require 'timeout'

Puppet::Functions.create_function(:'task::load_params') do

  # Load a JSON params object for running a task
  dispatch :load_stdin do
    #This doesn't accept params
  end

  def load_stdin
    begin
      Timeout::timeout(3) do
        JSON.parse(STDIN.read)
      end
    rescue Timeout::Error
      throw Puppet::ParseError "Couldn't read from stdin"
    rescue JSON::ParseError
      throw Puppet::ParseError "Couldn't parse JSON from stdin"
    end
  end
end
