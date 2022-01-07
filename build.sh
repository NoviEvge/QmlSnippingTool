 #!/bin/bash

BuildType=""
ThreadCounts="";
clean=false;
updateCache=false;
createInstaller=false;

help() {
      echo "options:"
      echo "-H, --help"
      echo "-D, --debug   - Debug build ( default )"
      echo "-R, --release - Release build"
      echo "-J, --parallel ( with optional parameter > 0 ) - count of threads"
      echo "-C, --clean - clean build folder before build"
      echo "-U, --update - update cmake cache"
      echo "-I, --installer - create installer"
}

exitWithMessage() {
    echo "Error: $1"
    exit 1
}

warningMessage() {
    echo "Warning: $1"
}

validateBuildTypeErrorMessage() {
    if [[ $BuildType ]]; then
        echo "Should only be one build type"
        exit 1
    fi
}

showMessageAndCall() {
    echo $1
    echo $2
    $2
}

copyCmakePresset() {
    filePath="$PWD/configs"

    if [[ "$OSTYPE" =~ ^linux ]]; then
        filePath="${filePath}/linux"
    fi

    if [[ "$OSTYPE" =~ ^msys ]]; then
        filePath="${filePath}/windows"
    fi

    filePath="${filePath}/CMakePresets.json"

    cp "${filePath}" "$PWD"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
    -H|--help)
        help;
        exit 0
        ;;
    -D|--Debug)
        validateBuildTypeErrorMessage
        BuildType="Debug"
        ;;
    -R|--Release)
        validateBuildTypeErrorMessage
        BuildType="Release"
        ;;
    -J|--parallel)
        if [[ $2 ]]; then
            if [[ $2 -ge 1 ]]; then
                ThreadCounts=$2
                shift;
            else
                exitWithMessage "Count of threads must be 1 or more"
            fi
        fi
        ;;
    -C|--clean)
        clean=true;
        ;;
    -U|--update)
        updateCache=true;
        ;;
    -I|--installer)
        createInstaller=true;
        ;;
    esac
    shift
done

[[ ! $BuildType ]] && BuildType="Debug"

CmakeBaseString="cmake"
PresetString="--preset $BuildType"
CacheString="$CmakeBaseString $PresetString"
BuildFolder="$PWD/build/$BuildType"
BuildString="$CmakeBaseString --build $PresetString"

[[ $clean = true || $createInstaller = true ]] && BuildString+=" --clean-first"

[[ $ThreadCounts ]] && BuildString+=" -j $ThreadCounts"

[[ $createInstaller = true ]] && export CREATE_INSTALLER=""

copyCmakePresset

[[ $updateCache = true || ! -d $BuildFolder ]] && showMessageAndCall "Make CMake cache:" "$CacheString"

showMessageAndCall "Build project:" "$BuildString"

rm "${PWD}/CMakePresets.json"

exit 0