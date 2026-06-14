#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

int main()
{
    int8_t x = 250;
    for (int i = 250; i <= 260; ++i)
        printf("[%d] %" PRId8 "\n", i, x++);
    return 0;
}
