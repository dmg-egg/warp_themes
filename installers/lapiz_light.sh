#!/bin/bash
# Theme Configuration
readonly THEME_NAME="Lapiz Light"
readonly THEME_CONTENT='terminal_colors:
  bright:
    black: "#212121"
    red: "#fb007a"
    green: "#5fd7af"
    yellow: "#f3e430"
    blue: "#20bbfc"
    magenta: "#6855de"
    cyan: "#4fb8cc"
    white: "#f1f1f1"
  normal:
    black: "#212121"
    red: "#c30771"
    green: "#10a778"
    yellow: "#a89c14"
    blue: "#008ec4"
    magenta: "#523c79"
    cyan: "#20a5ba"
    white: "#e0e0e0"
background: "#f1f1f1"
foreground: "#424242"
accent: "#008ec4"
details: "lighter"
'

# Set theme directory based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    theme_dir="$HOME/.warp/themes"
else
    theme_dir="${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal/themes"
fi

# Warp Variables
readonly WARP_THEME_DIR="$theme_dir"

# Colors
readonly RESET="\033[0m"
readonly BLACK="\033[0;30m"
readonly BOLD="\033[1m"
readonly DIM="\033[2m"
readonly GREEN_BOLD="\033[1;32m"
readonly RED_BOLD="\033[1;31m"
readonly BACKGROUND_LIGHT_GREEN="\033[102m"
readonly BACKGROUND_LIGHT_RED="\033[101m"

# Handle 'check' parameter for theme existence check
if [ "$1" = "check" ]; then
    if [ -f "${WARP_THEME_DIR}/${THEME_NAME}.yaml" ]; then
        exit 0  # Theme exists
    else
        exit 1  # Theme doesn't exist
    fi
fi

printf "${BOLD}Warp-Themes Installer ${RESET}${DIM}(v1.0.0)${RESET}\n\n"
printf "${GREEN_BOLD}✓${RESET} ${BOLD}Installing theme:${RESET}${DIM} ${THEME_NAME}${RESET}\n"

# Check if WARP_THEME_DIR exists
if [ ! -d "${WARP_THEME_DIR}" ]; then
    printf "${GREEN_BOLD}✓${RESET} ${BOLD}Creating Warp Theme Directory:${RESET}${DIM} ${WARP_THEME_DIR}${RESET}\n"
    mkdir -p "${WARP_THEME_DIR}"
    chmod 755 "${WARP_THEME_DIR}"
fi

# Check if theme file already exists
if [ -f "${WARP_THEME_DIR}/${THEME_NAME}.yaml" ]; then
  printf "${RED_BOLD}X${RESET} ${BOLD}Theme already exists:${RESET} ${DIM}${WARP_THEME_DIR}/${THEME_NAME}.yaml\n\n"
	printf "${BLACK}${BACKGROUND_LIGHT_RED} Next steps ${RESET}\n\n"
	printf "Delete the file to continue\n"
	printf "Copy and paste ${DIM}rm ${WARP_THEME_DIR}/${THEME_NAME}.yaml ${RESET}into your terminal\n"
	exit 1
fi

touch "${WARP_THEME_DIR}/${THEME_NAME}.yaml"
echo "${THEME_CONTENT}" > "${WARP_THEME_DIR}/${THEME_NAME}.yaml"
printf "${GREEN_BOLD}✓${RESET} ${GREEN}Successfully installed the theme!\n\n"
printf "${BLACK}${BACKGROUND_LIGHT_GREEN} Next steps ${RESET}\n\n"
printf "Restart Warp and select ${GREEN_BOLD}${THEME_NAME} ${RESET}from the Theme Picker\n\n"
printf "Don't know how to open the Theme Picker? ${GREEN_BOLD}https://docs.warp.dev/features/themes#how-to-access-it${RESET}\n"
printf "${DIM}Enjoy your new theme!${RESET}\n"
