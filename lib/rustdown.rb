require 'rustdown/version'
require 'ffi'

module Rustdown
  module FFI
    @path = begin
      Dir[File.dirname(__FILE__)+"/../"+Gem.loaded_specs["rustdown"].require_paths.first+"/librustdown*"].first
    end
    unless @path
      $stderr.puts "Could not find librustdown. Looked at:"
      $stderr.puts File.dirname(__FILE__)+"/../"+Gem.loaded_specs["rustdown"].require_paths.first+"/librustdown*"
      raise "Failed to load librustdown"
    end
    extend ::FFI::Library
    ffi_lib @path
    attach_function :librustdown_convert, [:pointer], :pointer
    attach_function :librustdown_free, [:pointer], :void
  end

  def self.to_html(markdown_str)
    p_in = ::FFI::MemoryPointer.from_string(markdown_str)
    p_out = Rustdown::FFI.librustdown_convert(p_in)
    out = p_out.read_string
    Rustdown::FFI.librustdown_free(p_out)
    out
  end
end
