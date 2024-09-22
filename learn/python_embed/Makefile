PYTHON_ROOT := $(shell brew --prefix python@3.12)
PYTHON_FRAMEWORK := $(PYTHON_ROOT)/Frameworks/Python.framework
PYTHON_INCLUDE = "$(PYTHON_FRAMEWORK)/Versions/Current/Headers/"

CC = gcc
LD = gcc
CFLAGS = -ggdb3 -Wall
INCLUDE_FLAGS = -I$(PYTHON_INCLUDE)
LIB_FLAGS = -F $(dir $(PYTHON_FRAMEWORK)) -framework Python

BUILD = $(CC) $(CFLAGS) $(INCLUDE_FLAGS) $(LIB_FLAGS)

SRC_DIR := src
BIN_DIR := bin

C_SRCS := $(shell find $(SRC_DIR) -type f -name '*.c')


$(BIN_DIR)/%: $(SRC_DIR)/%.c
	-mkdir -p $(@D)
	$(BUILD) -o $@ $^



.PHONY: bin libs clean echo reader
.PHONY: simple run_simple
.PHONY: func run_func

libs: $(LIBS)

simple: $(BIN_DIR)/simple
run_simple: simple
	$(BIN_DIR)/simple

func: $(BIN_DIR)/run_func
run_func: func
	$(BIN_DIR)/run_func mymod multiply 3 2


clean:
	-rm -rf $(BIN_DIR)

echo:
	@echo $(PYTHON_ROOT)
	@echo $(BUILD)


# render:
# 	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -E $^

# simple.o:  src/simple.c
# 	$(CC) $(shell python3-config --cflags) -c -o simple.o src/simple.c
# simple.out: simple.o
# 	$(CC) $(shell python3-config --ldflags --embed) -o simple.out simple.o
