use std::process;

fn fibonacci(n: u32) -> u64 {
  if n == 0 {
    return 0;
  } else if n == 1 {
    return 1;
  }

  let mut a = 0;
  let mut b = 1;
  let mut c = 0;

  for _ in 2..=n {
    c = a + b;
    a = b;
    b = c;
  }
  c
}

fn main() {
  // 1) Read input.txt
  let input = match std::fs::read_to_string("input.txt") {
    Ok(content) => content,
    Err(e) => {
      eprint!("Cannot not read from input: {}", e);
      process::exit(1);
    }
  };

  // 2) Parse and validate input
  let trimmed = input.trim();
  let n: u32 = match trimmed.parse() {
    Ok(value) => value,
    Err(_) => {
      eprint!("Invalid input; not an unsigned integer");
      process::exit(1);
    }
  };

  // 3) Check if n is safe
  if n > 93 {
    eprint!("I can only compute fibonacci(n) for n <= 93");
    process::exit(1);
  }

  // 4) Calculate Fibonacci
  let result = fibonacci(n).to_string();

  // 5) Write to output.txt
  if let Err(e) = std::fs::write("output.txt", result) {
    eprint!("Cannot write to output: {}", e);
    process::exit(1);
  }
}
