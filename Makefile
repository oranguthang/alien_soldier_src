# Alien Soldier (J) Makefile
# Build configuration for AS assembler

# Toolchain selection: auto-detect host OS/arch and pick the matching
# build-tools folder under bin/. Override with: make PLATFORM=<subfolder>
ifeq ($(OS),Windows_NT)
    PLATFORM ?= windows_i386
    AS_EXE = asw.exe
    P2BIN_EXE = p2bin.exe
else
    UNAME_S := $(shell uname -s)
    UNAME_M := $(shell uname -m)
    ifeq ($(UNAME_S),Darwin)
        PLATFORM ?= macos_$(UNAME_M)
    else
        PLATFORM ?= linux_$(UNAME_M)
    endif
    AS_EXE = asl
    P2BIN_EXE = p2bin
endif

TOOLS_DIR = bin/$(PLATFORM)

# Tools
AS_BIN = $(TOOLS_DIR)/$(AS_EXE)
P2BIN = $(TOOLS_DIR)/$(P2BIN_EXE)
AS_ARGS = -maxerrors 2

# Set message path for AS assembler (needed for as.msg, cmdarg.msg, etc.)
export AS_MSGPATH = $(TOOLS_DIR)

# Files
SRC = alien_soldier_j.s
OBJ = alien_soldier_j.p
ROM = asbuilt.bin
ORIG_ROM = Alien Soldier (J) [!].bin
REF_ROM = alien_soldier_j.bin

# Directories
DATA_DIR = data
SRC_DIR = src
SCRIPTS_DIR = scripts
BIN_DIR = bin

# Data addresses file (for binclude segments)
DATA_ADDRS = $(DATA_DIR)/data_addrs.txt

# Default target
.PHONY: all
all: build

# Initialize project from original ROM
# Usage: make init
.PHONY: init
init:
	@python $(SCRIPTS_DIR)/init_project.py \
		--orig-rom "$(ORIG_ROM)" \
		--ref-rom "$(REF_ROM)" \
		--data-dir $(DATA_DIR) \
		--data-addrs $(DATA_ADDRS) \
		--source $(SRC) \
		--output $(ROM) \
		--as-bin $(AS_BIN) \
		--p2bin $(P2BIN) \
		--as-args "$(AS_ARGS)"

# Check if project is initialized (data/ directory with subfolders exists)
# If missing, print a friendly hint instead of cryptic "error in opening file"
.PHONY: check-init
check-init:
	@python $(SCRIPTS_DIR)/check_init.py \
		--data-dir "$(DATA_DIR)" \
		--orig-rom "$(ORIG_ROM)"

# Build ROM from assembly source
.PHONY: build
build: check-init
	@echo "Building ROM..."
	python $(SCRIPTS_DIR)/build_rom.py \
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
	@python $(SCRIPTS_DIR)/split_data_from_rom.py \
		--rom-file "$(ORIG_ROM)" \
		--output $(DATA_DIR) \
		--addrs $(DATA_ADDRS)

# Unpack LZSS-compressed data from ROM to data/uncompressed/
# Attempts to decompress all entries from data/data_addrs.txt
# Decompress LZSS data in all data subdirectories
# Creates uncompressed/ subfolder where decompression succeeds
.PHONY: unpack-data
unpack-data:
	@python $(SCRIPTS_DIR)/unpack_data.py --data-dir $(DATA_DIR)

# Clean build artifacts and temp files
.PHONY: clean
clean:
	@python $(SCRIPTS_DIR)/clean_project.py

# Analysis configuration
# Workflow directory (for reports, procedure lists, etc.)
WORKFLOW_DIR = workflow

# Movie files for each analysis type
MOVIE_FILE_tas = movies/dammit,truncated-aliensoldier.gmv
MOVIE_FILE_longplay = movies/alien_soldier_j_longplay.gmv
MOVIE_FILE_menus = movies/alien_soldier_j_menus.gmv

