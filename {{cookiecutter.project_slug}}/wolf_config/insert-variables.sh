#!/bin/bash

echo "wolfFlow Environment Setup Script (Unix/Mac)"
echo "=========================================="
echo

echo "This script will update system prompt files with your local environment details."
echo

# --- Get Environment Variables Correctly ---
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS specific
    OS="macOS $(sw_vers -productVersion)"
    SED_IN_PLACE=(-i "")
else
    # Linux specific
    OS=$(uname -s -r)
    SED_IN_PLACE=(-i)
fi

SHELL="bash"  # Hardcode to bash since we're explicitly using it
HOME=$(echo "$HOME")  # Use existing $HOME, but quote it
WORKSPACE=$(pwd)

# --- Construct Paths ---
GLOBAL_SETTINGS="$HOME/.vscode-server/data/User/globalStorage/seawolf.wolf-flow/settings/cline_custom_modes.json"
MCP_LOCATION="$HOME/.local/share/wolf-Code/MCP"
MCP_SETTINGS="$HOME/.vscode-server/data/User/globalStorage/wseawolf.wolf-flow/settings/cline_mcp_settings.json"

echo "Detected Environment:"
echo "- OS: $OS"
echo "- Shell: $SHELL"
echo "- Home Directory: $HOME"
echo "- Workspace Directory: $WORKSPACE"
echo

# --- Directory Setup ---
wolf_DIR="$WORKSPACE/.wolf"

# Create .wolf directory if it doesn't exist
if [ ! -d "$wolf_DIR" ]; then
    mkdir -p "$wolf_DIR"
    echo "Created .wolf directory"
fi

# --- Function to escape strings for sed ---
escape_for_sed() {
    echo "$1" | sed 's/[\/&]/\\&/g'
}

# Check if wolf_config/.wolf directory exists with system prompt files
if [ -d "wolf_config/.wolf" ] && [ "$(ls -A wolf_config/.wolf 2>/dev/null)" ]; then
    echo "Found system prompt files in wolf_config/.wolf"
    
    # Copy files from wolf_config/.wolf to .wolf
    cp -r wolf_config/.wolf/* "$wolf_DIR/"
    echo "Copied system prompt files to $wolf_DIR"
    
    # --- Perform Replacements using sed ---
    find "$wolf_DIR" -type f -name "system-prompt-*" -print0 | while IFS= read -r -d $'\0' file; do
        echo "Processing: $file"
        
        # Basic variables - using sed with escaped strings
        sed "${SED_IN_PLACE[@]}" "s/OS_PLACEHOLDER/$(escape_for_sed "$OS")/g" "$file"
        sed "${SED_IN_PLACE[@]}" "s/SHELL_PLACEHOLDER/$(escape_for_sed "$SHELL")/g" "$file"
        sed "${SED_IN_PLACE[@]}" "s|HOME_PLACEHOLDER|$(escape_for_sed "$HOME")|g" "$file"
        sed "${SED_IN_PLACE[@]}" "s|WORKSPACE_PLACEHOLDER|$(escape_for_sed "$WORKSPACE")|g" "$file"
        
        # Complex paths - using sed with escaped strings
        sed "${SED_IN_PLACE[@]}" "s|GLOBAL_SETTINGS_PLACEHOLDER|$(escape_for_sed "$GLOBAL_SETTINGS")|g" "$file"
        sed "${SED_IN_PLACE[@]}" "s|MCP_LOCATION_PLACEHOLDER|$(escape_for_sed "$MCP_LOCATION")|g" "$file"
        sed "${SED_IN_PLACE[@]}" "s|MCP_SETTINGS_PLACEHOLDER|$(escape_for_sed "$MCP_SETTINGS")|g" "$file"
        
        echo "Completed: $file"
    done
else
    echo "No system prompt files found in wolf_config/.wolf"
    
    # Check if default-system-prompt.md exists
    if [ -f "default-system-prompt.md" ]; then
        echo "Found default-system-prompt.md"
        
        # Create system prompt files for each mode
        for mode in code architect ask debug test; do
            output_file="$wolf_DIR/system-prompt-$mode"
            
            sed -e "s/OS_PLACEHOLDER/$(escape_for_sed "$OS")/g" \
                -e "s/SHELL_PLACEHOLDER/$(escape_for_sed "$SHELL")/g" \
                -e "s|HOME_PLACEHOLDER|$(escape_for_sed "$HOME")|g" \
                -e "s|WORKSPACE_PLACEHOLDER|$(escape_for_sed "$WORKSPACE")|g" \
                -e "s|GLOBAL_SETTINGS_PLACEHOLDER|$(escape_for_sed "$GLOBAL_SETTINGS")|g" \
                -e "s|MCP_LOCATION_PLACEHOLDER|$(escape_for_sed "$MCP_LOCATION")|g" \
                -e "s|MCP_SETTINGS_PLACEHOLDER|$(escape_for_sed "$MCP_SETTINGS")|g" \
                "default-system-prompt.md" > "$output_file"
                
            echo "Created $output_file"
        done
    else
        echo "No default system prompt found. Please create system prompt files manually."
    fi
fi

echo
echo "Setup complete!"
echo "You can now use wolfFlow with your local environment settings."
echo