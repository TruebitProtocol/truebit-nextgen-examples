fn fibonacci(n: u32) -> u64 {
    if n == 0 {
        return 0;
    } else if n == 1 {
        return 1;
    }
    
    let mut a = 0;
    let mut b = 1;
    let mut c = 0;

    for _i in 2..=n {
        c = a + b;
        a = b;
        b = c;
    }

    return c;
}

fn run_task(input: String) -> String {
    fibonacci(input.parse().unwrap()).to_string()
}

fn main() {
    let input: String =
        std::fs::read_to_string("input.txt").expect("Could not read from input.txt");
    let output: String = run_task(input);
    std::fs::write("output.txt", output).expect("Could not write to output.txt");
}
