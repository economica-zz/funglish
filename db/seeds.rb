require "terms_of_service_001"
require "privacy_policy_001"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.connection.execute("TRUNCATE terms_of_services")
ActiveRecord::Base.connection.reset_pk_sequence!("terms_of_services")
TermsOfService.create(content: TermsOfService001::CONTENT, deleted: false)
ActiveRecord::Base.connection.execute("VACUUM ANALYZE terms_of_services")

ActiveRecord::Base.connection.execute("TRUNCATE privacy_policies")
ActiveRecord::Base.connection.reset_pk_sequence!("privacy_policies")
PrivacyPolicy.create(content: PrivacyPolicy001::CONTENT, deleted: false)
ActiveRecord::Base.connection.execute("VACUUM ANALYZE privacy_policies")
