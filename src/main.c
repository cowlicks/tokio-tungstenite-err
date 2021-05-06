#include <stdint.h>
#include <stdio.h>

extern void* init_runtime();
extern void* connect(void* runtime);

int main() {
    printf("Running C main\n");
    void* runtime = init_runtime();
    printf("Runtime ready in C\n");
    connect(runtime);
    return 0;
}
