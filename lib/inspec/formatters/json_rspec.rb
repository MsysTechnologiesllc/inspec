module Inspec
  module Formatters
    class RspecJson < RSpec::Core::Formatters::JsonFormatter
      RSpec::Core::Formatters.register self

      private
      
      # We are cheating and overriding a private method in RSpec's core JsonFormatter.
      # This is to avoid having to repeat this id functionality in both dump_summary
      # and dump_profile (both of which call format_example).
      # See https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/formatters/json_formatter.rb
      #
      # rspec's example id here corresponds to an inspec test's control name -
      # either explicitly specified or auto-generated by rspec itself.
      def format_example(example)
        res = super(example)
        res[:id] = example.metadata[:id]
        res
      end
    end
  end
end