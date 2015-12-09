#include "sort.h"

static void cpy(uint32_t *to, uint32_t *from, size_t bytes) {
    memcpy(to, from, bytes);
}

static void merge_sort_helper(uint32_t *v, size_t lo, size_t hi, uint32_t *t) {
    if (lo < hi) {
        if (hi - lo <= SMALL_THRESHOLD)
            return insertion_sort(v + lo, v + hi + 1);

        size_t m = (lo + hi) >> 1;

        merge_sort_helper(v, lo, m, t);
        merge_sort_helper(v, m + 1, hi, t);

        cpy(t + lo, v + lo, (m - lo + 1) * sizeof(*v));

        size_t i = lo, j = m + 1, k = lo;
        while (k < j && j <= hi)
            if (v[j] < t[i])
                v[k++] = v[j++];
            else
                v[k++] = t[i++];

        memcpy(v + k, t + i, (j - k) * sizeof(*t));
    }
}

void optimized_serial_merge_sort(uint32_t* arr, uint32_t* arrend) {
    uint32_t n = arrend - arr;
    uint32_t *aux = (uint32_t*)malloc(sizeof(uint32_t) * (n)); //auxilliary memory for merge sort

    memcpy(aux, arr, n * sizeof(*arr));

    merge_sort_helper(arr, 0, n - 1, aux);

    free(aux);
}
