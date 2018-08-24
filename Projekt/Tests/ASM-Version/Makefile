OUTPUT=nthPrimeAssembler

OPTIMIZATION = -O0

### no edits below this line needed ###
CC = gcc
src = $(wildcard testCFileAssembler.c)
asm = $(wildcard wormell.S)

CFLAGS = -g -Wall -Werror -fsanitize=address $(OPTIMIZATION) -Wno-unused-function -Wno-unused-label -Wno-unused-value -Wno-unused-variable -mfpu=neon

all: $(OUTPUT)

$(OUTPUT): $(src) $(asm)
	$(CC) $(CFLAGS) -o $@ $(src) $(asm)

.PHONY:clean
clean:
	rm -f $(OUTPUT)