# Max frames per movie type (0 = play until end)
MAX_FRAMES_tas = 90000
MAX_FRAMES_longplay = 0
MAX_FRAMES_menus = 0
ANALYSIS_WORKERS = 24
ANALYSIS_GRID_COLS = 6
ANALYSIS_FRAMESKIP = 8
ANALYSIS_INTERVAL = 20
ANALYSIS_MAX_FRAMES = 90000
ANALYSIS_MAX_DIFFS = 10
ANALYSIS_DIFF_COLOR = pink
PROCEDURES_FILE = $(WORKFLOW_DIR)/unanalyzed_procedures.txt

# Generate reference screenshots + memory dumps
# Usage: make reference MOVIE=tas|longplay|menus
.PHONY: reference
reference:
ifndef MOVIE
	@echo "ERROR: MOVIE parameter required!"
	@echo ""
	@echo "Usage: make reference MOVIE=<type>"
	@echo ""
	@echo "Examples:"
	@echo "  make reference MOVIE=tas      - TAS speedrun reference"
	@echo "  make reference MOVIE=longplay - Longplay reference"
	@echo "  make reference MOVIE=menus    - Menu exploration reference"
	@exit 1
else
	@echo "Generating reference screenshots and memory dumps from $(MOVIE)..."
	python -c "import os; os.makedirs('reference/$(MOVIE)', exist_ok=True)"
	"$(GENS_EXE)" \
		-rom $(ROM) \
		-play $(MOVIE_FILE_$(MOVIE)) \
		-screenshot-interval $(ANALYSIS_INTERVAL) \
		-screenshot-dir reference/$(MOVIE) \
		$(if $(MAX_FRAMES_$(MOVIE)),-max-frames $(MAX_FRAMES_$(MOVIE)),) \
		-save-state-dumps \
		-turbo \
		-frameskip 0 \
		-nosound
	@echo "Reference saved to reference/$(MOVIE)/"
endif

# Analyze procedures for visual/memory impact
# Usage: make analyze MOVIE=tas|longplay|menus
.PHONY: analyze
analyze:
ifndef MOVIE
	@echo "ERROR: MOVIE parameter required!"
	@echo ""
	@echo "Usage: make analyze MOVIE=<type>"
	@echo ""
	@echo "Examples:"
	@echo "  make analyze MOVIE=tas      - Analyze with TAS speedrun"
	@echo "  make analyze MOVIE=longplay - Analyze with longplay"
	@echo "  make analyze MOVIE=menus    - Analyze with menu exploration"
	@exit 1
else
	@echo "Analyzing procedures with $(MOVIE) ($(ANALYSIS_WORKERS) workers)..."
	python $(SCRIPTS_DIR)/analyze_procedures.py \
		--project-dir . \
		--source $(SRC) \
		--rom $(ROM) \
		--movie $(MOVIE_FILE_$(MOVIE)) \
		--reference reference/$(MOVIE) \
		--diffs diffs/$(MOVIE) \
		--procedures-file $(PROCEDURES_FILE) \
		--workers $(ANALYSIS_WORKERS) \
		--grid-cols $(ANALYSIS_GRID_COLS) \
		--frameskip $(ANALYSIS_FRAMESKIP) \
		--interval $(ANALYSIS_INTERVAL) \
		$(if $(MAX_FRAMES_$(MOVIE)),--max-frames $(MAX_FRAMES_$(MOVIE)),) \
		--max-diffs $(ANALYSIS_MAX_DIFFS) \
		--diff-color $(ANALYSIS_DIFF_COLOR)
endif

# Find which procedures are not yet analyzed and save to file
.PHONY: find-unanalyzed
find-unanalyzed:
	@echo "Finding unanalyzed procedures..."
	@python -c "import os; os.makedirs('$(WORKFLOW_DIR)', exist_ok=True)"
	@python $(SCRIPTS_DIR)/find_unnamed_procedures.py \
		--list \
		--exclude-analyzed analysis_results.csv \
		--output $(PROCEDURES_FILE)
	@echo "Saved to $(PROCEDURES_FILE)"

