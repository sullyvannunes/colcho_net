require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Colchonet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # config.assets.paths << Rails.root.join("vendor", "assets", "fonts")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end



#config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
I18n.config.available_locales = [:en, :'pt-BR']
I18n.config.default_locale = :'pt-BR'

# Configure the default encoding used in templates for Ruby 1.9.
#config.encoding = "utf-8"
