# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Funglish::Application.initialize!

ActiveMerchant::Billing::PaypalExpressGateway.default_currency = "JPY"
