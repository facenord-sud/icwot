require 'socket'
require 'json'

class Client
  attr_accessor :uri, :content_type, :port

  def initialize(options = {})
    @content_type = options[:content_type] || 'application/json'
    @uri = options[:uri]
    @port = options[:port] || '4567'
  end

  def uri
    @uri.nil? ? "http://#{get_ip}:#{port}" : @uri
  end

  def to_s
    case content_type
      when 'application/json'
        to_hash.to_json
      when 'application/xml'
        to_xml
    end
  end

  protected

  def to_xml
    "<client xmlns=\"http://jaxb.xwot.first.ch.unifr.diuf\"><uri>#{uri}</uri></client>"
  end

  def to_hash
    {uri: uri}
  end

  # inspired by http://stackoverflow.com/questions/11897269/get-own-ip-address
  def get_ip
    ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
    ip ? ip.ip_address : '127.0.0.1'
  end
end