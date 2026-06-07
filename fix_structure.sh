#!/bin/bash

# ─────────────────────────────────────────────
# Stroke Risk Project Structure Fix Script
# Run from project root directory
# ─────────────────────────────────────────────

set -e  # stop on first error

echo "🧠 Fixing Stroke Risk project structure..."

# ── 1. Rename top-level folders ──────────────
mv "DATASETS" "data" 2>/dev/null || true
mv "NOTEBOOKS" "notebooks" 2>/dev/null || true
mv "REPORTS" "reports" 2>/dev/null || true
mv "DOCS" "docs" 2>/dev/null || true
mv "IMAGES" "images" 2>/dev/null || true
mv "POWER BI" "powerbi" 2>/dev/null || true
mv "SQL" "sql" 2>/dev/null || true

# ── 2. Rename data subfolders ─────────────────
mv "data/RAW DATASETS" "data/raw" 2>/dev/null || true
mv "data/CLEANED DATASETS" "data/processed" 2>/dev/null || true

# ── 3. Remove all getkeep files ───────────────
find . -name "getkeep" -delete

# ── 4. Add .gitkeep to all empty folders ──────
find . -type d \
  ! -path "./.git/*" \
  ! -name ".git" \
  -exec sh -c '
    if [ -z "$(ls -A "$1")" ]; then
      touch "$1/.gitkeep"
      echo "  + .gitkeep → $1"
    fi
  ' _ {} \;

# ── 5. Create sql subfiles ────────────────────
touch sql/01_demographic_risk_analysis.sql
touch sql/02_clinical_risk_factors.sql
touch sql/03_lifestyle_analysis.sql
touch sql/04_stroke_occurrence_summary.sql

# ── 6. Create notebooks ───────────────────────
touch notebooks/01_data_cleaning.ipynb
touch notebooks/02_eda.ipynb
touch notebooks/03_feature_engineering.ipynb
touch notebooks/04_predictive_model.ipynb

# ── 7. Create requirements.txt ────────────────
cat > requirements.txt << 'REQS'
pandas
numpy
matplotlib
seaborn
scikit-learn
imbalanced-learn
scipy
openpyxl
jupyter
REQS

# ── 8. Create .gitignore ──────────────────────
cat > .gitignore << 'IGNORE'
# Jupyter
.ipynb_checkpoints/
*.ipynb_checkpoints

# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.env

# OS
.DS_Store
Thumbs.db

# Data (optional — comment out if you want to push data)
# data/raw/*.csv
IGNORE

echo ""
echo "✅ Done! New structure:"
echo ""
tree -a --dirsfirst -I '.git'