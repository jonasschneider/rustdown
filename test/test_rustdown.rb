require 'minitest_helper'
require 'kramdown'
require 'benchmark'

class TestRustdown < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rustdown::VERSION
  end

  def test_it_parses_simple_markdown
    assert_equal "<p>lol <strong>important</strong></p>\n", Rustdown.to_html("lol **important**")
  end

  def test_it_works_like_kramdown
    text = File.read(File.dirname(__FILE__) + "/fixture_mdbasics.md")

    n = 1000
    Benchmark.bm do |x|
      x.report "Rustdown" do
        n.times do   ; Rustdown.to_html(text); end
      end
      x.report "Kramdown" do
        n.times do   ; Kramdown::Document.new(text).to_html; end
      end
    end
  end
end
