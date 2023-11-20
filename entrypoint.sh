#!/bin/sh -l


##################################
#   Wake environment variables   #
##################################

WORKING_DIRECTORY="${1}"
EXPORT_SARIF="${2}"
if [ -n "${3}" ]; then export WAKE_CONFIG="${3}"; fi
if [ -n "${4}" ]; then export WAKE_COMPILE_ALLOW_PATHS="${4}"; fi
if [ -n "${5}" ]; then export WAKE_COMPILE_EVM_VERSION="${5}"; fi
if [ -n "${6}" ]; then export WAKE_COMPILE_IGNORE_PATHS="${6}"; fi
if [ -n "${7}" ]; then export WAKE_COMPILE_INCLUDE_PATHS="${7}"; fi
if [ -n "${8}" ]; then export WAKE_COMPILE_OPTIMIZER_ENABLED="${8}"; fi
if [ -n "${9}" ]; then export WAKE_COMPILE_OPTIMIZER_RUNS="${9}"; fi
if [ -n "${10}" ]; then export WAKE_COMPILE_REMAPPINGS="${10}"; fi
if [ -n "${11}" ]; then export WAKE_COMPILE_TARGET_VERSION="${11}"; fi
if [ -n "${12}" ]; then export WAKE_COMPILE_VIA_IR="${12}"; fi
if [ -n "${13}" ]; then export WAKE_DETECT_MIN_IMPACT="${13}"; fi
if [ -n "${14}" ]; then export WAKE_DETECT_MIN_CONFIDENCE="${14}"; fi
if [ -n "${15}" ]; then export WAKE_DETECT_PATHS="${15}"; fi
if [ -n "${16}" ]; then export WAKE_DETECT_ONLY="${16}"; fi
if [ -n "${17}" ]; then export WAKE_DETECT_EXCLUDE="${17}"; fi
if [ -n "${18}" ]; then export WAKE_DETECT_IGNORE_PATHS="${18}"; fi
if [ -n "${19}" ]; then export WAKE_DETECT_EXCLUDE_PATHS="${19}"; fi

######################
#   Execution part   #
######################

# Change working directory
if [ -n "$WORKING_DIRECTORY" ]; then
  cd "$WORKING_DIRECTORY"
else
  WORKING_DIRECTORY="."
fi

# Check for enabled SARIF export
EXPORT=""
if [ -n "$EXPORT_SARIF" ]; then
  EXPORT="--export=sarif"
  echo "sarif=$WORKING_DIRECTORY/wake-detections.sarif" >> $GITHUB_OUTPUT
fi

# 🌊️🌊️ Run analysis
wake detect ${EXPORT} all ${WAKE_DETECT_PATHS}

# Exit 0 if SARIF export enabled
STATUS=$?
if [ "$EXPORT_SARIF" = true -a ${STATUS} -eq 3 ]; then
  exit 0
else
  exit ${STATUS}
fi