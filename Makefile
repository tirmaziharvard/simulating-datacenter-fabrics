VPATH=src/:include/

CC=gcc
INCLUDE=include/
CFLAGS=-I $(INCLUDE) -Wall -Werror
LIB=-lm
CC_CMD=$(CC) $(CFLAGS)

# Note: apparently, linked library files should go *after* source files

OBJ_DIR=obj
BIN_DIR=bin
DEP_DIR=deps

SRCS=$(wildcard *.c)
DEPS=$(srcs:.c=.d)

all: dir_tgt simulation

simulation: flow.o arrival.o simulation.o
	$(CC_CMD) $(^:%.o=$(OBJ_DIR)/%.o) -o $(BIN_DIR)/$@ $(LIB)

run: simulation
	$(BIN_DIR)/simulation

.PHONY: clean obj_dir_tgt bin_dir_tgt dep_dir_tgt

%.o : %.c
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $(OBJ_DIR)/$@

MKDIR_P=mkdir -p

dir_tgt: obj_dir_tgt bin_dir_tgt dep_dir_tgt

obj_dir_tgt:
	$(MKDIR_P) $(OBJ_DIR)

bin_dir_tgt:
	$(MKDIR_P) $(BIN_DIR)

dep_dir_tgt:
	$(MKDIR_P) $(DEP_DIR)

clean:
	rm -rf $(BIN_DIR)
	rm -rf $(OBJ_DIR)
	rm -rf $(DEP_DIR)

-include $(DEPS)