# Generate analysis report
# Usage: make report MOVIE=tas|longplay|menus
.PHONY: report
report:
ifndef MOVIE
	@echo "ERROR: MOVIE parameter required!"
	@echo ""
	@echo "Usage: make report MOVIE=<type>"
	@echo ""
	@echo "Examples:"
	@echo "  make report MOVIE=tas      - Generate TAS report"
	@echo "  make report MOVIE=longplay - Generate longplay report"
	@echo "  make report MOVIE=menus    - Generate menus report"
	@exit 1
else
	@echo "Generating $(MOVIE) analysis report..."
	@python -c "import os; os.makedirs('$(WORKFLOW_DIR)', exist_ok=True)"
	python $(SCRIPTS_DIR)/generate_analysis_report.py --project-dir . --movie $(MOVIE) --output-dir $(WORKFLOW_DIR)
	@echo "Report saved: $(WORKFLOW_DIR)/analysis_report_$(MOVIE).txt / .csv"
endif

# Compare built ROM with reference
.PHONY: compare
compare:
	@python $(SCRIPTS_DIR)/compare_roms.py \
		--built $(ROM) \
		--original $(REF_ROM) \
		--project-dir .

# ============================================================================
# DOCUMENTATION WORKFLOW
# ============================================================================
# 1. make set-movie MOVIE=tas     - Set current movie type for workflow
# 2. make prepare-batch COUNT=40  - Prepare batch of procedures to document
# 3. [Claude creates workflow/rename_batch.csv with new names]
# 4. make rename                  - Apply renames and mark as processed
# ============================================================================

# Set movie type for documentation workflow
# Usage: make set-movie MOVIE=tas|longplay|menus
.PHONY: set-movie
set-movie:
ifndef MOVIE
	@echo "ERROR: MOVIE parameter required!"
	@echo ""
	@echo "Usage: make set-movie MOVIE=<type>"
	@echo ""
	@echo "Examples:"
	@echo "  make set-movie MOVIE=tas"
	@exit 1
else
	@python -c "import os; os.makedirs('$(WORKFLOW_DIR)', exist_ok=True)"
	@echo $(MOVIE) > $(WORKFLOW_DIR)/.movie
	@echo "Movie type set to: $(MOVIE)"
	@echo "Saved to $(WORKFLOW_DIR)/.movie"
endif

# Show current movie setting
.PHONY: show-movie
show-movie:
	@if [ -f $(WORKFLOW_DIR)/.movie ]; then \
		echo "Current movie: $$(cat $(WORKFLOW_DIR)/.movie)"; \
	else \
		echo "No movie set. Use: make set-movie MOVIE=tas"; \
	fi

# Prepare batch of procedures for documentation
# Usage: make prepare-batch COUNT=40
BATCH_COUNT ?= 40
.PHONY: prepare-batch
prepare-batch:
	@if [ ! -f $(WORKFLOW_DIR)/.movie ]; then \
		echo "ERROR: No movie set!"; \
		echo "First run: make set-movie MOVIE=tas"; \
		exit 1; \
	fi
	@echo "Preparing batch of $(BATCH_COUNT) procedures..."
	python $(SCRIPTS_DIR)/prepare_batch.py \
		--report $(WORKFLOW_DIR)/analysis_report_$$(cat $(WORKFLOW_DIR)/.movie).csv \
		--count $(BATCH_COUNT) \
		--output $(WORKFLOW_DIR)/batch_procedures.txt \
		--source $(SRC)
	@echo ""
	@echo "Batch prepared: $(WORKFLOW_DIR)/batch_procedures.txt"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Claude reads $(WORKFLOW_DIR)/batch_procedures.txt"
	@echo "  2. Claude creates $(WORKFLOW_DIR)/rename_batch.csv with columns:"
	@echo "     old_name,new_name,description"
	@echo "  3. Run: make rename"

