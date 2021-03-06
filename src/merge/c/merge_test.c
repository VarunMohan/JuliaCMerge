#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <string.h>
#include <cilk/cilk_api.h>

#include "sort.h"

#define DEFAULT_ARR_SIZE (1LL << 23)
#define DEFAULT_NUM_CHECKS 3

int uint32_t_compare (const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

double get_time() {
    struct timeval te;
    gettimeofday(&te, NULL);
    double res = te.tv_sec + ((double)te.tv_usec)/1000000.0;
    return res;
}

double benchmark(void (*func)(uint32_t *start, uint32_t *end), uint32_t *data, size_t size) {
    double start = get_time();
    func(data, data + size);
    return get_time() - start;
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    setbuf(stdout, 0);
    //__cilkrts_set_param("nworkers", "8");

    size_t arr_size = DEFAULT_ARR_SIZE;
    size_t num_checks = DEFAULT_NUM_CHECKS;

    if (argc > 1) {
        num_checks = atoi(argv[1]);
        if (argc > 2) {
            arr_size = atoi(argv[2]);
        }
    }

    printf("Performing %lu Sorting Tests on Array of Size %lu\n", num_checks, arr_size);

    uint32_t* orig_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);
    uint32_t* data_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);
    uint32_t* qsort_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);

    #define NVARIANTS 6
    void (*funcs[NVARIANTS + 1]) = {NULL, serial_merge_sort, naive_serial_merge_sort, optimized_serial_merge_sort, parallel_merge_sort, naive_parallel_merge_sort, optimized_parallel_merge_sort};
    double times[NVARIANTS + 1] = {0, 0, 0, 0, 0, 0}, time;
    char *names[NVARIANTS + 1] = {"Builtin Quick", "Serial Merge", "Naive Serial Merge", "Optimized Serial Merge", "Parallel Merge", "Naive Parallel Merge", "Optimized Parallel Merge"};

    for (size_t checks = 1; checks <= num_checks; checks++) {
        printf("Check %lu\n", checks);
        for (size_t i = 0; i < arr_size; i++)
            orig_arr[i] = qsort_arr[i] = rand();

        printf("\t Running %s Sort...", names[0]);
        double start_time = get_time();
        qsort(qsort_arr, arr_size, sizeof(uint32_t), uint32_t_compare);
        double end_time = get_time();
        times[0] += time = end_time - start_time;
        printf("%.6fs\n", time);

        for (int i = 1; i <= NVARIANTS; i++) {
            printf("\t Running %s Sort...", names[i]);
            memcpy(data_arr, orig_arr, arr_size * sizeof(uint32_t));
            times[i] += time = benchmark(funcs[i], data_arr, arr_size);
            for (size_t j = 0; j < arr_size; j++)
                if (qsort_arr[j] != data_arr[j]) {
                    printf("Fail! %s is incorrect (index=%lu, correct=%u, wrong=%u)\n", names[i], j, qsort_arr[j], data_arr[j]);
                    return 0;
                }
            printf("%.6fs\n", time);
        }
    }

    printf("Success\n");
    for (int i = 0; i <= NVARIANTS; i++)
        printf("Average time for each %s Sort: %.6fs\n", names[i], times[i] / num_checks);
}
