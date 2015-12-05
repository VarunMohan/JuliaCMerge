#ifndef SORT_H
#define SORT_H

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>

void parallel_merge_sort(uint32_t* arr, uint32_t* arrend);
void serial_merge_sort(uint32_t* arr, uint32_t* arrend);

static void insertion_sort(uint32_t* arr, uint32_t* arrend) {
  for (uint32_t *i = arr + 1, *j; i < arrend; i++) {
    uint32_t x = *i;
    for (j = i; j > arr; j--) {
      if (*j < *(j - 1)) {
        *j = *(j - 1);
        continue;
      }
      break;
    }
    *j = x;
  }
}


#endif
