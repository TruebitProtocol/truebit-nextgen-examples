#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>

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

// Helper function to multiply two 2x2 matrices
void multiply(uint64_t F[2][2], uint64_t M[2][2]) {
  uint64_t x = F[0][0] * M[0][0] + F[0][1] * M[1][0];
  uint64_t y = F[0][0] * M[0][1] + F[0][1] * M[1][1];
  uint64_t z = F[1][0] * M[0][0] + F[1][1] * M[1][0];
  uint64_t w = F[1][0] * M[0][1] + F[1][1] * M[1][1];

  F[0][0] = x;
  F[0][1] = y;
  F[1][0] = z;
  F[1][1] = w;
}

// Helper function to raise the matrix F to the power of n using binary exponentiation
void power(uint64_t F[2][2], uint32_t n) {
  if (n < 2) {
    return;
  }
  
  uint64_t M[2][2] = {{1, 1}, {1, 0}};
  
  power(F, n / 2);
  multiply(F, F);

  if (n % 2 != 0) {
      multiply(F, M);
  }
}

// Optimized Fibonacci function using matrix exponentiation
uint64_t fibonacci(uint32_t n) {
  if (n < 2) {
    return n;
  }

  uint64_t F[2][2] = {{1, 1}, {1, 0}};
  power(F, n - 1);

  return F[0][0];  // F[0][0] contains the nth Fibonacci number
}

int main() {
  char buf[21];
  {
    FILE *fpi = fopen("input.txt", "r");
    if (fpi == NULL) {
      fprintf(stderr, "Cannot open input: %s", strerror(errno));
      return 1;
    }
    
    if (fgets(buf, sizeof(buf), fpi) == NULL) {
      if (ferror(fpi)) {
        fprintf(stderr, "Error reading input: %s", strerror(errno));
        fclose(fpi);
        return 1;
      }
      else {
        fprintf(stderr, "Invalid input size");
        fclose(fpi);
        return 1;
      }
    }
    
    if (fclose(fpi) != 0) {
      fprintf(stderr, "Cannot close input file");
      return 1;
    }
    
    /*    
      The overall condition ensures that the input in `buf` is either a single digit or a two-digit number. 
      This validation logic is useful for scenarios where the program expects strictly numeric input of one or two digits, 
      such as a user entering a number between 0 and 99.
    */
    if (!buf[0] || (buf[0] < '0' || buf[0] > '9') || (buf[1] && (buf[1] < '0' || buf[1] > '9')) || buf[2] != '\0') {
      fprintf(stderr, "Invalid input");
      return 1;
    }
    
    uint32_t n = buf[0] - '0';
    if (buf[1]) {
      n *= 10;
      n += buf[1] - '0';
    }
    
    if (n > 93) {
        fprintf(stderr, "I can only calculate Fibonacci numbers up to 93");
        return 1;
    }

    uint64_t result = fibonacci(n);
    snprintf(buf, sizeof(buf), "%llu", result);
  }
  {
    FILE *fpo = fopen("output.txt", "w");
    if (fpo == NULL) {
      fprintf(stderr, "Cannot open output: %s", strerror(errno));
      return 1;
    }
    
    if (fputs(buf, fpo) == EOF) {
      fprintf(stderr, "Error writing output: %s", strerror(errno));
      fclose(fpo);
      return 1;  
    }
    
    if (fclose(fpo) != 0) {
      fprintf(stderr, "Cannot close output file");
      return 1;
    }
  }
    
  return 0;
}
