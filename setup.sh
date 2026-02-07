#!/bin/bash

# Claude Code Project Template — Setup
# Run this after cloning the template into a new project.

set -e

BOLD='\033[1m'
DIM='\033[2m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${BOLD}Claude Code Project Template — Setup${NC}"
echo -e "${DIM}────────────────────────────────────────${NC}"
echo ""

# ── Project name ──────────────────────────────────────────

read -p "Project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  echo "No project name given. Exiting."
  exit 1
fi

read -p "One-line description: " PROJECT_DESC

# ── Update CLAUDE.md ──────────────────────────────────────

sed -i "s/\[Name\]/$PROJECT_NAME/" CLAUDE.md
sed -i "s/\[One-line description of what this is and what it does\]/$PROJECT_DESC/" CLAUDE.md

TODAY=$(date +%Y-%m-%d)
sed -i "s/> Updated: \[date\]/> Updated: $TODAY/" CLAUDE.md

echo -e "${GREEN}✓${NC} Updated CLAUDE.md"

# ── Update PLAN.md ────────────────────────────────────────

sed -i "s/> Last updated: \[date\]/> Last updated: $TODAY/" PLAN.md

echo -e "${GREEN}✓${NC} Updated PLAN.md"

# ── Update STATE.md ───────────────────────────────────────

sed -i "s/> Last updated: \[date\]/> Last updated: $TODAY/" STATE.md

echo -e "${GREEN}✓${NC} Updated STATE.md"

# ── Global CLAUDE.md ──────────────────────────────────────

GLOBAL_CLAUDE="$HOME/.claude/CLAUDE.md"

if [ -f "$GLOBAL_CLAUDE" ]; then
  echo -e "${GREEN}✓${NC} Global CLAUDE.md already exists at $GLOBAL_CLAUDE"
else
  echo ""
  read -p "No global CLAUDE.md found. Install one now? (y/n) " INSTALL_GLOBAL
  if [ "$INSTALL_GLOBAL" = "y" ] || [ "$INSTALL_GLOBAL" = "Y" ]; then
    mkdir -p "$HOME/.claude"
    cp CLAUDE.global.md "$GLOBAL_CLAUDE"
    echo -e "${GREEN}✓${NC} Installed global CLAUDE.md to $GLOBAL_CLAUDE"
    echo -e "${YELLOW}  → Edit it with your personal preferences${NC}"
  else
    echo -e "${DIM}  Skipped. You can do this later:${NC}"
    echo -e "${DIM}  cp CLAUDE.global.md ~/.claude/CLAUDE.md${NC}"
  fi
fi

# ── Remove template-only files ────────────────────────────

rm -f CLAUDE.global.md
echo -e "${GREEN}✓${NC} Removed CLAUDE.global.md (template-only file)"

# ── .gitignore ────────────────────────────────────────────

GITIGNORE_ENTRIES="CLAUDE.local.md\nHANDOFF.md"

if [ -f .gitignore ]; then
  for ENTRY in CLAUDE.local.md HANDOFF.md; do
    if ! grep -qxF "$ENTRY" .gitignore; then
      echo "$ENTRY" >> .gitignore
    fi
  done
else
  echo -e "$GITIGNORE_ENTRIES" > .gitignore
fi

echo -e "${GREEN}✓${NC} Updated .gitignore"

# ── Git init ──────────────────────────────────────────────

if [ -d .git ]; then
  echo -e "${DIM}  Git repo already initialised${NC}"
else
  read -p "Initialise git repo? (y/n) " INIT_GIT
  if [ "$INIT_GIT" = "y" ] || [ "$INIT_GIT" = "Y" ]; then
    git init -q
    echo -e "${GREEN}✓${NC} Initialised git repo"
  fi
fi

# ── Clean up ──────────────────────────────────────────────

rm -f setup.sh
echo -e "${GREEN}✓${NC} Removed setup.sh"

# ── Done ──────────────────────────────────────────────────

echo ""
echo -e "${DIM}────────────────────────────────────────${NC}"
echo -e "${BOLD}Done.${NC} Next steps:"
echo ""
echo -e "  ${CYAN}1.${NC} Edit ${BOLD}CLAUDE.md${NC} — fill in architecture, commands, and standards"
echo -e "  ${CYAN}2.${NC} Edit ${BOLD}PLAN.md${NC} — define your objective and first tasks"
echo -e "  ${CYAN}3.${NC} Open Claude Code and run ${BOLD}/catchup${NC} to confirm it's reading everything"
echo ""
