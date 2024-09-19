EMACS_ROOT_DIR ?= $(shell brew --prefix emacs-plus@30)
EMACS_INCLUDE = "$(EMACS_ROOT_DIR)/include"
EMACS_LIB = "$(EMACS_ROOT_DIR)/lib"


CC = gcc
LD = gcc
CFLAGS = -ggdb3 -Wall
INCLUDE_FLAGS = -I$(EMACS_INCLUDE)
LIB_FLAGS = -L$(EMACS_LIB)

SRC_DIR := src/
OBJ_DIR := objs/
LIB_DIR := libs/

C_SRCS := $(shell find $(SRC_DIR) -type f -name '*.cc')
# OBJS := $(C_SRCS:.cc=.o)
OBJS := $(addprefix $(OBJ_DIR),$(notdir $(C_SRCS:.cc=.o)))
LIBS := $(addprefix $(LIB_DIR),$(notdir $(OBJS:.o=.so)))

$(OBJS): $(C_SRCS)
	-mkdir -p $(@D)
	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -c -fPIC -o $@ $^

$(LIBS): $(OBJS)
	-mkdir -p $(@D)
	$(LD) -shared -o $@ $^

.PHONY: libs clean echo reader
libs: $(LIBS)

render: $(C_SRCS)
	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -E $^

clean:
	-rm -rf $(LIB_DIR)
	-rm $(OBJS)

echo:
	@echo sources: $(C_SRCS)
	@echo objs: $(OBJS)
	@echo libs: $(LIBS)