# Apply renames from rename_batch.csv and mark as processed
.PHONY: rename
rename:
	@if [ ! -f $(WORKFLOW_DIR)/.movie ]; then \
		echo "ERROR: No movie set!"; \
		exit 1; \
	fi
	@if [ ! -f $(WORKFLOW_DIR)/rename_batch.csv ]; then \
		echo "ERROR: $(WORKFLOW_DIR)/rename_batch.csv not found!"; \
		echo "Create it with columns: old_name,new_name,description"; \
		exit 1; \
	fi
	@echo "Applying renames from $(WORKFLOW_DIR)/rename_batch.csv..."
	python $(SCRIPTS_DIR)/rename_procedures.py \
		--source $(SRC) \
		--database $(WORKFLOW_DIR)/rename_batch.csv \
		--report $(WORKFLOW_DIR)/analysis_report_$$(cat $(WORKFLOW_DIR)/.movie).csv
	@echo ""
	@echo "Renames applied! Next steps:"
	@echo "  1. Review changes: git diff $(SRC)"
	@echo "  2. Build and test: make build"
	@echo "  3. Commit: git add $(SRC) && git commit"

# Gens emulator paths
GENS_DIR = gens_automation
GENS_EXE = $(GENS_DIR)/Output/Gens.exe
GENS_REPO = https://github.com/oranguthang/gens_automation.git

# Debug: Build ROM and run with screenshot + memory comparison
# Stops after N visual differences (memory diffs won't end the run)
# Usage: make debug MOVIE=tas|longplay|menus
.PHONY: debug
debug: build
ifndef MOVIE
	@echo "ERROR: MOVIE parameter required!"
	@echo ""
	@echo "Usage: make debug MOVIE=<type>"
	@echo ""
	@echo "Examples:"
	@echo "  make debug MOVIE=tas"
	@exit 1
else
	@echo "Running $(MOVIE) with visual comparison (debug mode)..."
	python -c "import os; os.makedirs('diffs/$(MOVIE)', exist_ok=True); os.makedirs('reports', exist_ok=True)"
	"$(GENS_EXE)" \
		-rom $(ROM) \
		-play $(MOVIE_FILE_$(MOVIE)) \
		-screenshot-interval $(ANALYSIS_INTERVAL) \
		-screenshot-dir diffs/$(MOVIE) \
		-reference-dir reference/$(MOVIE) \
		$(if $(MAX_FRAMES_$(MOVIE)),-max-frames $(MAX_FRAMES_$(MOVIE)),) \
		-max-diffs 10 \
		-max-memory-diffs 0 \
		-compare-state-dumps \
		-turbo \
		-frameskip 0 \
		-nosound
	@echo ""
	@echo "Emulator run complete. Generating comparison report..."
	@python $(SCRIPTS_DIR)/compare_states.py \
		--diffs-dir diffs/$(MOVIE) \
		--reference-dir reference/$(MOVIE) \
		--output-dir reports
	@echo ""
	@echo "Debug complete! Check:"
	@echo "  - diffs/$(MOVIE)/*.genstate - Memory dumps for diff frames"
	@echo "  - diffs/$(MOVIE)/*.png - Screenshots for diff frames"
	@echo "  - reports/diff_frame_*.md - Detailed LLM-friendly analysis report"
endif

# Stop all running emulators and analysis
.PHONY: stop
stop:
	@echo "Stopping analysis and emulators..."
	-taskkill /F /IM Gens.exe 2>nul
	-taskkill /F /IM python.exe 2>nul
	@echo "Done"

# Build Gens emulator (clone if not present)
.PHONY: build-gens
build-gens:
	@python -c "import os, subprocess; os.path.isdir('$(GENS_DIR)') or (print('Cloning gens_automation...'), subprocess.run(['git', 'clone', '$(GENS_REPO)', '$(GENS_DIR)']))"
	@echo "Building Gens emulator..."
	$(MAKE) -C $(GENS_DIR)
	@echo "Build complete: $(GENS_EXE)"

# Debug pointer issues by testing data blocks from END of ROM
# Usage: make debug-pointers MOVIE=tas|longplay|menus [START=1BD000] [END=100000]
.PHONY: debug-pointers
debug-pointers:
ifndef MOVIE
	@echo "ERROR: MOVIE parameter required!"
	@echo ""
	@echo "Usage: make debug-pointers MOVIE=<type> [START=<hex>] [END=<hex>]"
	@echo ""
	@echo "Examples:"
	@echo "  make debug-pointers MOVIE=tas"
	@echo "  make debug-pointers MOVIE=tas START=1BD000 END=100000"
	@exit 1
