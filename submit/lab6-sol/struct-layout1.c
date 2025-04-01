#include <stdio.h>
#include <stddef.h>


typedef struct {
  char c;
  void *p;
  short s;
  int i;
} S1;



void out_s1_layout(FILE *out) {
  fprintf(out, "S1: size = %zu\n", sizeof(S1));
  fprintf(out, "  c: %zu\n", offsetof(S1, c));
  fprintf(out, "  p: %zu\n", offsetof(S1, p));
  fprintf(out, "  s: %zu\n", offsetof(S1, s));
  fprintf(out, "  i: %zu\n", offsetof(S1, i));
}


int main() {
  FILE *out = stdout;
  out_s1_layout(out);
}
