require_relative 'boot'
require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module V1
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/ops_scheduling)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Rails.application.config.before_configuration do
        env_file = File.join(Rails.root, 'config', 'local_env.yml')
        YAML.load(File.open(env_file)).each do |key, value|
             ENV[key.to_s] = value
        end if File.exists?(env_file)
    end

    # set time zone to US Pacific Time
    config.time_zone = 'America/Los_Angeles'
  end
end

