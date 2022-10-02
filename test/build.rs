fn main() {
    if std::env::var_os("RUST_CHECK").is_none() {
        cc::Build::new().file("foo.c").compile("foo");
    }
}
