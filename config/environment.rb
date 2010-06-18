# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
# RAILS_GEM_VERSION = '2.1.1' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

SITE_CONFIG = YAML.load_file(File.join(RAILS_ROOT, 'config', 'site.yml'))

Rails::Initializer.run do |config|
  config.time_zone = 'Pacific Time (US & Canada)'
  config.action_controller.session = {
    :session_key => '_litterary_session_id',
    :secret      =>  SITE_CONFIG['secret-salt'] * (30.0 /  SITE_CONFIG['secret-salt'].length).ceil
  }
end

Haml::Template.options[:format] = :html5 