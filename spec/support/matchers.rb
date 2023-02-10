# frozen_string_literal: true

RSpec::Matchers.define :eq_with_indifferent_access do |expected|
  match do |actual|
    actual.with_indifferent_access == expected.with_indifferent_access
  end

  failure_message do |actual|
    <<-FAIL_MSG
    expected: #{expected}
         got: #{actual}
    FAIL_MSG
  end

  failure_message_when_negated do |actual|
    <<-FAIL_MSG
    expected: value != #{expected}
         got:          #{actual}
    FAIL_MSG
  end
end
