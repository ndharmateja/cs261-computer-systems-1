#include <stdio.h>

int main(int argc, char const *argv[])
{
    // Segmentation fault on Linux
    // Not standardized - behaviour undefined
    printf("%s\n", (char *)NULL);
    return 0;
}
