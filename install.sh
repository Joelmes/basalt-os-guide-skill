#!/bin/bash
set -e

REPO="https://github.com/Joelmes/basalt-os-guide-skill.git"
SKILL_NAME="basalt-os-guide"
TEMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'basalt')

# ─── Colors ───
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

cleanup() { rm -rf "$TEMP_DIR"; }
trap cleanup EXIT

echo ""
echo -e "${CYAN}${BOLD}  Basalt OS Guide — AI Agent Skill Installer${NC}"
echo -e "  ────────────────────────────────────────────"
echo ""

# ─── Parse arguments ───
AGENT=""
CUSTOM_PATH=""
for arg in "$@"; do
  case "$arg" in
    --agent=*) AGENT="${arg#*=}" ;;
    --path=*)  CUSTOM_PATH="${arg#*=}" ;;
    --qoderwork|--qoder) AGENT="qoderwork" ;;
    --claude)  AGENT="claude" ;;
    --cursor)  AGENT="cursor" ;;
    --codex)   AGENT="codex" ;;
    --cline)   AGENT="cline" ;;
    --help|-h)
      echo "Usage: install.sh [options]"
      echo ""
      echo "Options:"
      echo "  --agent=NAME   Target agent (qoderwork|claude|cursor|codex|cline)"
      echo "  --path=DIR     Custom installation path"
      echo "  --help         Show this help"
      echo ""
      echo "If no options given, the installer auto-detects your agent environment."
      exit 0
      ;;
  esac
done

# ─── Auto-detect agent environment ───
if [ -z "$AGENT" ] && [ -z "$CUSTOM_PATH" ]; then
  if [ -d "$HOME/.qoderworkcn" ]; then
    AGENT="qoderwork"
  elif [ -d "$HOME/.claude" ]; then
    AGENT="claude"
  elif [ -d "$PWD/.cursor" ] || [ -d "$HOME/.cursor" ]; then
    AGENT="cursor"
  elif [ -d "$PWD/.codex" ] || [ -d "$HOME/.codex" ]; then
    AGENT="codex"
  elif [ -d "$PWD/.cline" ] || [ -d "$HOME/.cline" ]; then
    AGENT="cline"
  else
    AGENT="qoderwork"
  fi
  echo -e "  ${CYAN}→${NC} Auto-detected agent: ${BOLD}$AGENT${NC}"
fi

# ─── Determine destination ───
if [ -n "$CUSTOM_PATH" ]; then
  DEST="$CUSTOM_PATH/$SKILL_NAME"
elif [ -n "$AGENT" ]; then
  case "$AGENT" in
    qoderwork|qoder)  DEST="$HOME/.qoderworkcn/skills/$SKILL_NAME" ;;
    claude|claude-code)
      if [ -d "$PWD/.claude" ]; then DEST="$PWD/.claude/skills/$SKILL_NAME"
      else DEST="$HOME/.claude/skills/$SKILL_NAME"; fi ;;
    cursor)
      if [ -d "$PWD/.cursor" ]; then DEST="$PWD/.cursor/skills/$SKILL_NAME"
      else DEST="$PWD/.cursor/skills/$SKILL_NAME"; fi ;;
    codex|openai-codex)
      if [ -d "$PWD/.codex" ]; then DEST="$PWD/.codex/skills/$SKILL_NAME"
      else DEST="$HOME/.codex/skills/$SKILL_NAME"; fi ;;
    cline)
      if [ -d "$PWD/.cline" ]; then DEST="$PWD/.cline/skills/$SKILL_NAME"
      else DEST="$HOME/.cline/skills/$SKILL_NAME"; fi ;;
    *) DEST="$HOME/.qoderworkcn/skills/$SKILL_NAME" ;;
  esac
else
  DEST="$HOME/.qoderworkcn/skills/$SKILL_NAME"
fi

echo -e "  ${CYAN}→${NC} Destination: ${BOLD}$DEST${NC}"
echo ""

# ─── Clone ───
echo -e "  ${CYAN}↓${NC} Cloning repository..."
if git clone --depth 1 "$REPO" "$TEMP_DIR/repo" 2>/dev/null; then
  echo -e "  ${GREEN}✓${NC} Clone successful"
else
  echo -e "  ${RED}✗${NC} Clone failed. Check your network connection."
  exit 1
fi

# ─── Install ───
echo -e "  ${CYAN}↓${NC} Installing skill files..."
mkdir -p "$DEST"

# Copy skill files (exclude .git and repo-level meta)
for item in "$TEMP_DIR/repo"/*; do
  name=$(basename "$item")
  [ "$name" = ".git" ] && continue
  if [ "$name" = "README.md" ] && [ -z "$CUSTOM_PATH" ]; then
    continue  # skip README for standard installs
  fi
  cp -R "$item" "$DEST/"
done

# Count installed files
FILE_COUNT=$(find "$DEST" -type f -not -name '.DS_Store' | wc -l | tr -d ' ')

echo -e "  ${GREEN}✓${NC} Installed ${BOLD}$FILE_COUNT${NC} files"
echo ""

# ─── Verify ───
if [ -f "$DEST/SKILL.md" ] && [ -d "$DEST/references" ]; then
  REF_COUNT=$(ls "$DEST/references/"*.md 2>/dev/null | wc -l | tr -d ' ')
  echo -e "  ${GREEN}✓${NC} SKILL.md found"
  echo -e "  ${GREEN}✓${NC} $REF_COUNT reference modules ready"
else
  echo -e "  ${YELLOW}!${NC} Some files may be missing, please verify manually"
fi

echo ""
echo -e "  ${GREEN}${BOLD}✓ Installation complete!${NC}"
echo -e "  Ask your agent: ${CYAN}\"协议代扣和授权代付有什么区别？\"${NC}"
echo ""
