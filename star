#include <stdio.h>

int main() {
    int n, i;

    printf("Enter number of nodes: ");
    scanf("%d", &n);

    printf("Star Topology:\n");

    for(i = 1; i <= n; i++) {
        printf("Node %d connected to Hub\n", i);
    }

    return 0;
}
