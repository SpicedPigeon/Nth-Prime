OUTPUT=nthPrimeC

OPTIMIZATION = -O3

### no edits below this line needed ###
CC = gcc
src = $(wildcard allInCImplemented.c)

CFLAGS = -g -Wall -Werror -fsanitize=address $(OPTIMIZATION) -Wno-unused-function -Wno-unused-label -Wno-unused-value -Wno-unused-variable -mfpu=neon

all: $(OUTPUT)

$(OUTPUT): $(src) $(asm)
	$(CC) $(CFLAGS) -o $@ $(src)

.PHONY:clean
clean:
	rm -f $(OUTPUT)



