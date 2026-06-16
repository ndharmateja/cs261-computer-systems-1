#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct User {
    char username[16];
    int id;
    int *login_timestamps; // Pointer to a heap-allocated array
};

void upgrade_user(struct User *u) {
    u->id = u->id + 1000;
    u->login_timestamps[0] = 2026; // Updating heap memory via pointer
}

int main() {
    struct User user1;
    
    // 1. Initialize stack data
    strcpy(user1.username, "Alice_Dev");
    user1.id = 42;
    
    // 2. Allocate memory on the HEAP
    user1.login_timestamps = (int *)malloc(3 * sizeof(int));
    user1.login_timestamps[0] = 2019;
    user1.login_timestamps[1] = 2022;
    user1.login_timestamps[2] = 2025;

    // 3. Pass by pointer to a function
    upgrade_user(&user1);

    // 4. Clean up
    free(user1.login_timestamps);
    return 0;
}