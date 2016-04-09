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

int main() {
    int numCases = 1;
    int N[numCases];
    int solutions[numCases];
    cout << "Input" << endl;
    cin >> numCases;

    for(int i = 0; i < numCases; i++) {
        cin >> N[i];
    }

    bool isInsomnia[numCases];
    cout << "numCases: " << numCases << endl;
    for(int i = 0; i < numCases; i++) {
        cout << "N[" << i << "]: " << N[i] << endl;
        solutions[i] = 0;
    }


    for(int i = 0; i < numCases; i++) {
        cout << "Case: " << i+1 << endl;
        set<int> digitSet;
        set<int>::iterator it;
        if(N[i] == 0) {
            solutions[i] = 0;
        } else {
            for(int j = 1; digitSet.size() < 10; j++) {
                int digit = j*N[i];
                int numDigits = getNumDigits(digit);
                cout << "digit: " << digit << endl;

                for(int k = 0; k < numDigits; k++) {
                    int nthDigit = getNthDigit(digit, k);
                    digitSet.insert(nthDigit);
                    cout << "Insert " << nthDigit << endl;
                }
                cout << "digitSetCount: " << digitSet.size() << endl;
                solutions[i] = digit;
            }
        }
    }

    for(int i = 0; i < numCases; i++) {
        cout << "Case #" << i << ": ";
        if(solutions[i] == 0) {
            cout << "INSOMNIA" << endl;
        } else {
            cout << solutions[i] << endl;
        }
    }
}

