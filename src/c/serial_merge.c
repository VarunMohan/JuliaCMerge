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

static void merge_sort_helper(uint32_t* arr, uint32_t n, int32_t* aux, bool sort_in_arr) {
  if (n == 1) {
    *aux = *arr;
    return;
  }

  merge_sort_helper(arr, n/2, aux, !sort_in_arr);
  merge_sort_helper(arr + n/2, n - n/2, aux + n/2, !sort_in_arr);

  if (sort_in_arr) {
    merge(arr, aux, aux + n/2, aux + n/2, aux + n);
  } else {
    merge(aux, arr, arr + n/2, arr + n/2, arr + n);
  }
}

void serial_merge_sort(uint32_t* arr, uint32_t* arrend) {
  uint32_t n = arrend - arr;
  uint32_t *aux = (uint32_t*)malloc(sizeof(uint32_t) * (n)); //auxilliary memory for merge sort

  merge_sort_helper(arr, n, aux, true);

  free(aux);
}
