require 'rustdown/version'
require 'ffi'

module Rustdown
  # Module with native functions of libfoo.
  module FFI
    extend ::FFI::Library
    ffi_lib Dir[File.dirname(__FILE__)+"/librustdown*"].first
    attach_function :librustdown_convert, [:pointer, :size_t], :pointer
    attach_function :librustdown_free, [ :pointer ], :void
  end

  def self.to_html(markdown_str)
    p_in = ::FFI::MemoryPointer.from_string(markdown_str)
    p_out = Rustdown::FFI.librustdown_convert(p_in, p_in.size)
    out = p_out.read_string
    Rustdown::FFI.librustdown_free(p_out)
    out
  end
end
