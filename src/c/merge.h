#ifndef MERGE_H
#define MERGE_H

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void parallel_merge_sort(uint32_t* arr, uint32_t* arrend);
void serial_merge_sort(uint32_t* arr, uint32_t* arrend);

#endif
