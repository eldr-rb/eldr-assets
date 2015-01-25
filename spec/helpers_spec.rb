describe Eldr::Assets::Helpers do
  attr_accessor :configuration

  def configuration
    @configuration ||= Eldr::Configuration.new
  end

  def config
    configuration
  end

  describe '#css' do
    it 'displays a stylesheet link item' do
      time = stop_time_for_test
      html = css('style')
      expected_options = { :rel => "stylesheet", :type => "text/css" }
      expect(html).to have_tag('link', {:with => expected_options.merge(:href => "/css/style.css?#{time.to_i}")})
      expect(html.html_safe?).to eq(true)
    end

    it 'displays a stylesheet link item for long relative path' do
      time = stop_time_for_test
      expected_options = { :rel => "stylesheet", :type => "text/css" }
      html = css('example/demo/style')
      expect(html).to have_tag('link', {:with => expected_options.merge(:href => "/css/example/demo/style.css?#{time.to_i}")})
    end

    it 'displays a stylesheet link item with absolute path' do
      time = stop_time_for_test
      expected_options = { :rel => "stylesheet", :type => "text/css" }
      html = css('/css/style')
      expect(html).to have_tag('link', {:with => expected_options.merge(:href => "/css/style.css")})
    end

    it 'displays a stylesheet link item with uri root' do
      configuration.uri_root = "/blog"

      time = stop_time_for_test
      expected_options = { :rel => "stylesheet", :type => "text/css" }
      html = css('style')
      expect(html).to have_tag('link', {:with => expected_options.merge(:href => "/blog/css/style.css?#{time.to_i}")})
      config.uri_root = nil
    end

    it 'displays a stylesheet link items' do
      time = stop_time_for_test
      html = css('style', 'layout.css', 'http://google.com/style.css')
      expect(html).to have_tag('link', :with => {:rel => "stylesheet", :type => "text/css"}, :count => 3)
      expect(html).to have_tag('link', :with => {:href => "/css/style.css?#{time.to_i}"})
      expect(html).to have_tag('link', :with => {:href => "/css/layout.css?#{time.to_i}"})
      expect(html).to have_tag('link', :with => {:href => "http://google.com/style.css"})
      expect(html).to eq css(['style', 'layout.css', 'http://google.com/style.css'])
    end

    it 'does not use a timestamp if stamp setting is false' do
      configuration.asset_stamp = false
      expected_options = { :rel => "stylesheet", :type => "text/css" }
      html = css('style')
      expect(html).to have_tag('link', :with => expected_options.merge(:href => "/css/style.css"))
      configuration.asset_stamp = nil
    end

    it 'displays a stylesheet link used custom options' do
      html = css('style', :media => 'screen')
      expect(html).to have_tag('link', :with => {:rel => 'stylesheet', :media => 'screen'})
    end
  end

  describe '#js' do
    it 'displays a javascript item' do
      time = stop_time_for_test
      html = js('application')
      expect(html).to have_tag('script', :with => {:src => "/js/application.js?#{time.to_i}", :type => "text/javascript"})
      expect(html.html_safe?).to eq true
    end

    it 'responds to js_asset_folder setting' do
      time = stop_time_for_test
      configuration.js_asset_folder = 'js'
      expect('js').to eq asset_folder_name(:js).to_s
      html = js('application')
      expect(html).to have_tag('script', :with => {:src => "/js/application.js?#{time.to_i}", :type => "text/javascript"})
      configuration.js_asset_folder = nil
    end

    it 'displays a javascript item for long relative path' do
      time = stop_time_for_test
      html = js('example/demo/application')
      expect(html).to have_tag('script', :with => {:src => "/js/example/demo/application.js?#{time.to_i}", :type => "text/javascript"})
    end

    it 'displays a javascript item for path containing js' do
      time = stop_time_for_test
      html = js 'test/jquery.json'
      expect(html).to have_tag('script', :with => {:src => "/js/test/jquery.json?#{time.to_i}", :type => "text/javascript"})
    end

    it 'displays a javascript item for path containing period' do
      time = stop_time_for_test
      html = js 'test/jquery.min'
      expect(html).to have_tag('script', :with => {:src => "/js/test/jquery.min.js?#{time.to_i}", :type => "text/javascript"})
    end

    it 'displays a javascript item with absolute path' do
      time = stop_time_for_test
      html = js('/js/application')
      expect(html).to have_tag('script', :with => {:src => "/js/application.js", :type => "text/javascript"})
    end

    it 'displays a javascript item with uri root' do
      configuration.uri_root = "/blog"
      time = stop_time_for_test
      html = js('application')
      expect(html).to have_tag('script', :with => {:src => "/blog/js/application.js?#{time.to_i}", :type => "text/javascript"})
      configuration.uri_root = nil
    end

    it 'does not append extension to absolute paths' do
      time = stop_time_for_test
      html = js('https://maps.googleapis.com/maps/api/js?key=value&sensor=false')
      expect(html).to have_tag('script', :with => {:src => "https://maps.googleapis.com/maps/api/js?key=value&sensor=false"})
    end

    it 'displays a javascript items' do
      time = stop_time_for_test
      html = js('application', 'base.js', 'http://google.com/lib.js')
      expect(html).to have_tag('script', :with => {:type => "text/javascript"}, :count => 3)
      expect(html).to have_tag('script', :with => {:src => "/js/application.js?#{time.to_i}"})
      expect(html).to have_tag('script', :with => {:src => "/js/base.js?#{time.to_i}"})
      expect(html).to have_tag('script', :with => {:src => "http://google.com/lib.js"})
      expect(html).to eq js(['application', 'base.js', 'http://google.com/lib.js'])
    end

    it 'does not use a timestamp if stamp setting is false' do
      configuration.asset_stamp = false
      html = js('application')
      expect(html).to have_tag('script', :with => {:src => "/js/application.js", :type => "text/javascript"})
      configuration.asset_stamp = nil
    end
  end
end
