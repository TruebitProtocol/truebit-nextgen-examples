#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>

int main() {
    std::ifstream inputFile("input.txt");
    if (!inputFile) {
        std::cerr << "Error opening input.txt" << std::endl;
        return 1;
    }

    std::string inputString;
    char character;

    while (inputFile.get(character)) {
        inputString += character;
    }

    std::reverse(inputString.begin(), inputString.end()); 
    std::ofstream outputFile("output.txt");
    if (!outputFile) {
        std::cerr << "Error opening output.txt" << std::endl;
        return 1;
    }

    outputFile << inputString;

    std::cout << "inverted from input.txt to output.txt" << std::endl;

    return 0;
}