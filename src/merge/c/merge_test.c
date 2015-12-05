#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <string.h>
#include <cilk/cilk_api.h>

#include "sort.h"

#define DEFAULT_ARR_SIZE (1L << 23)
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

double time(void (*func)(uint32_t *start, uint32_t *end), uint32_t *data, size_t size) {
    double start = get_time();
    func(data, data + size);
    return get_time() - start;
}

int main(int argc, char *argv[]) {
  srand(time(NULL));
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

  uint32_t* serial_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);
  uint32_t* parallel_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);
  uint32_t* qsort_arr = (uint32_t*)malloc(sizeof(uint32_t) * arr_size);

  double serial_time = 0;
  double parallel_time = 0;
  double qsort_time = 0;

  for (size_t checks = 1; checks <= num_checks; checks++) {
    printf("Check %lu\n", checks);
    for (size_t i = 0; i < arr_size; i++) {
      serial_arr[i] = parallel_arr[i] = qsort_arr[i] = rand() % 100;
    }

    double start_time = get_time();
    serial_merge_sort(serial_arr, serial_arr + arr_size);
    double serial_end = get_time();
    parallel_merge_sort(parallel_arr, parallel_arr + arr_size);
    double parallel_end = get_time();
    qsort(qsort_arr, arr_size, sizeof(uint32_t), uint32_t_compare);
    double qsort_end = get_time();

    serial_time += serial_end - start_time;
    parallel_time += parallel_end - serial_end;
    qsort_time += qsort_end - parallel_end;

    for (size_t i = 0; i < arr_size; i++) {
      if (qsort_arr[i] != serial_arr[i] || qsort_arr[i] != parallel_arr[i]) {
        if (qsort_arr[i] != serial_arr[i]) {
          printf("Fail! Serial Merge is Incorrect\n");
        } else {
          printf("Fail! Parallel Merge is Incorrect\n");
        }
        return 0;
      }
    }
  }

  printf("Success\n");
  printf("Average time for each Serial Merge Sort: %.6fs\n", serial_time/num_checks);
  printf("Average time for each Parallel Merge Sort: %.6fs\n", parallel_time/num_checks);
  printf("Average time for each Builtin QSort: %.6fs\n", qsort_time/num_checks);
}
