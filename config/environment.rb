# Load the Rails application.
require File.expand_path('../application', __FILE__)
# Initialize the Rails application.
RentMaster::Application.initialize!
require File.expand_path('../../lib/mysql2_adapter', __FILE__)
# require File.expand_path('../../lib/company/parameter_sanitizer', __FILE__)