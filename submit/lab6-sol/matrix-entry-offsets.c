#include <stdlib.h>
#include <stdio.h>

enum { N0 = 5, N1 = 3 };

double matrix[N0][N1];

/** return byte offset of matrix[i][j] from base of matrix */
static off_t entry_offset(int i, int j) {
  return (char *)&matrix[i][j] - (char *)&matrix[0][0];
}

int main() {
  for (int i = 0; i < sizeof(matrix)/sizeof(matrix[0]); i++) {
    for (int j = 0; j < sizeof(matrix[0])/sizeof(matrix[0][0]); j++) {
      off_t offset0 = entry_offset(i, j);

      //calculate offset of matrix[i][j] from base of matrix "manually".
      off_t offset1 = (i * N1 + j)*sizeof(matrix[0][0]);

      printf("(%d, %d): expect offsets %zu == %zu\n", i, j, offset0, offset1);
    }
  }
}
