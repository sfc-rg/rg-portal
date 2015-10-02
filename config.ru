require ::File.expand_path('../config/environment', __FILE__)
require 'http_accept_language'

use HttpAcceptLanguage::Middleware
run Rails.application
