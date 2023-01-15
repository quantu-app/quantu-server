require 'simplecov'
require 'simplecov-lcov'

# fix lcov with monkey patch
if !SimpleCov.respond_to?(:branch_coverage?)
  module SimpleCov
      def self.branch_coverage?
          false
      end
  end
end


if ENV['COVERAGE'] == 'local'
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

else
  SimpleCov::Formatter::LcovFormatter.config do |c|
    c.report_with_single_file = true
    c.single_report_path = 'coverage/lcov.info'
  end

  SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
end

SimpleCov.start('rails') do
  add_filter  'commonlib'
  add_filter  'vendor/plugins'
  add_filter  '.bundle'
end