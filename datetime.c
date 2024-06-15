#include <stdio.h>
#include <time.h>

int main() {
    time_t t = 0;
    struct tm tm;
    char buf[64] = {0};

    time(&t);
    localtime_s(&tm, &t);
    strftime(buf, sizeof(buf), "%Y%m%d_%H%M%S", &tm);
    printf("%s\n", buf);
    return 0;
}