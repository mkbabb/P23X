#include <stdio.h>
#include <stdlib.h>


int main() {
    int tab_amount = '9';
    tab_amount -= '0';

    printf("%d\n", tab_amount);

    int tab_counter = tab_amount;

    while (1) {
        char c = getchar();

        if (c == EOF) {
            break;
        }

        if (c == '\t') {
            while (tab_counter > 0) {
                putchar(' ');
                tab_counter -= 1;
            }
            tab_counter = tab_amount;
        } else {
            putchar(c);

            if (c == '\n' || c == '\r') {
                tab_counter = tab_amount;
            } else {
                tab_counter -= 1;
            }
        }
    }
}