#ifndef MERGE_H
#define MERGE_H

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>

void parallel_merge_sort(uint32_t* arr, uint32_t* arrend);
void serial_merge_sort(uint32_t* arr, uint32_t* arrend);

#endif
