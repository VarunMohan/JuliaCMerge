#include "merge.h"

//merge two sorted arrays A and B into array C
static void merge(uint32_t* C, uint32_t* A, uint32_t* Aend, uint32_t* B, uint32_t* Bend) {
  while (A < Aend && B < Bend) {
    if (*A < *B) {
      *C++ = *A++;
    } else {
      *C++ = *B++;
    }
  }
  while (A < Aend) {
    *C++ = *A++;
  }
  while (B < Bend) {
    *C++ = *B++;
  }
}

static void merge_sort_helper(uint32_t* start, uint32_t* end, uint32_t* aux) {
  uint32_t n = (end - start);
  if (n == 1) {
    return;
  }
  int* mid = start + n/2;

  merge_sort_helper(start, mid, aux);
  merge_sort_helper(mid, end, aux + n/2);

  merge(aux, start, mid, mid, end);
  memcpy(start, aux, n * sizeof(uint32_t));
}

void serial_merge_sort(uint32_t* arr, uint32_t* arrend) {
  uint32_t n = arrend - arr;
  uint32_t *aux = (uint32_t*)malloc(sizeof(uint32_t) * (n)); //auxilliary memory for merge sort

  merge_sort_helper(arr, arrend, aux);

  free(aux);
}
