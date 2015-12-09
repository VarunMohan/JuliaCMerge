#include <cilk/cilk.h>
#include <omp.h>

#include "sort.h"

//merge two sorted arrays A and B into array C
static void serial_merge(uint32_t* C, uint32_t* A, uint32_t* Aend, uint32_t* B, uint32_t* Bend) {
    while (A < Aend && B < Bend) {
        if (*A < *B) {
            *C++ = *A++;
        } else {
            *C++ = *B++;
        }
    }
    if (A < Aend) {
        memcpy(C, A, (Aend - A) * sizeof(*A));
    } else {
        memcpy(C, B, (Bend - B) * sizeof(*B));
    }
}

static void merge_sort_helper(uint32_t* arr, uint32_t n, int32_t* aux) {
    if (n <= SMALL_THRESHOLD) {
        insertion_sort(arr, arr + n);
        return;
    }

    if (n < PARALLEL_THRESHOLD) {
        merge_sort_helper(aux, n/2, arr);
        merge_sort_helper(aux + n/2, n - n/2, arr + n/2);
    } else {
        cilk_spawn merge_sort_helper(aux, n/2, arr);
        merge_sort_helper(aux + n/2, n - n/2, arr + n/2);
        cilk_sync;
    }

    serial_merge(arr, aux, aux + n/2, aux + n/2, aux + n);
}

void parallel_merge_sort(uint32_t* arr, uint32_t* arrend) {
    uint32_t n = arrend - arr;
    uint32_t *aux = (uint32_t*)malloc(sizeof(uint32_t) * (n)); //auxilliary memory for merge sort

    memcpy(aux, arr, n * sizeof(*arr));

    merge_sort_helper(arr, n, aux);

    free(aux);
}
