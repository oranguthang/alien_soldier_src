# Alien Soldier (J) Makefile
# Build configuration for AS assembler

# Tools
AS_BIN = bin/asw.exe
P2BIN = bin/p2bin.exe
AS_ARGS = -maxerrors 2

# Files
SRC = alien_soldier_j.s
OBJ = alien_soldier_j.p
ROM = asbuilt.bin
ORIG_ROM = alien_soldier_j.bin

# Directories
DATA_DIR = data
SRC_DIR = src
SCRIPTS_DIR = scripts
BIN_DIR = bin

# Tile addresses file
TILES_ADDRS = $(DATA_DIR)/tiles_addrs.txt

# Default target
.PHONY: all
all: build

# Build ROM from assembly source
.PHONY: build
build:
	@echo "Building ROM..."
	python $(SCRIPTS_DIR)/build.py \
		--source $(SRC) \
		--output $(ROM) \
		--as-bin $(AS_BIN) \
		--p2bin $(P2BIN) \
		--as-args "$(AS_ARGS)"
	@echo ""
	@echo "Build complete: $(ROM)"

# Split original ROM into data files
.PHONY: split
split:
	@echo "Splitting ROM data..."
	@python $(SCRIPTS_DIR)/split.py \
		--rom-file $(ORIG_ROM) \
		--output $(DATA_DIR) \
		--addrs $(TILES_ADDRS)
	@echo ""
	@echo "Split complete!"

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	@python $(SCRIPTS_DIR)/clean.py -q $(OBJ) $(ROM)
	@echo "Clean complete!"

# Deep clean (removes extracted data too)
.PHONY: distclean
distclean: clean
	@echo "Removing extracted data..."
	@python $(SCRIPTS_DIR)/clean.py -q "$(DATA_DIR)/tiles_*.bin"
	@echo "Deep clean complete!"

# Analyze procedures for visual impact
.PHONY: analyze
analyze:
	@echo "Analyzing procedures..."
	python $(SCRIPTS_DIR)/analyze.py \
		--project-dir . \
		--source $(SRC) \
		--rom $(ROM)

# Gens emulator paths
GENS_DIR = gens-rerecording/Gens-rr
GENS_SLN = $(GENS_DIR)/gens_vc10.sln
GENS_EXE = $(GENS_DIR)/Output/Gens.exe
MSBUILD = C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Current/Bin/MSBuild.exe

# Build Gens emulator
.PHONY: build-gens
build-gens:
	@echo "Building Gens emulator..."
	@if [ ! -f "$(MSBUILD)" ]; then \
		echo "Error: Visual Studio 2022 not found at $(MSBUILD)"; \
		echo "Please install Visual Studio 2022 with C++ development tools"; \
		exit 1; \
	fi
	@if [ ! -f "$(GENS_SLN)" ]; then \
		echo "Error: Gens solution not found at $(GENS_SLN)"; \
		echo "Please clone the gens-rerecording repository into $(GENS_DIR)"; \
		exit 1; \
	fi
	"$(MSBUILD)" "$(GENS_SLN)" -p:Configuration=Release -p:Platform=Win32 -p:PlatformToolset=v143 -t:Build -v:minimal
	@echo ""
	@echo "Build complete: $(GENS_EXE)"

# Help
.PHONY: help
help:
	@echo "Alien Soldier (J) Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  make build      - Assemble and build ROM (default)"
	@echo "  make split      - Extract data from original ROM"
	@echo "  make clean      - Remove build artifacts"
	@echo "  make distclean  - Remove build artifacts and extracted data"
	@echo "  make analyze    - Analyze procedures for visual impact"
	@echo "  make build-gens - Build Gens emulator (requires VS2022)"
	@echo "  make help       - Show this help message"
	@echo ""
	@echo "Configuration:"
	@echo "  Source:     $(SRC)"
	@echo "  Output ROM: $(ROM)"
	@echo "  Assembler:  $(AS_BIN)"
	@echo "  AS args:    $(AS_ARGS)"
