require 'eldr'
require_relative '../lib/eldr/assets'
require 'slim'

class App < Eldr::App
  include Eldr::Assets
  set :views_dir,    File.join(__dir__, 'views')
  set :assets_path, File.join(__dir__, 'assets')

  get '/' do
    render 'index'
  end
end

run App
