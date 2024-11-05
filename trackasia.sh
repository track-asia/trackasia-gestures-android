#!/bin/bash

git_clone() {
    read -p "Enter path folder or input path (press Enter to use current directory): " DESTINATION_PATH

    if [ -z "$DESTINATION_PATH" ]; then
        DESTINATION_PATH="$PWD/track-asia-native"
        echo "Using current directory: $DESTINATION_PATH"
    fi

    if [ ! -d "$DESTINATION_PATH" ]; then
        mkdir -p "$DESTINATION_PATH"
    fi

    git clone --recurse-submodules https://github.com/maplibre/maplibre-native.git "$DESTINATION_PATH"
    echo "Clone rnr repository..."
    git clone https://github.com/ismaelgv/rnr
    read -p "Press Enter to continue..."
}

replace_strings() {
    local from_name="$1"
    local to_name="$2"
    echo "Running Change Name $from_name -> $to_name"
    if rnr -f -r -D -x "$from_name" "$to_name" ./; then
        echo "Successfully executed rnr -f -r -D -x $from_name $to_name ./"
    else
        echo "Failed to execute rnr -f -r -D -x $from_name $to_name ./"
        exit 1
    fi
}

run_replacement() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: run_replacement [find string] [replace string]"
        exit 1
    fi

    local FIND="$1"
    local REPLACE="$2"
    
    export LC_CTYPE=C;
    export LANG=C;

    # Set default value for DESTINATION_PATH if not provided
    if [ -z "$DESTINATION_PATH" ]; then
        DESTINATION_PATH="$PWD/track-asia-native"
        echo "Using current directory: $DESTINATION_PATH"
    fi

    # List of directories to search for files
    TARGET_DIRECTORIES=("$DESTINATION_PATH")

    # Iterate through target directories and perform replacements
    for dir in "${TARGET_DIRECTORIES[@]}"; do
        echo "Processing files in $dir/"
        find "$dir" -type f -exec sed -i '' "s|${FIND}|${REPLACE}|g" {} \; -exec echo "Replaced $FIND with $REPLACE in {}" \;
    done

    echo "Replacement completed. Changes logged to stdout."
}

# Function for running Git Clone, replace_strings, and run_replacement
main() {
    echo "TrackAsia Select an option:" 
    options=("Git Clone" "Run replace_strings" "Run run_replacement" "Exit")
       select opt in "${options[@]}"; do
        case $opt in
            "Git Clone")
                git_clone
                ;;
            "Run replace_strings")
                replace_strings "TRACKASIA" "TRACKASIA"
                replace_strings "MapLibre" "TrackAsia"
                replace_strings "Maplibre" "Trackasia"
                replace_strings "mapLibre" "trackAsia"
                replace_strings "maplibre.org " "track-asia.com"
                replace_strings "/maplibre/" "/trackasia/"
                replace_strings "maplibre/" "trackasia/"
                replace_strings "org.trackasia.gl" "io.github.track-asia"
                replace_strings "maplibre" "trackasia"
                replace_strings "MapboxGLAndroid" "TrackAsiaGLAndroid"
                replace_strings "trackasia.org" "track-asia.com"
                echo "replace_strings completed."
                ;;
            "Run run_replacement")
                run_replacement "TRACKASIA" "TRACKASIA"
                run_replacement "MapLibre" "TrackAsia"
                run_replacement "Maplibre" "Trackasia"
                run_replacement "mapLibre" "trackAsia"
                run_replacement "maplibre.org " "track-asia.com"
                run_replacement "/maplibre/" "/trackasia/"
                run_replacement "maplibre/" "trackasia/"
                run_replacement "maplibre" "trackasia"
                run_replacement "trackasia.org" "track-asia.com"
                run_replacement "org.trackasia.gl" "io.github.track-asia"
                # run_replacement "https://demotiles.track-asia.com/style.json" "https://tiles.track-asia.com/tiles/v1/style-streets.json?key=public"
                echo "run_replacement completed."
                ;;
            "Exit")
                echo "Complete"
                exit 0
                ;;
            *) echo "Invalid option";;
        esac
    done

    if [ -d "$DESTINATION_PATH" ]; then
        echo "Script complete."
    else
        echo "Error: The directory $DESTINATION_PATH does not exist."
        exit 1
    fi
}

# Call the main function
main
