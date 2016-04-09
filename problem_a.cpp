#include <iostream>
#include <set>
#include <cmath>

using namespace std;

int getNthDigit(int n, int pos) {
    n /= pow(10, pos);
    return n % 10;
}

int getNumDigits(int n) {
    int retVal = 1;
    while(n /= 10) {
        retVal++;
    }
    return retVal;
}

void printOutput(int numCases, int* solutions) {
    for(int i = 0; i < numCases; i++) {
        cout << "Case #" << i+1 << ": ";
        if(solutions[i] == 0) {
            cout << "INSOMNIA" << endl;
        } else {
            cout << solutions[i] << endl;
        }
    }
}

int main(int argc, char** args) {
    int numCases = 1;
    cin >> numCases;

    int N[numCases];
    int solutions[numCases];

    for(int i = 0; i < numCases; i++) {
        cin >> N[i];
    }

    for(int i = 0; i < numCases; i++) {
        solutions[i] = 0;
    }

    for(int i = 0; i < numCases; i++) {
        set<int> digitSet;
        set<int>::iterator it;
        if(N[i] == 0) {
            solutions[i] = 0;
        } else {
            for(int j = 1; digitSet.size() < 10; j++) {
                int digit = j*N[i];
                int numDigits = getNumDigits(digit);

                for(int k = 0; k < numDigits; k++) {
                    int nthDigit = getNthDigit(digit, k);
                    digitSet.insert(nthDigit);
                }
                solutions[i] = digit;
            }
        }
    }

    printOutput(numCases, solutions);
}

