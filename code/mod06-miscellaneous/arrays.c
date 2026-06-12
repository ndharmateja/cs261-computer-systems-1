#include <stdio.h>

int main(int argc, char const *argv[])
{
    int a1[] = {1, 2, 3, 4};  // OK
    int a2[4] = {1, 2, 3, 4}; // OK
    // int *a3 = {1, 2, 3, 4};   // Not OK

    char b1[] = {'a', 'b', 'c', 'd'};  // OK
    char b2[4] = {'a', 'b', 'c', 'd'}; // OK
    char b3[5] = "abcd";               // OK

    // this "abcd" is a string literal that is stored in the
    // read only memory of the program
    const char *b4 = "abcd"; // OK - special case for C strings

    return 0;
}
