require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ideaburn
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time U(S & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.autoload_paths += %W(#{config.root}/lib)
    config.active_record.raise_in_transactional_callbacks = true
    config.active_record.default_timezone = :local
    #config.filter_parameters += [:card_number, :card_verification]
    I18n.available_locales = [:af, :en, :es, :vi, :'en-AU', :'en-CA', :'en-GB', :'en-IE', :'en-IN', :'en-NZ', :'en-US', :'en-ZA', :'es-CO', :'es-ES', :fi, :'fr-CA', :'fr-FR', :it, :nl, :ro, :'pt-BR', :pt, :ko, :ja, :'zh-CN', :'zh-HK', :'zh-TW', :'zh-YUE', :ms, :th, :tr, :uk]
    config.time_zone = 'UTC'
    config.i18n.default_locale = :en
  end
end
