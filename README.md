# Eldr::Assets [![Build Status](https://travis-ci.org/eldr-rb/eldr-assets.svg)](https://travis-ci.org/eldr-rb/eldr-assets) [![Code Climate](https://codeclimate.com/github/eldr-rb/eldr-assets/badges/gpa.svg)](https://codeclimate.com/github/eldr-rb/eldr-assets) [![Coverage Status](https://coveralls.io/repos/eldr-rb/eldr-assets/badge.svg?branch=master)](https://coveralls.io/r/eldr-rb/eldr-assets?branch=master) [![Dependency Status](https://gemnasium.com/eldr-rb/eldr-assets.svg)](https://gemnasium.com/eldr-rb/eldr-assets) [![Inline docs](https://inch-ci.org/github/eldr-rb/eldr-assets.svg?branch=master)](http://inch-ci.org/github/eldr-rb/eldr-assets) [![Gratipay](https://img.shields.io/gratipay/k2052.svg)](https://www.gratipay.com/k2052)

Asset tag helpers for [Eldr](https://github.com/eldr-rb/eldr) and Rack Apps

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eldr-assets'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eldr-assets

## Usage

Include it, call `render()`, and then call the helpers in your template:

App:

```ruby
class App < Eldr::App
  include Eldr::Assets
  set :view_dir,    File.join(__dir__, 'views')
  set :assets_path, File.join(__dir__, 'assets')

  get '/' do
    render 'index'
  end
end
```

Then in your view do:

```ruby
html
  head
    == js 'app'
    == css3 'app'
```

See [examples/app.ru](https://github.com/eldr-rb/eldr-assets/tree/master/examples/app.ru) for an example app.

## Contributing

1. Fork. it
2. Create. your feature branch (git checkout -b cat-evolver)
3. Commit. your changes (git commit -am 'Add Cat Evolution')
4. Test. your changes (always be testing)
5. Push. to the branch (git push origin cat-evolver)
6. Pull. Request. (for extra points include funny gif and or pun in comments)

To remember this you can use the easy to remember and totally not tongue-in-check initialism: FCCTPP.

I don't want any of these steps to scare you off. If you don't know how to do something or are struggle getting it to work feel free to create a pull request or issue anyway. I'll be happy to help you get your contributions up to code and into the repo!

## License

Licensed under MIT by K-2052.
