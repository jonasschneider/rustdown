require 'rustdown/version'
require 'ffi'

module Rustdown
  module FFI
    @path = begin
      if s = Gem.loaded_specs["rustdown"]
        Dir[File.dirname(__FILE__)+"/../"+s.require_paths.first+"/librustdown*"].first
      else
        Dir[File.dirname(__FILE__)+"/librustdown*"].first
      end
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
