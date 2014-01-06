require "icwot/version"
require 'icwot/server_client'
require 'socket'
require 'timeout'

module Icwot
  def self.run(port, log_path)
    app = ServerClient.new
    app.settings.port = port
    app.settings.log_path = log_path
    app.settings.run!
    app
  end

  # determine if a port is used or not
  # from http://stackoverflow.com/questions/517219/ruby-see-if-a-port-is-open
  def self.is_port_open?(ip, port)
    begin
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new(ip, port)
          s.close
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          return false
        end
      end
    rescue Timeout::Error
    end
    return false
  end
end


