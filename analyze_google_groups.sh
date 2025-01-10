#!/bin/bash

# Script to analyze emails in Maildir directories for Google Groups and extract specific headers

# === Parameters ===
PASSWD_FILE="/etc/passwd"
MAILDIR_SUFFIX="/Maildir"
SAVE_RESULTS=true
RESULTS_FILE="google_groups_results.txt"

# Patterns for extracting headers
GOOGLE_GROUP_ID_PATTERN="^X-Google-Group-ID:.*"
LIST_ID_PATTERN="^List-ID:.*"

# === Functions ===

# Progress bar function
progress_bar() {
    local progress=$1
    local total=$2
    local bar_length=50
    local filled=$((progress * bar_length / total))
    local empty=$((bar_length - filled))

    echo -ne "\r["
    printf "%0.s#" $(seq 1 $filled)
    printf "%0.s-" $(seq 1 $empty)
    echo -ne "] $((progress * 100 / total))%  ($progress/$total)"
}

# Write result to the results file
write_result() {
    local result=$1
    echo "$result" >>"$RESULTS_FILE"
}

# === Script Start ===

echo "Starting analysis of Google Groups in Maildir directories..."
echo "=============================================================="

# Initialize results file
if $SAVE_RESULTS; then
    echo "Saving results to: $RESULTS_FILE"
    >"$RESULTS_FILE"
fi

# Retrieve all Maildir paths from the /etc/passwd file
MAILDIRS=$(awk -F: -v suffix="$MAILDIR_SUFFIX" '{print $6 suffix}' "$PASSWD_FILE")

# Filter only existing Maildir directories
EXISTING_MAILDIRS=()
for MAILDIR in $MAILDIRS; do
    if [[ -d "$MAILDIR" ]]; then
        EXISTING_MAILDIRS+=("$MAILDIR")
    fi
done

# Count total files across all existing Maildirs
TOTAL_FILES=$(find "${EXISTING_MAILDIRS[@]}" -type f 2>/dev/null | wc -l)
PROCESSED_FILES=0

# Iterate through each existing Maildir
for MAILDIR in "${EXISTING_MAILDIRS[@]}"; do
    echo -e "\nSearching in: $MAILDIR"
    echo "---------------------------------------------------"

    # Search for emails in the Maildir recursively
    find "$MAILDIR" -type f | while read -r file; do
        # Search only for X-Google-Group-ID header
        GOOGLE_GROUP_ID=$(grep -Ei "^X-Google-Group-ID:" "$file" 2>/dev/null)

        if [[ -n "$GOOGLE_GROUP_ID" ]]; then
            # If X-Google-Group-ID is found, also search for List-ID
            LIST_ID=$(grep -Ei "^List-ID:" "$file" 2>/dev/null)

            echo -e "\nFile: $file"
            echo "$GOOGLE_GROUP_ID"
            [[ -n "$LIST_ID" ]] && echo "$LIST_ID"

            if $SAVE_RESULTS; then
                # Write file path and name to results
                write_result "File: $file"

                # Write X-Google-Group-ID to results
                write_result "Google-Group-ID: $GOOGLE_GROUP_ID"

                # Write List-ID if it exists, followed by an empty line
                if [[ -n "$LIST_ID" ]]; then
                    write_result "List-ID: $LIST_ID"
                    write_result "" # Empty line for separation
                fi
            fi
            echo "----------------------------------------"
        fi

        # Update progress bar occasionally
        ((PROCESSED_FILES++))
        if ((PROCESSED_FILES % 100 == 0 || PROCESSED_FILES == TOTAL_FILES)); then
            progress_bar $PROCESSED_FILES $TOTAL_FILES
        fi
    done
done

echo -e "\nAnalysis complete."
if $SAVE_RESULTS; then
    echo "Results saved to: $RESULTS_FILE"
fi
