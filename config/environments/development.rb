Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  #config.action_mailer.default_url_options = { :host => 'sai7anils-ib2016.herokuapp.com' }
  config.action_mailer.default_url_options = { :host => 'localhost' }

  config.action_mailer.perform_deliveries = true # Set it to false to disable the email in dev mode
  config.action_mailer.raise_delivery_errors = true


  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'example.com',
    user_name:            'ideaburns2017@gmail.com',
    password:             '9985776863',
    authentication:       'plain',
    enable_starttls_auto: true  }

  Rails.application.configure do
    config.gem "activemerchant", :lib => "active_merchant", :version => "1.4.1"
  end

  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
      login: "khoai.nx1-facilitator_api1.gmail.com",
      password: "VJJ46NZTF4XG3UQS",
      signature: "AiPC9BjkCyDFQXbSkoZcgqH3hpacAeKfLoUauZOpVeOw458xKcZ2MozR"
    )
  end

  Bullet.enable = true
  # Bullet.alert = true
  Bullet.bullet_logger = true
  Bullet.console = true
  Bullet.rails_logger = true
end



