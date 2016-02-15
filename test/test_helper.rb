require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'tilt/erb'

Capybara.app = RushHour::Server
Capybara.save_and_open_page_path = 'tmp/capybara'

DatabaseCleaner[:active_record].strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_client
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
