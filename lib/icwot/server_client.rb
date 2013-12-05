require 'sinatra/base'

class ServerClient < Sinatra::Base

  # Si le fichier log/msg.log n'existe pas, on le créé, sinon on l'ouvre
  def self.create_or_open_log
    file_name = "icwot-#{settings.port}-msg.log"
    directory_path = "#{Dir.home}/log/"
    Dir.mkdir(directory_path) unless File.exists?(directory_path)
    file = (settings.log_path.nil? || !File.exist?(settings.log_path) ? File.new(directory_path+file_name, 'a+') : File.new(settings.log_path))
    file.sync = true
    file
  end

  configure do
    set :log_path, nil

    set :environment, :production

    enable :logging
    # We put the log level to info
    set :logger_level, :info
    # The logger is at the location log/msg.log
    set :logger_log_file, lambda { create_or_open_log }
  end

  # POST sur / avec le port par défaut 4567
  post '/' do
    content_type 'text/plain'
    # On enregistre dans un log spécial le body de la requête
    msg.info request.body.read
    logger.info "message saved to #{self.class.logger_log_file.path}"
    # On retourne le code http 200 avec le texte 'ok'
    'ok'
  end

  helpers do
    # logger personalisé pour enregistrer les réponses du body
    def msg
      @logger ||= begin
        @logger = ::Logger.new(self.class.logger_log_file)
        @logger.level = ::Logger.const_get((self.class.logger_level || :warn).to_s.upcase)
        @logger.datetime_format = "%Y-%m-%d %H:%M:%S"
        @logger.formatter = proc do |serverity, time, progname, msg|
          # le format est de la sorte:
          #
          # 2013-12-12 00:00:00
          # "message body"

          "#{time} :\n\"#{msg}\"\n\n"
        end
        @logger
      end
    end
  end
end