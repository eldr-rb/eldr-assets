require 'rack/test'
require 'rack'
require 'rspec-html-matchers'

if ENV['COVERALLS_REPO_TOKEN']
  require 'coveralls'
  Coveralls.wear!
end

require_relative '../lib/eldr-assets'

RSpec.configure do |config|
  config.include Eldr::Assets

  def stop_time_for_test
    time = Time.now
    allow(Time).to receive(:now).and_return time
    return time
  end
end
