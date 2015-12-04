#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <cilk/cilk.h>

double current_timestamp() {
    struct timeval te;
    gettimeofday(&te, NULL);
    double res = te.tv_sec + ((double)te.tv_usec)/1000000.0;
    return res;
}

void parallel_transpose(double** A, int n) {
  cilk_for (int i = 0; i < n; i++) {
    for (int j = 0; j < i; j++) {
      double temp = A[i][j];
      A[i][j] = A[j][i];
      A[j][i] = temp;
    }
  }
}

void serial_transpose(double** A, int n) {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < i; j++) {
      double temp = A[i][j];
      A[i][j] = A[j][i];
      A[j][i] = temp;
    }
  }
}

int main(int argc, char* argv[]) {
  int n = 10000;
  int loop = 15;
  double* A[n];
  int i;
  for (i = 0; i < n; i++) {
    A[i] = (double*)malloc(sizeof(double) * n);
  }

  int j;
  double count = 0.0;
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
      A[i][j] = count;
      count += 1.0;
    }
  }

  double start1, end1, end2;
  start1 = current_timestamp();
  for (int i = 0; i < 5; i++)
    serial_transpose(A, n);
  end1 = current_timestamp();
  for (int i = 0; i < 5; i++)
    parallel_transpose(A, n);
  end2 = current_timestamp();
  printf("Elapsed serial time: %.6fs\n", end1 - start1);
  printf("Elapsed parallel time: %.6fs\n", end2 - end1);
  return 0;
}
