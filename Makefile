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

# Analysis configuration
MOVIE = dammit,truncated-aliensoldier.gmv
REFERENCE_DIR = reference
ANALYSIS_WORKERS = 24
ANALYSIS_GRID_COLS = 6
ANALYSIS_FRAMESKIP = 8
ANALYSIS_INTERVAL = 20
ANALYSIS_MAX_FRAMES = 90000
ANALYSIS_MAX_DIFFS = 10
ANALYSIS_DIFF_COLOR = pink

# Generate reference screenshots
.PHONY: reference
reference:
	@echo "Generating reference screenshots..."
	python -c "import os; os.makedirs('$(REFERENCE_DIR)', exist_ok=True)"
	"$(GENS_EXE)" \
		-rom $(ROM) \
		-play $(MOVIE) \
		-screenshot-interval $(ANALYSIS_INTERVAL) \
		-screenshot-dir $(REFERENCE_DIR) \
		-max-frames $(ANALYSIS_MAX_FRAMES) \
		-turbo \
		-frameskip 0 \
		-nosound
	@echo "Reference screenshots saved to $(REFERENCE_DIR)/"

# Analyze procedures for visual impact
.PHONY: analyze
analyze:
	@echo "Analyzing procedures ($(ANALYSIS_WORKERS) workers, frameskip $(ANALYSIS_FRAMESKIP))..."
	python $(SCRIPTS_DIR)/analyze.py \
		--project-dir . \
		--source $(SRC) \
		--rom $(ROM) \
		--workers $(ANALYSIS_WORKERS) \
		--grid-cols $(ANALYSIS_GRID_COLS) \
		--frameskip $(ANALYSIS_FRAMESKIP) \
		--interval $(ANALYSIS_INTERVAL) \
		--max-frames $(ANALYSIS_MAX_FRAMES) \
		--max-diffs $(ANALYSIS_MAX_DIFFS) \
		--diff-color $(ANALYSIS_DIFF_COLOR)

# Generate analysis report
.PHONY: report
report:
	@echo "Generating analysis report..."
	python $(SCRIPTS_DIR)/report.py --project-dir .
	@echo "Report saved to analysis_report.txt"

# Compare built ROM with original
.PHONY: compare
compare:
	@python $(SCRIPTS_DIR)/compare.py \
		--built $(ROM) \
		--original $(ORIG_ROM) \
		--project-dir .

# Prepare next batch of procedures for documentation
.PHONY: prepare-batch
prepare-batch:
	@python $(SCRIPTS_DIR)/prepare_batch.py \
		--database procedure_database.csv \
		--source $(SRC) \
		--batch-size 40 \
		--output batch_extract.txt \
		--project-dir .

# Gens emulator paths
GENS_DIR = gens-rerecording/Gens-rr
GENS_SLN = $(GENS_DIR)/gens_vc10.sln
GENS_EXE = $(GENS_DIR)/Output/Gens.exe
MSBUILD = C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Current/Bin/MSBuild.exe

# Stop all running emulators and analysis
.PHONY: stop
stop:
	@echo "Stopping analysis and emulators..."
	-taskkill /F /IM Gens.exe 2>nul
	-taskkill /F /IM python.exe 2>nul
	@echo "Done"

# Build Gens emulator
.PHONY: build-gens
build-gens:
	@echo "Building Gens emulator..."
	"$(MSBUILD)" "$(GENS_SLN)" -p:Configuration=Release -p:Platform=Win32 -p:PlatformToolset=v143 -t:Build -v:minimal
	@echo "Build complete: $(GENS_EXE)"

# Help
.PHONY: help
help:
	@echo "Alien Soldier (J) Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  make build         - Assemble and build ROM (default)"
	@echo "  make compare       - Compare built ROM with original"
	@echo "  make prepare-batch - Extract next 40 procedures for documentation"
	@echo "  make split         - Extract data from original ROM"
	@echo "  make clean         - Remove build artifacts"
	@echo "  make distclean     - Remove build artifacts and extracted data"
	@echo "  make reference     - Generate reference screenshots for analysis"
	@echo "  make analyze       - Analyze procedures for visual impact"
	@echo "  make report        - Generate analysis report from diffs"
	@echo "  make stop          - Stop all running Gens emulators"
	@echo "  make build-gens    - Build Gens emulator (requires VS2022)"
	@echo "  make help          - Show this help message"
	@echo ""
	@echo "Build configuration:"
	@echo "  Source:     $(SRC)"
	@echo "  Output ROM: $(ROM)"
	@echo "  Assembler:  $(AS_BIN)"
	@echo ""
	@echo "Analysis configuration:"
	@echo "  Workers:    $(ANALYSIS_WORKERS)"
	@echo "  Grid cols:  $(ANALYSIS_GRID_COLS)"
	@echo "  Frameskip:  $(ANALYSIS_FRAMESKIP)"
	@echo "  Interval:   $(ANALYSIS_INTERVAL)"
	@echo "  Max frames: $(ANALYSIS_MAX_FRAMES)"
	@echo "  Max diffs:  $(ANALYSIS_MAX_DIFFS)"
	@echo "  Diff color: $(ANALYSIS_DIFF_COLOR)"
