extern crate libc;
use std::ffi::{CString,CStr};
use libc::{c_void, size_t, c_char, uintptr_t};
extern crate markdown;

use std::*;

// #[link(name = "ruby")]
// extern {
//   fn rb_define_module(source_length: *const c_char) -> uintptr_t;
//   fn rb_define_method(target: *const c_void, name: *const c_char, body: extern fn(*const c_void), b: u8) -> *const c_void;
// }

#[no_mangle]
pub fn librustdown_convert(input: *const libc::c_char, len: size_t) -> *const libc::c_char {
  let slice = unsafe { CStr::from_ptr(input)};

  let ins = str::from_utf8(slice.to_bytes()).unwrap();

  let html : String = markdown::to_html(ins);

  let s = CString::new(html).unwrap();
  let p = s.as_ptr();
  mem::forget(s);
  p
}

#[no_mangle]
pub fn librustdown_free(ptr: *mut libc::c_char) {
 let s = unsafe { CString::from_raw(ptr) };
 // drop s
}
