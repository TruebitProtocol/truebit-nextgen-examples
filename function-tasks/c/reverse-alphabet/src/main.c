#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    FILE *inputFile = fopen("input.txt", "r");
    if (inputFile == NULL) {
        perror("Error opening input.txt");
        return 1;
    }

    FILE *outputFile = fopen("output.txt", "w");
    if (outputFile == NULL) {
        perror("Error opening output.txt");
        fclose(inputFile);
        return 1;
    }

    char *inputString = NULL;
    size_t inputStringSize = 0;
    char character;

    while ((character = fgetc(inputFile)) != EOF) {
        inputString = (char *)realloc(inputString, inputStringSize + 1);
        inputString[inputStringSize++] = character;
    }

    inputString[inputStringSize] = '\0';

    int start = 0;
    int i;

    if (inputStringSize > 0 && inputString[0] == '\n') {
        start = 1;
    }

    for (i = inputStringSize - 1; i >= start; i--) {
        if (inputString[i] != '\n') {
            fputc(inputString[i], outputFile);
        }
    }

    if (i < start && start == 1) {
        fputc('\n', outputFile);
    }

    free(inputString);
    fclose(inputFile);
    fclose(outputFile);

    return 0;
}