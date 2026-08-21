#!/bin/bash
# PlantUML Diagram Validation Script
# Usage: ./validate-diagrams.sh <diagram-file.pu> [diagram-file2.pu ...]

# Ensure PlantUML is available
if [ ! -f /tmp/plantuml.jar ]; then
    echo "Downloading PlantUML validator..."
    wget -q https://github.com/plantuml/plantuml/releases/download/v1.2024.8/plantuml-1.2024.8.jar -O /tmp/plantuml.jar
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download PlantUML"
        exit 1
    fi
fi

# Validate each diagram file
for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "Error: File not found: $file"
        continue
    fi

    filename=$(basename "$file")
    result=$(java -jar /tmp/plantuml.jar "$file" 2>&1)

    if echo "$result" | grep -q "Error line"; then
        error_line=$(echo "$result" | grep -E "Error line" | head -1)
        echo "Diagram: $file"
        echo "Status: ❌ Invalid ($error_line)"
        echo ""
    else
        echo "Diagram: $file"
        echo "Status: ✓ Valid"
        echo ""
    fi
done
