require 'minitest_helper'

class TestRustdown < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rustdown::VERSION
  end

  def test_it_parses_simple_markdown
    assert_equal "<p>lol <strong>emph></strong></p>", Rustdown.to_html("lol **strong**")
  end
end
