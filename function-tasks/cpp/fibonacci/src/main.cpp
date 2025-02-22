#include <iostream>
#include <fstream>
using namespace std;
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
string runTask(const string& input) {
    int inputValue = stoi(input);
    return to_string(fibonacci(inputValue));
}
int main() {
    ifstream inputFile("input.txt");
    if (!inputFile) {
        cerr << "Could not read from input.txt" << endl;
        return 1;
    }
    string input;
    getline(inputFile, input);
    inputFile.close();
    string output = runTask(input);
    ofstream outputFile("output.txt");
    if (!outputFile) {
        cerr << "Could not write to output.txt" << endl;
        return 1;
    }
    outputFile << output;
    outputFile.close();
    cout << "Output written to output.txt" << endl;
    return 0;
}