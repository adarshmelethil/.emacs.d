EMACS_ROOT_DIR ?= $(shell brew --prefix emacs-plus@30)
EMACS_INCLUDE = "$(EMACS_ROOT_DIR)/include"
EMACS_LIB = "$(EMACS_ROOT_DIR)/lib"

CC = gcc
LD = gcc
CFLAGS = -ggdb3 -Wall
INCLUDE_FLAGS = -I$(EMACS_INCLUDE)
LIB_FLAGS = -L$(EMACS_LIB)

SRC_DIR := src
LIB_DIR := libs

C_SRCS := $(shell find $(SRC_DIR) -type f -name '*.c')
LIBS := $(addprefix $(LIB_DIR)/,$(notdir $(C_SRCS:.c=.so)))


.PHONY: libs clean echo reader run test
libs: $(LIBS)

render: $(C_SRCS)
	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -E $^

test: libs
	./test_module.el

clean:
	-rm -rf $(LIB_DIR)

echo:
	@echo sources: $(C_SRCS)
	@echo libs: $(LIBS)



$(LIBS): $(C_SRCS)
	-mkdir -p $(@D)
	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -shared  -fPIC -o $@ $^

