#include <stdio.h>
#include <unistd.h>
#include <stdbool.h>
#include <stdlib.h>

/**
 * Usage: ./get_opt [options] <filename>
 *  Valid options:
 *   -a:    Print an 'A'
 *   -b:    Print a 'B'
 */
void error_exit()
{
    printf("Usage: ./get_opt [options] <filename>\n");
    printf("Valid options:\n");
    printf(" -a:    Print an 'A'\n");
    printf(" -b:    Print a 'B'\n");
    exit(EXIT_FAILURE);
}

int main(int argc, char *argv[])
{
    int opt;
    bool a_flag = false, b_flag = false;
    while ((opt = getopt(argc, argv, "ab")) != -1)
    {
        switch (opt)
        {
        case 'a':
            a_flag = true;
            break;
        case 'b':
            b_flag = true;
            break;
        default:
            error_exit();
        }
    }

    // optind will be the index of the next arg
    if (optind != argc - 1)
        error_exit();

    // Get the filename
    char *filename = argv[optind];
    return 0;
}
