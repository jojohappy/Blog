class MichaelDaiSite < Sinatra::Application
    register SinatraMore::MarkupPlugin
    # initialize log
    require 'logger'
    Dir.mkdir('log') unless File.exist?('log')
    class ::Logger; alias_method :write, :<<; end
    case ENV['RACK_ENV']
    when "production"
        logger = ::Logger.new("log/production.log")
        logger.level = ::Logger::WARN
    when "development"
        logger = ::Logger.new("log/development.log")
        logger.level = ::Logger::DEBUG
    else
        logger = ::Logger.new("/dev/null")
    end

    # configure
    configure do
        set :default_encoding, 'utf-8'
        set :logging, true
        set :views, "#{File.dirname(__FILE__)}/views"
        set :static, true
        set :partial_template_engine, :erb
        use Rack::CommonLogger, logger
        set :show_exceptions, true
    end

    configure :production do
    end

    # initialize ActiveRecord
    ActiveRecord::Base.configurations = YAML::load(File.open('./config/database.yml'))
    ActiveRecord::Base.establish_connection YAML::load(File.open('./config/database.yml'))[ENV['RACK_ENV']]

    ActiveSupport.on_load(:active_record) do
        self.include_root_in_json = false
        self.default_timezone = :local
        self.time_zone_aware_attributes = false
        self.logger = logger
    end

    ActsAsTaggableOn.remove_unused_tags = true
    ActsAsTaggableOn.strict_case_match = true

    # load project config
    APP_CONFIG = YAML.load_file(File.expand_path("../config", __FILE__) + '/app_config.yml')[ENV['RACK_ENV']]

    # autoload directory
    %w{models apps helpers libs}.each do |dir|
      Dir.glob(File.expand_path("../#{dir}", __FILE__) + '/**/*.rb').each do |file|
        require file
      end
    end
end
