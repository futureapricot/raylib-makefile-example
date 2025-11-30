include config.mk

PLATFORM		:= PLATFORM_WEB
CC				:= emcc

#---------------------------------------------------------------------------------------------
BUILD_DIR		:= $(call lc,$(BUILD_DIR)/$(PLATFORM)/$(BUILD_MODE))
OUTPUT_DIR		:= $(call lc,$(OUTPUT_DIR)/$(PLATFORM)/$(BUILD_MODE))

#---------------------------------------------------------------------------------------------
# Specific compiler flags
CFLAGS += -DGRAPHICS_API_OPENGL_ES2
CFLAGS += -flto

ifneq ($(BUILD_MODE),RELEASE)
CFLAGS += --profiling
CFLAGS += -O0 # -Og doesn not work in emcc
endif

CXXFLAGS := $(CFLAGS) #-std=c++23
# CFLAGS	+= -std=gnu23

#---------------------------------------------------------------------------------------------
# Linking flags
LDFLAGS = -lidbfs.js
LDFLAGS += -s 'EXPORTED_RUNTIME_METHODS=["writeArrayToMemory","setValue"]'
LDFLAGS += -sASYNCIFY

#---------------------------------------------------------------------------------------------
# Web target html container
WEB_SHELL := $(SRC_DIR)/shell.html

#---------------------------------------------------------------------------------------------
# Util variables
OBJS	:= $(addprefix $(BUILD_DIR),$(SRC_FILES:$(SRC_DIR)/%=$(OBJ_DIR)/%.o))
#---------------------------------------------------------------------------------------------
# Specific targets

$(PROJECT_NAME): $(OBJS)
	@mkdir -p $(OUTPUT_DIR)
	$(CC) -o $(OUTPUT_DIR)/index.html $(OBJS) $(LDFLAGS) \
		-s USE_GLFW=3 \
		--shell-file $(WEB_SHELL) \
		-s ALLOW_MEMORY_GROWTH=1
#		--preload-file $(LOCAL_ASSETS)@res

$(BUILD_DIR)/%.c.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) -c $< -o $@ -D$(PLATFORM) $(CFLAGS)

$(BUILD_DIR)/%.cpp.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CC) -c $< -o $@ -D$(PLATFORM) $(CXXFLAGS)
