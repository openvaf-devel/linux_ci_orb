extern "C" {
    fn foo(val1: usize, val2: usize) -> usize;
}

pub fn save_foo(val1: usize, val2: usize) -> usize {
    unsafe { foo(val1, val2) }
}

#[cfg(test)]
mod tests {
    use crate::foo;

    #[test]
    fn it_works_1() {
        let result = unsafe { foo(2, 14) };
        assert_eq!(result, 28);
    }

    #[test]
    fn it_works_2() {
        let result = unsafe { foo(3, 14) };
        assert_eq!(result, 42);
    }
}
