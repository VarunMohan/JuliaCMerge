#include <stdio.h>
#include "./merge.c"

int main() {
  int arr[] = {5, 6, 7,8,  4, 1};
  for (int i = 0; i < 5; i++) {
   printf("%d ", arr[i]);
  }
  printf("\n");
  merge_sort(arr, arr + 5);
  for (int i = 0; i < 5; i++) {
   printf("%d ", arr[i]);
  }
  printf("\n");
}
