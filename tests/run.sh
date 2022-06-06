#!/usr/bin/env sh
#set -x

runChangelogTest() {
  input_file="$1";          # (string) eg.: "./foo/CHANGELOG.md"
  want_error="${2:-false}"; # (string) eg.: true|false
  error_message="$3";       # (string) eg.: "File not found"

  echo "[TEST] Start test using file [$input_file]";

  if [ ! -f "$input_file" ]; then
    (>&2 echo "[ERROR] Input file $input_file was not found") && exit 50;
  fi;

  output=$(markdownlint-cli2-config \
    /lint/changelog/.markdownlint-cli2.yml \
    "$input_file" 2>&1);

  exit_code=$?;

  if [ "$want_error" = "false" ] && [ $exit_code -ne 0 ]; then
    (>&2 echo "$0: [ERROR] Exit code must equal 0. Output [$output]") && exit 50;
  fi;

  if [ "$want_error" = "true" ] && [ $exit_code -eq 0 ]; then
    (>&2 echo "$0: [ERROR] Exit code must be grater then 0") && exit 50;
  fi;

  if [ "$want_error" = "true" ] && [ "$(echo "$output" | grep -c "$error_message")" -eq 0 ]; then
    (>&2 echo "$0: [ERROR] Expected error message [$error_message] was not found in output [$output]") && exit 50;
  fi;

  echo "[OK] Test passed";
}

runChangelogTest ./samples/changelog/correct/sample-1.md false
runChangelogTest ./samples/changelog/correct/sample-2.md false
runChangelogTest ./samples/changelog/correct/sample-3.md false
runChangelogTest ./samples/changelog/incorrect/changes-list-with-ends-punctuation-1.md true "Lists items without punctuation"
runChangelogTest ./samples/changelog/incorrect/changes-list-with-ends-punctuation-2.md true "Lists items without punctuation"
runChangelogTest ./samples/changelog/incorrect/incorrect-cahnges-type-1.md true "Type of changes format"
runChangelogTest ./samples/changelog/incorrect/incorrect-cahnges-type-2.md true "Type of changes format"
runChangelogTest ./samples/changelog/incorrect/missed-first-header.md true "First line in a file should be a top-level heading"
runChangelogTest ./samples/changelog/incorrect/no-proper-link.md true "Version header format"
runChangelogTest ./samples/changelog/incorrect/wrong-version-header-1.md true "Version header format"
runChangelogTest ./samples/changelog/incorrect/wrong-version-header-2.md true "Version header format"
runChangelogTest ./samples/changelog/incorrect/wrong-version-header-3.md true "Version header format"
runChangelogTest ./samples/changelog/incorrect/duplicated-unreleased-header.md true "Only one 'unreleased' version header"
