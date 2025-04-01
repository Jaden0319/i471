#include <stdlib.h>
#include <stdio.h>

enum { N0 = 7, N1 = 6 };

int matrix[N0][N1];

/** set *i and *j to indexes in matrix such that the byte offset
 *  of matrix[*i][*j] is equal to offset.  Set *i, *j to -1
 *  if there is no such offset (i.e. if offset is misaligned
 *  or larger than any possible offset).
 */
 static void matrix_offset_indexes(off_t offset, int *i, int *j) {
  size_t entry_size = sizeof(matrix[0][0]);
  size_t total_size = sizeof(matrix);

  if (offset >= total_size || offset % entry_size != 0) {
    *i = -1;
    *j = -1;
    return;
  }

  int entry_index = offset / entry_size;
  *i = entry_index / N1;
  *j = entry_index % N1;
}


int main(int argc, const char *argv[]) {
  printf("sizeof matrix entry = %zu; sizeof matrix = %zu\n",
         sizeof(matrix[0][0]), sizeof(matrix));
  for (int i = 1; i < argc; i++) {
    off_t offset = atoi(argv[i]);
    int i, j;
    matrix_offset_indexes(offset, &i, &j);
    printf("offset: %zu; indexes: (%d, %d)\n", offset, i, j);
  }
}
