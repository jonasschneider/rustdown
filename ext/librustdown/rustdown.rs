extern crate libc;
use std::ffi::{CString,CStr};
use libc::{c_void, size_t, c_char, uintptr_t};

use std::*;

// #[link(name = "ruby")]
// extern {
//   fn rb_define_module(source_length: *const c_char) -> uintptr_t;
//   fn rb_define_method(target: *const c_void, name: *const c_char, body: extern fn(*const c_void), b: u8) -> *const c_void;
// }

#[no_mangle]
pub fn librustdown_convert(input: *const libc::c_char, len: size_t) -> *const libc::c_char {
  println!("first: {:?}", unsafe{*input});
  let slice = unsafe { CStr::from_ptr(input)};
  println!("str: {:?}", slice);

  let ins = str::from_utf8(slice.to_bytes()).unwrap();

  let pre = "Hello from rust! Your string was: ".to_string();
  let outs = pre + ins;
  println!("lol! '{}', {}", ins, len);

  let s = CString::new(outs).unwrap();
  let p = s.as_ptr();
  mem::forget(s);
  mem::forget(ins);
  p
}

// #[no_mangle]
// pub fn Init_librustdown() {
//   println!("hi from rust");
//   let n = CString::new("Librustdown").unwrap().as_ptr();
//   unsafe {
//     //let modu = ruby::rb_define_module(n);
//     //rb_define_method(MyTest, CString::new("rustdown_hi").unwrap().as_ptr(), rustdown_hi, 0);
//   }
// }
