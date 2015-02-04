# -*- coding: utf-8 -*-

require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'gruyere' }

require 'chef/application'

RSpec.configure do |config|
  config.log_level = :error
end
