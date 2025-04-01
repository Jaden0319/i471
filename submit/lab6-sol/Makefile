CC = gcc
CFLAGS = -g -Wall

CPP = g++
CPPFLAGS = -g -Wall

C_FILES = $(wildcard *.c)
CPP_FILES = $(wildcard *.cc)

EXES = $(patsubst %.c, %, $(C_FILES)) $(patsubst %.cc, %, $(CPP_FILES))

.PHONY: all
all:	$(EXES)

.PHONY: lifetimes2-test
lifetimes2-test: lifetimes2
		@./lifetimes2 2>&1 | \
		(diff tests/lifetime2.out - \
                 && echo "*** [Lifetime] OK" || echo "*** [Lifetime] ERROR")

.PHONY: struct-layout2-test
struct-layout2-test: struct-layout2
		@./struct-layout2  | \
		(diff tests/struct-layout2.out - \
		&& echo "*** [Struct] OK" || echo "*** [Struct] ERROR")

.PHONY: matrix-offset-indexes-test-test
matrix-offset-indexes-test: matrix-offset-indexes
	@./matrix-offset-indexes 24 48 32 168 22 | \
	  (diff tests/matrix-offset-indexes.out - \
	   && echo "*** [Array] OK" || echo "*** [Array] ERROR")

.PHONY: all-tests
all-tests:	lifetimes2-test struct-layout2-test matrix-offset-indexes-test

.PHONY:	clean
clean:
	rm -f $(EXES) *~
