Funglish::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # Use a different cache store in production
  config.cache_store = :dalli_store

  ENV['FB_APP_ID'] = "413917385346588"
  ENV['FB_APP_SECRET'] = "13fa2c4adeab3b12e6acaf83dc15d7c6"
  ENV['MEMCACHE_PASSWORD'] = "nN3acLyO2SwJqcz0"
  ENV['MEMCACHE_SERVERS'] = "mc7.ec2.northscale.net"
  ENV['MEMCACHE_USERNAME'] = "app9444032%40heroku.com"
  ENV['CLOUDINARY_BASE_URL'] = "http://res.cloudinary.com/htnuxuh4u"
  ENV['CLOUDINARY_URL'] = "cloudinary://194668585679986:y7pkf-TNPN1HbVBuYODUYG05i7w@htnuxuh4u"
  ENV['PANDASTREAM_URL'] = "https://2d06316e0e28aa11fb30:3156eb1604d5bdaacba2@api.pandastream.com/549352bfe3c56eb2ec806fe6452690ce"
  ENV['PAYPAL_API_USERNAME'] = "seller_1354597746_biz_api1.gmail.com"
  ENV['PAYPAL_API_PASSWORD'] = "1354597761"
  ENV['PAYPAL_SIGNATURE'] = "A7OwH5efxpOw0LHurI9Gry1ESjXZAgRrORcR6ujjAeT.QyQ3oIww-F9s"
  ENV['PAYPAL_TEST_MODE'] = "true"
  ENV['SENDGRID_USERNAME'] = "app9444032@heroku.com"
  ENV['SENDGRID_PASSWORD'] = "yisxqtzt"

  config.after_initialize do
    if ENV['PAYPAL_TEST_MODE'] == "true"
      ActiveMerchant::Billing::Base.mode = :test
    end
  end
end
