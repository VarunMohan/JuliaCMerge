#ifndef SORT_H
#define SORT_H

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>

#define SMALL_THRESHOLD 32

void parallel_merge_sort(uint32_t* arr, uint32_t* arrend);
void serial_merge_sort(uint32_t* arr, uint32_t* arrend);
void naive_serial_merge_sort(uint32_t* arr, uint32_t* arrend);

static inline void insertion_sort(uint32_t* arr, uint32_t* arrend) {
  for (uint32_t *i = arr + 1, *j; i < arrend; i++) {
    uint32_t x = *i;
    for (j = i; j > arr; j--) {
      if (x < *(j - 1)) {
        *j = *(j - 1);
        continue;
      }
      break;
    }
    *j = x;
  }
}


#endif
