require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

# require 'digest/sha1'
# require 'openid'
# require 'openid/consumer/discovery'
require 'openid/extensions/sreg'
require 'openid/extensions/pape'
require 'openid/extensions/ax'
require 'lib/openid_server_system'
require 'lib/authenticated_system'
# require 'lib/yubico'
# require 'lib/hash'
# require 'yaml'

module Masquerade
  class Application < Rails::Application
    
    Masquerade::Application::Config = YAML.load(File.read("#{Rails.root}/config/app_config.yml"))[Rails.env]
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running
    config.active_record.observers = :account_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = Masquerade::Application::Config['time_zone'] || 'UTC'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = Masquerade::Application::Config['locale'] || :en

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters << [:password, :token]

    # Mailer
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address => Masquerade::Application::Config['mailer']['address'],
      :domain => Masquerade::Application::Config['mailer']['domain'],
      :port => Masquerade::Application::Config['mailer']['port'],
      :user_name => Masquerade::Application::Config['mailer']['user_name'],
      :password => Masquerade::Application::Config['mailer']['password'],
      :authentication => Masquerade::Application::Config['mailer']['authentication'] }

  end
end

