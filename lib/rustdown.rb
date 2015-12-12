require 'rustdown/version'
require 'ffi'

module Rustdown
  module FFI
    @path = begin
      d = $:.detect { |d| Dir["#{d}/librustdown*"].any? }
      if d then Dir["#{d}/librustdown*"].first else nil end
    end
    unless @path
      raise "Could not find the librustdown binary! Your installation is incomplete ..?"
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
