#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "./merge.c"

#define DEFAULT_ARR_SIZE (1 << 21)
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

  printf("Performing %d Sorting Tests on Array of Size %d\n", num_checks, arr_size);

  uint32_t* arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);
  uint32_t* test_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);

  uint64_t merge_time = 0;
  uint64_t qsort_time = 0;

  for (size_t checks = 1; checks <= num_checks; checks++) {
    printf("Check %d\n", checks);
    for (size_t i = 0; i < arr_size; i++) {
      arr[i] = test_arr[i] = rand();
    }

    clock_t start_time = clock();
    merge_sort(arr, arr + arr_size);
    clock_t merge_end = clock();
    qsort(test_arr, arr_size, sizeof(uint32_t), uint32_t_compare);
    clock_t qsort_end = clock();

    merge_time += merge_end - start_time;
    qsort_time += qsort_end - merge_end;

    for (size_t i = 0; i < arr_size; i++) {
      if (test_arr[i] != arr[i]) {
        printf("Fail!\n");
        return 0;
      }
    }
  }

  printf("Success\n");
  printf("Clocks for each Serial Merge Sort: %lu\n", merge_time/num_checks);
  printf("Clocks for each Builtin QSort: %lu\n", qsort_time/num_checks);
}
