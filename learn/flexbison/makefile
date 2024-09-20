FLEX_DIR := /opt/homebrew/opt/flex
BISON_DIR := /opt/homebrew/opt/bison

FLEX = $(FLEX_DIR)/bin/flex
BISON = $(BISON_DIR)/bin/bison
CC = gcc
LD = gcc
# CFLAGS = -ggdb3 -Wall
INCLUDE_FLAGS = -I$(FLEX_DIR)/include
LIB_FLAGS = -L$(FLEX_DIR)/lib -L$(BISON_DIR)/lib

.PHONY: all clean run wc-c calc-c wc calc
all: wc.out calc.out

wc: wc.out
	./$< < wc-input.txt

calc: calc.out
	./$< < calc-input.txt

calc.out: calc.tab.c calc.yy.c
	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) $(LIB_FLAGS) -o $@ calc.tab.c calc.yy.c

wc-c: wc.yy.c
calc-c: calc.yy.c

%.yy.c: %.l
	$(FLEX) -o $@ $^

%.tab.c: %.y
	$(BISON) -d $^

%.out: %.yy.c
	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) $(LIB_FLAGS) -lfl -o $@ $^

clean:
	-rm *.yy.c
	-rm *.tab.c
	-rm *.tab.h
	-rm *.out
	-rm -rf *.out.dSYM