else
	@echo "Debugging pointers with $(MOVIE) movie ($(ANALYSIS_WORKERS) workers)..."
	@echo "Results will be saved to: diffs/$(MOVIE)/pointers/"
	python $(SCRIPTS_DIR)/debug_pointers.py \
		--project-dir . \
		--source $(SRC) \
		--rom $(ROM) \
		--movie $(MOVIE_FILE_$(MOVIE)) \
		--gens-exe $(GENS_EXE) \
		--reference reference/$(MOVIE) \
		--diffs diffs/$(MOVIE) \
		--workers $(ANALYSIS_WORKERS) \
		--grid-cols $(ANALYSIS_GRID_COLS) \
		--interval $(ANALYSIS_INTERVAL) \
		--frameskip $(ANALYSIS_FRAMESKIP) \
		--diff-color $(ANALYSIS_DIFF_COLOR) \
		$(if $(MAX_FRAMES_$(MOVIE)),--max-frames $(MAX_FRAMES_$(MOVIE)),) \
		$(if $(START),--start-address $(START),) \
		$(if $(END),--end-address $(END),)
endif

# Analyze pointer debug results and generate report
report-pointers:
ifndef MOVIE
	@echo "ERROR: MOVIE parameter required!"
	@echo ""
	@echo "Usage: make report-pointers MOVIE=<type>"
	@echo ""
	@echo "Examples:"
	@echo "  make report-pointers MOVIE=tas"
	@exit 1
else
	python $(SCRIPTS_DIR)/report_pointers.py --diffs-dir diffs/$(MOVIE)
endif

# Trace CPU execution after breakpoint
# Usage: make trace MOVIE=tas BP=0xNNNN [FRAMES=20] [LOG=trace.log]
# Example: make trace MOVIE=tas BP=0x11594 FRAMES=20 LOG=logs/trace_Boss.log
.PHONY: trace
trace:
ifndef MOVIE
	@echo "ERROR: MOVIE parameter required!"
	@echo ""
	@echo "Usage: make trace MOVIE=<type> BP=<hex_addr> [FRAMES=<n>] [LOG=<path>]"
	@echo ""
	@echo "Parameters:"
	@echo "  MOVIE   - Movie type: tas, longplay, or menus"
	@echo "  BP      - Breakpoint PC address in hex (e.g., 0x11594 or 11594)"
	@echo "  FRAMES  - Number of frames to trace after breakpoint (default: 20)"
	@echo "  LOG     - Path to trace log file (default: trace_<BP>.csv)"
	@echo ""
	@echo "Examples:"
	@echo "  make trace MOVIE=tas BP=0x11594"
	@echo "  make trace MOVIE=tas BP=0x11594 FRAMES=50 LOG=logs/boss_trace.csv"
	@exit 1
else ifndef BP
	@echo "ERROR: BP (breakpoint) parameter required!"
	@echo ""
	@echo "Usage: make trace MOVIE=<type> BP=<hex_addr>"
	@exit 1
else
	@echo "Tracing from breakpoint $(BP) for $(if $(FRAMES),$(FRAMES),20) frames..."
	@if not exist logs mkdir logs
	$(GENS_EXE) -rom $(ROM) -play $(MOVIE_FILE_$(MOVIE)) -turbo -nosound \
		-trace-breakpoint $(BP) \
		-trace-frames $(if $(FRAMES),$(FRAMES),20) \
		-trace-log $(if $(LOG),$(LOG),logs/trace_$(BP).csv)
endif

