#include <iostream>

using namespace std;

int main() {
    int n, x, sum;
    sum = 0;
    cin >> n;
    while (n != 0) {
        cin >> x;
        sum = sum + x;
        n = n - 1;
    }
    cout << sum;
    return 0;
}