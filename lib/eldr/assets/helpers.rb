require 'eldr'
require 'eldr/rendering'
require 'active_support/core_ext/hash'

module Eldr
  module Assets
    module Helpers
      APPEND_ASSET_EXTENSIONS = %w(js css)
      ABSOLUTE_URL_PATTERN    = %r{^(https?://)}

      def css(*sources)
        options = {
          rel: 'stylesheet',
          type: 'text/css'
        }.update(sources.extract_options!.symbolize_keys)
        sources.flatten.inject(ActiveSupport::SafeBuffer.new) do |all,source|
          all << tag(:link, { href: asset_path(:css, source) }.update(options))
        end
      end

      def js(*sources)
        options = {
          type: 'text/javascript'
        }.update(sources.extract_options!.symbolize_keys)
        sources.flatten.inject(ActiveSupport::SafeBuffer.new) do |all,source|
          all << content_tag(:script, nil, { src: asset_path(:js, source) }.update(options))
        end
      end

      def asset_path(kind, source = nil)
        kind, source = source, kind if source.nil?
        source = asset_normalize_extension(kind, URI.escape(source.to_s))

        return source if source =~ ABSOLUTE_URL_PATTERN || source =~ /^\//

        source      = File.join(asset_folder_name(kind).to_s, source)
        timestamp   = asset_timestamp(source)
        result_path = uri_root_path(source)

        "#{result_path}#{timestamp}"
      end

      def assets_uri_path
        assets_uri_path  = self.configuration.assets_uri_path
        assets_uri_path ||= 'assets/'
      end

      def uri_root_path(*paths)
        root_uri   = self.configuration.uri_root
        root_uri ||= ENV['ROOT_URI']
        File.join(ENV['RACK_BASE_URI'].to_s, root_uri || '/', assets_uri_path, *paths)
      end

      private

      def asset_timestamp(file_path)
        return nil if file_path =~ /\?/ || (self.configuration.asset_stamp == false)

        assets_path   = self.configuration.assets_path
        assets_path ||= ENV['ASSETS_PATH']
        assets_path ||= "#{ENV['APP_ROOT']}/assets" if ENV['APP_ROOT']
        assets_path ||= "#{self.configuration.app_root}/assets"

        asset_file_path = File.join(assets_path, file_path) if assets_path

        stamp   = File.mtime(asset_file_path).to_i if asset_file_path && File.exist?(asset_file_path)
        stamp ||= Time.now.to_i

        "?#{stamp}"
      end

      def asset_folder_name(kind)
        asset_folder   = self.configuration.send("#{kind}_assets_folder")
        asset_folder ||= kind
      end

      def asset_normalize_extension(kind, source)
        ignore_extension = !APPEND_ASSET_EXTENSIONS.include?(kind.to_s)
        source << ".#{kind}" unless ignore_extension || source =~ /\.#{kind}/ || source =~ ABSOLUTE_URL_PATTERN
        source
      end
    end
  end
end