# Binary trace CPU execution by frame range
# Usage: make trace-frames MOVIE=<type> START=<frame> END=<frame> [LOG=<path>]
# Example: make trace-frames MOVIE=tas START=10300 END=10320 LOG=logs/bug.btrc
#
# Output: Compact binary trace file (~10-50x smaller than text)
# Post-process with:
#   make trace-story LOG=logs/bug.btrc    - Human-readable story
#   make trace-graph LOG=logs/bug.btrc    - Graphviz pointer/DMA visualization
.PHONY: trace-frames
trace-frames:
ifndef MOVIE
	@echo "ERROR: MOVIE parameter required!"
	@echo ""
	@echo "Usage: make trace-frames MOVIE=<type> START=<frame> END=<frame> [LOG=<path>]"
	@echo ""
	@echo "Parameters:"
	@echo "  MOVIE   - Movie type: tas, longplay, or menus"
	@echo "  START   - Start tracing at this frame"
	@echo "  END     - Stop tracing at this frame"
	@echo "  LOG     - Path to binary trace file (default: logs/trace_<START>_<END>.btrc)"
	@echo ""
	@echo "Examples:"
	@echo "  make trace-frames MOVIE=tas START=10300 END=10320"
	@echo "  make trace-frames MOVIE=tas START=10300 END=10320 LOG=logs/flying_neo.btrc"
	@echo ""
	@echo "Post-processing:"
	@echo "  make trace-story LOG=logs/trace_10300_10320.btrc"
	@echo "  make trace-graph LOG=logs/trace_10300_10320.btrc MODE=pointers"
	@echo "  make trace-graph LOG=logs/trace_10300_10320.btrc MODE=dma"
	@exit 1
else ifndef START
	@echo "ERROR: START parameter required!"
	@exit 1
else ifndef END
	@echo "ERROR: END parameter required!"
	@exit 1
else
	@echo "Binary tracing frames $(START) to $(END)..."
	@python -c "import os; os.makedirs('logs', exist_ok=True)"
	"$(GENS_EXE)" -rom $(ROM) -play $(MOVIE_FILE_$(MOVIE)) -turbo -nosound -frameskip 0 -bintrace $(if $(LOG),$(LOG),logs/trace_$(START)_$(END).btrc) -bintrace-start $(START) -bintrace-end $(END)
	@echo ""
	@echo "Binary trace saved to: $(if $(LOG),$(LOG),logs/trace_$(START)_$(END).btrc)"
	@echo ""
	@echo "Next steps:"
	@echo "  make trace-story LOG=$(if $(LOG),$(LOG),logs/trace_$(START)_$(END).btrc)"
	@echo "  make trace-graph LOG=$(if $(LOG),$(LOG),logs/trace_$(START)_$(END).btrc) MODE=pointers"
endif

# Default symbol file
SYMBOLS_FILE = logs/symbols.txt

# Generate symbol file from assembly listing
# Usage: make symbols [SYMBOLS=<output.txt>] [--all|--include-loc|--include-generic]
.PHONY: symbols
symbols: alien_soldier_j.lst
	@python -c "import os; os.makedirs('logs', exist_ok=True)"
	@echo "Extracting symbols from alien_soldier_j.lst..."
	python $(SCRIPTS_DIR)/extract_symbols.py alien_soldier_j.lst \
		--stats --rom-only -o $(if $(SYMBOLS),$(SYMBOLS),$(SYMBOLS_FILE))

# Generate listing file (prerequisite for symbols)
alien_soldier_j.lst: alien_soldier_j.s src/macros.inc src/ports.inc src/equals.inc src/ram_addrs.inc
	@echo "Building listing file..."
	$(AS_BIN) -L $(AS_ARGS) alien_soldier_j.s

# Generate human-readable story log from binary trace
# Usage: make trace-story LOG=<path.btrc> [OUT=<path.txt>] [SYMBOLS=<path.txt>]
.PHONY: trace-story
trace-story:
ifndef LOG
	@echo "ERROR: LOG parameter required!"
	@echo ""
	@echo "Usage: make trace-story LOG=<trace.btrc> [OUT=<story.txt>] [SYMBOLS=<file.txt>]"
	@echo ""
	@echo "Examples:"
	@echo "  make trace-story LOG=logs/trace_10300_10320.btrc"
	@echo "  make trace-story LOG=logs/trace.btrc OUT=logs/story.txt"
	@echo "  make trace-story LOG=logs/trace.btrc SYMBOLS=logs/symbols.txt"
	@echo ""
	@echo "Tip: Run 'make symbols' first to generate symbol file"
	@exit 1
