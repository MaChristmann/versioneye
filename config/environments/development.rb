Versioneye::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.action_controller.perform_caching = false
  config.cache_store = :dalli_store, Settings.memcache_servers,{
    :username => Settings.memcache_username, :password => Settings.memcache_password,
    :namespace => 'veye', :expires_in => 1.day, :compress => true }

  config.serve_static_assets = true
  config.action_dispatch.x_sendfile_header = nil

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true



  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.log_level = :debug

  # config.action_mailer.delivery_method       = :postmark # :sendmail
  # config.action_mailer.postmark_settings = { :api_key => Settings.postmark_api_key }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
     :address              => 'email-smtp.eu-west-1.amazonaws.com',
     :port                 => 587,
     :user_name            => Settings.smtp_username,
     :password             => Settings.smtp_password,
     :enable_starttls_auto => true  }
  config.action_mailer.perform_deliveries    = false
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options   = { :host => 'localhost' }

  ENV['API_BASE_PATH'] = "http://localhost:3000/api"

  Stripe.api_key = Settings.stripe_secret_key

  routes.default_url_options = { host: "localhost", port: 3000 }

end
