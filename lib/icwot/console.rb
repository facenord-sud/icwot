class Console

  attr_reader :produces, :accept, :port, :host, :protocol, :log_path, :errors

  def initialize
    @produces = 'application/json'
    @accept = 'application/json'
    @port = 4567
    @host = ''
    @protocol = 'http://'
    @log_path = ''
    @errors = ''
  end

  def parse
    if ARGV.empty?
      @errors = 'you need to provide at least one argument! See icwot -h'
      return false
    end
    ARGV.each_with_index do |a, index|
      case a
        when '-h'
          puts 'Usage : icwot <host>
              -h print help
              -l the host is localhost
              -c the content-type value for the header application/json by default
              -a the accept value for the header  text/plain by default
              -p the port where to run the server
              -t the protocol to use http:// by default
              -o where to save the log. By default your-home-directory/log/icwot-{port}-msg.log
              host is where to register for the service.
              '
          exit 0
        when '-l'
          @host='localhost'
        when '-c'
          @produces = ARGV.delete_at index + 1
        when '-a'
          @accept = ARGV.delete_at index + 1
        when '-p'
          @port = ARGV.delete_at(index + 1).to_i
        when '-t'
          unless (temp = ARGV.delete_at(index + 1)).nil?
            @protocol = temp
          end
        when '-o'
          @log_path = ARGV.delete_at index + 1
        else
          @host += a
      end
    end
    validate
  end

  def url
    protocol+host
  end

  def header
    {accept: accept, content_type: produces}
  end

  private

  def validate
    if @host == ''
      @errors=('Host must be set !')
      return false
    end

    if @port == 0
      @errors = 'The port must be bigger than 0'
      return false
    end
    true
  end
end