else
	@echo "Generating story log from $(LOG)..."
	python $(SCRIPTS_DIR)/bintrace_parser.py $(LOG) \
		--story $(if $(OUT),$(OUT),$(LOG:.btrc=_story.txt)) \
		$(if $(SYMBOLS),--symbols $(SYMBOLS),$(if $(wildcard $(SYMBOLS_FILE)),--symbols $(SYMBOLS_FILE),))
endif

# Generate Graphviz visualizations from binary trace (all modes)
# Usage: make trace-graph LOG=<path.btrc>
.PHONY: trace-graph
trace-graph:
ifndef LOG
	@echo "ERROR: LOG parameter required!"
	@echo ""
	@echo "Usage: make trace-graph LOG=<trace.btrc>"
	@echo ""
	@echo "Generates all graph types:"
	@echo "  - pointers: pointer table relationships"
	@echo "  - dma: DMA data flow (ROM -> VRAM)"
	@echo "  - callers: which functions trigger DMA/reads"
	@echo ""
	@echo "Examples:"
	@echo "  make trace-graph LOG=logs/trace.btrc"
	@exit 1
else
	@echo === Generating all graphs from $(LOG) ===
	@echo.
	@echo [1/3] Pointers graph...
	@python $(SCRIPTS_DIR)/bintrace_parser.py $(LOG) \
		--graphviz $(LOG:.btrc=_pointers.dot) --mode pointers \
		$(if $(wildcard $(SYMBOLS_FILE)),--symbols $(SYMBOLS_FILE),)
	@python -c "import subprocess; r = subprocess.run(['dot', '-Tpng', '$(LOG:.btrc=_pointers.dot)', '-o', '$(LOG:.btrc=_pointers.png)'], capture_output=True); print('  -> $(LOG:.btrc=_pointers.png)') if r.returncode == 0 else print('  -> $(LOG:.btrc=_pointers.dot) (no graphviz)')"
	@echo.
	@echo [2/3] DMA graph...
	@python $(SCRIPTS_DIR)/bintrace_parser.py $(LOG) \
		--graphviz $(LOG:.btrc=_dma.dot) --mode dma \
		$(if $(wildcard $(SYMBOLS_FILE)),--symbols $(SYMBOLS_FILE),)
	@python -c "import subprocess; r = subprocess.run(['dot', '-Tpng', '$(LOG:.btrc=_dma.dot)', '-o', '$(LOG:.btrc=_dma.png)'], capture_output=True); print('  -> $(LOG:.btrc=_dma.png)') if r.returncode == 0 else print('  -> $(LOG:.btrc=_dma.dot) (no graphviz)')"
	@echo.
	@echo [3/3] Callers graph...
	@python $(SCRIPTS_DIR)/bintrace_parser.py $(LOG) \
		--graphviz $(LOG:.btrc=_callers.dot) --mode callers \
		$(if $(wildcard $(SYMBOLS_FILE)),--symbols $(SYMBOLS_FILE),)
	@python -c "import subprocess; r = subprocess.run(['dot', '-Tpng', '$(LOG:.btrc=_callers.dot)', '-o', '$(LOG:.btrc=_callers.png)'], capture_output=True); print('  -> $(LOG:.btrc=_callers.png)') if r.returncode == 0 else print('  -> $(LOG:.btrc=_callers.dot) (no graphviz)')"
	@echo.
	@echo Done! Generated graphs in $(dir $(LOG))
endif

# Print binary trace statistics
# Usage: make trace-stats LOG=<path.btrc>
.PHONY: trace-stats
trace-stats:
ifndef LOG
	@echo "ERROR: LOG parameter required!"
	@echo ""
	@echo "Usage: make trace-stats LOG=<trace.btrc>"
	@exit 1
else
	python $(SCRIPTS_DIR)/bintrace_parser.py $(LOG) --stats
