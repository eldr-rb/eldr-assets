require_relative 'assets/helpers'

module Eldr
  module Assets
    def self.included(klass)
      klass.include Helpers
      unless klass.instance_methods().include?(:tag)
        klass.include Eldr::Rendering
      end
    end
  end
end
