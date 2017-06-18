# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( idea.css )
Rails.application.config.assets.precompile += %w( idea.js )
Rails.application.config.assets.precompile += %w( idea/* )
Rails.application.config.assets.precompile += %w( user.css )
Rails.application.config.assets.precompile += %w( user.js )
Rails.application.config.assets.precompile += %w( scripts.js )
Rails.application.config.assets.precompile += %w( notification.js )
Rails.application.config.assets.precompile += %w( events-home.js )
Rails.application.config.assets.precompile += %w( ratyrate.js )
Rails.application.config.assets.precompile += %w( jquery.raty.js )
Rails.application.config.assets.precompile += %w( admin.css )
Rails.application.config.assets.precompile += %w( admin.js )
