#include <array>
#include <charconv>
#include <cstdint>
#include <cerrno>
#include <cstring>
#include <fstream>
#include <iostream>
#include <string>
#include <string_view>
#include <cstdlib>

/*
  Maximum Fibonacci value
  -----------------------
  This implementation uses uint64_t, which can store values up to 18,446,744,073,709,551,615 (2^64 - 1).
  The largest Fibonacci number that fits into a uint64_t is Fibonacci(93), which equals 12,200,160,415,121,876,738.

  Attempting to calculate Fibonacci(94) would result in a value that exceeds the limit of uint64_t, causing an overflow.


  Explanation of the optimization
  -------------------------------
  The previous approach used an iterative method to calculate the Fibonacci number, which required O(n) time.
  This means that for large values of n, the number of iterations and the time taken increases linearly with n.

  The matrix exponentiation approach improves this by reducing the time complexity to O(log n) using binary exponentiation.
  This works because the Fibonacci sequence can be represented as a matrix exponentiation problem:

	  [ F(n)   F(n-1) ] = [ 1 1 ]^n
	  [ F(n-1) F(n-2) ]   [ 1 0 ]

  Raising the matrix to the nth power gives us the nth Fibonacci number in the top left position of the matrix.
  Instead of calculating each Fibonacci number one by one (as in the iterative approach), we can calculate the power of the matrix
  in logarithmic time using a divide-and-conquer technique (binary exponentiation).

  This is much faster for large values of n, such as n = 50, or more. The iterative approach would take 50 steps for n = 50,
  whereas the matrix exponentiation method takes only about 6 steps (since log2(50) ≈ 6). This makes the matrix exponentiation
  approach more efficient for larger inputs.
*/

// Trim spaces and newlines from a string_view
static std::string_view trim(std::string_view sv) {
    const std::string_view ws = " \t\r\n";
    auto first = sv.find_first_not_of(ws);
    if (first == std::string_view::npos) {
        return {};
    }
    auto last = sv.find_last_not_of(ws);
    return sv.substr(first, last - first + 1);
}

// Multiply two 2×2 matrices
std::array<std::array<uint64_t, 2>, 2>
matrix_multiply(const std::array<std::array<uint64_t, 2>, 2>& A,
                const std::array<std::array<uint64_t, 2>, 2>& B) {
    return {{
        {{ A[0][0] * B[0][0] + A[0][1] * B[1][0],
           A[0][0] * B[0][1] + A[0][1] * B[1][1] }},
        {{ A[1][0] * B[0][0] + A[1][1] * B[1][0],
           A[1][0] * B[0][1] + A[1][1] * B[1][1] }}
    }};
}

// Raise the base matrix to the power exp using binary exponentiation
std::array<std::array<uint64_t, 2>, 2>
matrix_pow(std::array<std::array<uint64_t, 2>, 2> base, uint32_t exp) {
    // Identity 2×2 matrix
    std::array<std::array<uint64_t, 2>, 2> result = {{{1, 0}, {0, 1}}};

    while (exp > 0) {
        if (exp & 1) {
            result = matrix_multiply(result, base);
        }
        base = matrix_multiply(base, base);
        exp >>= 1;
    }
    return result;
}

// Fibonacci using transformation matrix
// F(0)=0, F(1)=1
uint64_t fibonacci(uint32_t n) {
    if (n < 2) {
        return n;
    }
    std::array<std::array<uint64_t, 2>, 2> M = {{{1, 1}, {1, 0}}};
    return matrix_pow(M, n - 1)[0][0];
}

int main() {
    // 1) Read input.txt
    const char* in_path = "input.txt";
    std::ifstream ifs{ in_path };
    if (!ifs) {
        std::cerr << "Cannot open input: " << std::strerror(errno);
        return EXIT_FAILURE;
    }

    // 2) Read the first line
    std::string line;
    if (!std::getline(ifs, line)) {
        if (ifs.eof()) {
            std::cerr << "Invalid input";
        } else {
            std::cerr << "Error reading input: " << std::strerror(errno);
        }
        return EXIT_FAILURE;
    }

    // 3) Parse n (must be between 0 and 93)
    auto sv = trim(line);
    if (sv.empty()) {
        std::cerr << "Invalid input";
        return EXIT_FAILURE;
    }

    uint32_t n = 0;
    auto [ptr, ec] = std::from_chars(sv.data(), sv.data() + sv.size(), n);
    if (ec == std::errc::invalid_argument) {
        std::cerr << "Not a valid number";
        return EXIT_FAILURE;
    }
    if (ec == std::errc::result_out_of_range) {
        std::cerr << "Number too large for uint32_t";
        return EXIT_FAILURE;
    }
    if (ptr != sv.data() + sv.size()) {
        std::cerr << "Extra characters after number";
        return EXIT_FAILURE;
    }

    if (n > 93u) {
        std::cerr << "I can only calculate Fibonacci numbers up to 93";
        return EXIT_FAILURE;
    }

    // 4) Compute Fibonacci(n)
    uint64_t result = fibonacci(n);

    // 5) Write to output.txt
    const char* out_path = "output.txt";
    std::ofstream ofs{ out_path };
    if (!ofs) {
        std::cerr << "Cannot open output: " << std::strerror(errno);
        return EXIT_FAILURE;
    }
    ofs << result;

    return EXIT_SUCCESS;
}
