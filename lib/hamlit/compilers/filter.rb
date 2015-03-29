require 'hamlit/concerns/included'
require 'hamlit/concerns/registerable'
require 'hamlit/filters/css'
require 'hamlit/filters/escaped'
require 'hamlit/filters/javascript'
require 'hamlit/filters/plain'
require 'hamlit/filters/preserve'
require 'hamlit/filters/ruby'

module Hamlit
  module Compilers
    module Filter
      extend Concerns::Included

      included do
        extend Concerns::Registerable

        define_options :format

        register :css,        Filters::Css
        register :escaped,    Filters::Escaped
        register :javascript, Filters::Javascript
        register :plain,      Filters::Plain
        register :preserve,   Filters::Preserve
        register :ruby,       Filters::Ruby
      end

      def on_haml_filter(name, lines)
        ast = compile_filter(name, lines)
        compile(ast)
      end

      private

      def compile_filter(name, exp)
        self.class.find(name).new(options).compile(exp)
      end
    end
  end
end