endif

# Compare two trace logs
# Usage: make compare-traces T1=trace1.csv T2=trace2.csv
.PHONY: compare-traces
compare-traces:
ifndef T1
	@echo "ERROR: T1 (first trace) parameter required!"
	@echo ""
	@echo "Usage: make compare-traces T1=<path> T2=<path> [EXEC_ONLY=1]"
	@exit 1
else ifndef T2
	@echo "ERROR: T2 (second trace) parameter required!"
	@exit 1
else
	python $(SCRIPTS_DIR)/compare_traces.py $(T1) $(T2) $(if $(EXEC_ONLY),--exec-only,)
endif

# Help
.PHONY: help
help:
	@echo "Alien Soldier (J) Build System"
	@echo ""
	@echo "Basic commands:"
	@echo "  make build              - Assemble and build ROM (default)"
	@echo "  make compare            - Compare built ROM with original"
	@echo "  make split              - Extract data from original ROM"
	@echo "  make clean              - Remove all build artifacts and extracted data"
	@echo ""
	@echo "Analysis workflow (requires MOVIE=tas|longplay|menus):"
	@echo "  1. make find-unanalyzed        - Generate list of unanalyzed procedures"
	@echo "  2. make reference MOVIE=tas    - Generate reference screenshots"
	@echo "  3. make analyze MOVIE=tas      - Analyze procedures"
	@echo "  4. make report MOVIE=tas       - Generate analysis report"
	@echo ""
	@echo "Documentation workflow (Claude + human):"
	@echo "  1. make set-movie MOVIE=tas    - Set movie type for workflow"
	@echo "  2. make prepare-batch COUNT=40 - Prepare batch of procedures"
	@echo "     -> Claude reads workflow/batch_procedures.txt"
	@echo "     -> Claude creates workflow/rename_batch.csv"
	@echo "  3. make rename                 - Apply renames and mark processed"
	@echo "  4. make build && make compare"
	@echo "  5. git commit"
	@echo ""
	@echo "Debugging (visual + memory):"
	@echo "  1. make reference MOVIE=tas    - Generate reference"
	@echo "  2. [modify ROM and rebuild]"
	@echo "  3. make debug MOVIE=tas        - Collect 10 visual differences"
	@echo ""
	@echo "Debugging (pointer issues):"
	@echo "  make reference MOVIE=tas       - Generate reference (required first!)"
	@echo "  make debug-pointers MOVIE=tas [START=1BD000] [END=100000]"
	@echo "     -> Tests data blocks by inserting padding ($(ANALYSIS_WORKERS) parallel workers)"
	@echo "     -> Works backwards from END to minimize displacement"
	@echo "     -> Collects 10 genstate dumps + screenshots when diff found"
	@echo "     -> Stops after first problem found"
	@echo ""
	@echo "CPU tracing (binary format, ~10-50x smaller than text):"
	@echo "  make trace-frames MOVIE=tas START=100 END=110"
	@echo "     -> Outputs compact binary trace: logs/trace_100_110.btrc"
	@echo "  make trace-story LOG=logs/trace_100_110.btrc"
	@echo "     -> Human-readable story log: logs/trace_100_110_story.txt"
	@echo "  make trace-graph LOG=logs/trace_100_110.btrc MODE=pointers"
	@echo "     -> Graphviz DOT: logs/trace_100_110_pointers.dot"
	@echo "  make trace-graph LOG=logs/trace_100_110.btrc MODE=dma"
	@echo "     -> Graphviz DOT: logs/trace_100_110_dma.dot"
	@echo "  make trace-stats LOG=logs/trace_100_110.btrc"
	@echo "     -> Print trace statistics"
	@echo ""
	@echo "Utilities:"
	@echo "  make show-movie         - Show current movie setting"
	@echo "  make stop               - Stop all running Gens emulators"
	@echo "  make build-gens         - Build Gens emulator (VS2022)"
	@echo ""
	@echo "MOVIE types: tas, longplay, menus"
	@echo "Workflow dir: $(WORKFLOW_DIR)/"
