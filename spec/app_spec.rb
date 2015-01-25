describe 'ExampleApp' do
  let(:app) do
    path = File.expand_path('../examples/app.ru', File.dirname(__FILE__))
    Rack::Builder.parse_file(path).first
  end

  let(:rt) do
    Rack::Test::Session.new(app)
  end

  describe 'GET /' do
    it 'returns a page with a linked css file' do
      time = stop_time_for_test
      expected_options = { :rel => "stylesheet", :type => "text/css" }
      response = rt.get '/'
      html = response.body
      expect(html).to have_tag('link', {:with => expected_options.merge(:href => "/css/app.css?#{time.to_i}")})
    end

    it 'returns a page with a linked js file' do
      time = stop_time_for_test
      response = rt.get '/'
      html = response.body
      expect(html).to have_tag('script', :with => {:src => "/js/app.js?#{time.to_i}", :type => "text/javascript"})
    end
  end
end
