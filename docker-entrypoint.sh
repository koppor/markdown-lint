#!/bin/bash

# default to "normal" executable
TOOL_AND_ARGS="markdownlint-cli2";

if [ "$INPUT_CONFIG" != "" ]; then
  TOOL_AND_ARGS="markdownlint-cli2-config $INPUT_CONFIG";
fi;

if [ "$INPUT_FIX" = "true" ]; then
  TOOL_AND_ARGS="markdownlint-cli2-fix";
fi;

if [ "$DEBUG" = "true" ]; then
  printenv | sort;
  echo "$TOOL_AND_ARGS $@";
fi;

# Do not quote "$@" as Github Actions passes each argument as a single arg.
# So 'args: foo bar.md' would be treated as a single string and not be parsed by markdownlint
exec $TOOL_AND_ARGS $@
