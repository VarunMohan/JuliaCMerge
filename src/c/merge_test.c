#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#include "merge.h"

#define DEFAULT_ARR_SIZE (1L << 21)
#define DEFAULT_NUM_CHECKS 10

int uint32_t_compare (const void* a, const void* b) {
  return (*(int*)a - *(int*)b);
}

int main(int argc, char *argv[]) {
  srand(time(NULL));

  size_t arr_size = DEFAULT_ARR_SIZE;
  size_t num_checks = DEFAULT_NUM_CHECKS;

  if (argc > 1) {
    num_checks = atoi(argv[1]);
    if (argc > 2) {
      arr_size = atoi(argv[2]);
    }
  }

  printf("Performing %lu Sorting Tests on Array of Size %lu\n", num_checks, arr_size);

  uint32_t* serial_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);
  uint32_t* parallel_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);
  uint32_t* qsort_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);

  uint64_t serial_time = 0;
  uint64_t parallel_time = 0;
  uint64_t qsort_time = 0;

  for (size_t checks = 1; checks <= num_checks; checks++) {
    printf("Check %lu\n", checks);
    for (size_t i = 0; i < arr_size; i++) {
      serial_arr[i] = parallel_arr[i] = qsort_arr[i] = rand();
    }

    clock_t start_time = clock();
    serial_merge_sort(serial_arr, serial_arr + arr_size);
    clock_t serial_end = clock();
    parallel_merge_sort(parallel_arr, parallel_arr + arr_size);
    clock_t parallel_end = clock();
    qsort(qsort_arr, arr_size, sizeof(uint32_t), uint32_t_compare);
    clock_t qsort_end = clock();

    serial_time += serial_end - start_time;
    parallel_time += parallel_end - serial_end;
    qsort_time += qsort_end - parallel_end;

    for (size_t i = 0; i < arr_size; i++) {
      if (qsort_arr[i] != serial_arr[i] || qsort_arr[i] != parallel_arr[i]) {
        printf("Fail!\n");
        return 0;
      }
    }
  }

  printf("Success\n");
  printf("Average time for each Serial Merge Sort: %.6fs\n", serial_time*1.f/CLOCKS_PER_SEC/num_checks);
  printf("Average time for each Parallel Merge Sort: %.6fs\n", parallel_time*1.f/CLOCKS_PER_SEC/num_checks);
  printf("Average time for each Builtin QSort: %.6fs\n", qsort_time*1.f/CLOCKS_PER_SEC/num_checks);
}
