# Makefile
CXX = g++
CXXFLAGS = -std=c++17 -Wall -O2
QTFLAGS = `pkg-config --cflags --libs Qt5Widgets`

# dir
SRC_DIR = ./src
INCLUDE_DIR = ./include
BUILD_DIR = ./build
BIN_DIR = ./bin

# target exec
TARGET = $(BIN_DIR)/maze-visualizer

# src and obj files
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS = $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SOURCES))

# include paths
INCLUDES = -I$(INCLUDE_DIR)

# Make maze
maze: $(TARGET)

# build and bin dir
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Build target
$(TARGET): $(BIN_DIR) $(BUILD_DIR) $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(QTFLAGS) $(OBJECTS) -o $@

# Compile src files into obj files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(QTFLAGS) -c $< -o $@

# Clean build
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

# run app
run: maze
	./$(TARGET)

# PHONY targets
.PHONY: maze clean run
