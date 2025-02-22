#include <stdio.h>
#include <stdlib.h>

unsigned long long fibonacci(int n) {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    }

    unsigned long long a = 0;
    unsigned long long b = 1;
    unsigned long long c = 0;

    for (int i = 2; i <= n; i++) {
        c = a + b;
        a = b;
        b = c;
    }

    return c;
}

char* runTask(int inputValue) {
    unsigned long long result = fibonacci(inputValue);
    
    char* output = (char*)malloc(20); 
    sprintf(output, "%llu", result);
    
    return output;
}

int main() {
    FILE* inputFile = fopen("input.txt", "r");
    if (inputFile == NULL) {
        perror("Error opening input.txt");
        return 1;
    }

    int input;
    if (fscanf(inputFile, "%d", &input) != 1) {
        perror("Error reading input from input.txt");
        fclose(inputFile);
        return 1;
    }
    
    fclose(inputFile);

    char* output = runTask(input);

    FILE* outputFile = fopen("output.txt", "w");
    if (outputFile == NULL) {
        perror("Error opening output.txt");
        free(output);
        return 1;
    }

    fprintf(outputFile, "%s", output);
    fclose(outputFile);
    free(output);

    printf("output.txt\n");

    return 0;
}
