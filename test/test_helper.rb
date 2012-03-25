# -*- encoding : utf-8 -*-

# Load test coverage tool (must be loaded before any code)
#require 'simplecov'
#SimpleCov.start do
#  add_filter '/test/'
#  add_filter '/config/'
#end

# Load and initialize the application to be tested
require 'library_setup'

require 'active_support/test_case'

# Load test frameworks
require 'minitest/autorun'
