fn run_task(input: String) -> String {
    input.chars().rev().collect()
}

fn main() {
    let input: String =
        std::fs::read_to_string("input.txt").expect("Could not read from input.txt");
    let output = run_task(input);
    std::fs::write("output.txt", output).expect("Could not write to output.txt");
}
