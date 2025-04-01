#include <stdio.h>
#include <stddef.h>


typedef struct {
  char c;
  void *p;
  short s;
  int i;
} S1;


typedef struct {
  int i;  
  short s;
  void *p;
  char c;    
  
} S2;

typedef struct {
  char c;
  short s;
  int i;
  void *p;
} S3;

//Do not change code below

void out_s1_layout(FILE *out) {
  fprintf(out, "S1: size = %zu\n", sizeof(S1));
  fprintf(out, "  c: %zu\n", offsetof(S1, c));
  fprintf(out, "  p: %zu\n", offsetof(S1, p));
  fprintf(out, "  s: %zu\n", offsetof(S1, s));
  fprintf(out, "  i: %zu\n", offsetof(S1, i));
}

void out_s2_layout(FILE *out) {
  fprintf(out, "S2: size = %zu\n", sizeof(S2));
  fprintf(out, "  c: %zu\n", offsetof(S2, c));
  fprintf(out, "  p: %zu\n", offsetof(S2, p));
  fprintf(out, "  s: %zu\n", offsetof(S2, s));
  fprintf(out, "  i: %zu\n", offsetof(S2, i));
}

void out_s3_layout(FILE *out) {
  fprintf(out, "S3: size = %zu\n", sizeof(S3));
  fprintf(out, "  c: %zu\n", offsetof(S3, c));
  fprintf(out, "  p: %zu\n", offsetof(S3, p));
  fprintf(out, "  s: %zu\n", offsetof(S3, s));
  fprintf(out, "  i: %zu\n", offsetof(S3, i));
}

int main() {
  FILE *out = stdout;
  out_s1_layout(out);
  out_s2_layout(out);
  out_s3_layout(out);
}
