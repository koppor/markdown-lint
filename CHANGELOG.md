# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keepachangelog] and this project adheres to [Semantic Versioning][semver].

## [unreleased]

### Changed

- Switched from [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli#markdownlint-cli) to [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2#markdownlint-cli2), because a) it is faster and b) it is more closer to the VS Code extensions. [#17](https://github.com/avto-dev/markdown-lint/issues/17)
- Switch Docker base image to `davidanson/markdownlint-cli2:0.4.0`
- Collect all `CHANGELOG.md` linting configuration in `lint/changelog`

### Removed

- Remove `INPUT_RULES`. Rules have to be included via the `markdownlint-cli2.yaml` config file.
- Remove `INPUT_OUTPUT`. Output needs to be redirected normal shell pipe operations.
- Remove `INPUT_IGNORE`. Files to ignore have to be passed using glob patterns.

## v1.5.1 - 2021-09-10

### Fixed

- Docker image name in example part of `README.md`

## v1.5.0 - 2021-01-26

### Changed

- `markdownlint-cli` version updated up to `0.26.0` (from `0.23.2`)

### Fixed

- Multiple files ignoring (you can run current action `with: ignore: 'foo.md bar.md'` with space delimiter for multiple `--ignore` flag appending) [#7]

[#7]:https://github.com/avto-dev/markdown-lint/issues/7

## v1.4.0 - 2020-09-25

### Changed

- Base docker image changed from `node:13-alpine` to `mhart/alpine-node:slim-12` (more lightweight)
- `markdownlint-cli` version updated up to `0.23.2` (from `0.23.1`)
- `markdownlint` packed into single file in docker image

## v1.3.1 - 2020-07-27

### Fixed

- Quoting of `INPUT_*` env variables to allow multiple arguments in 1 env var

## v1.3.0 - 2020-06-19

### Added

- Support for globstar (`**`) by changing the shell to bash [#6]

[#6]:https://github.com/avto-dev/markdown-lint/pull/6

## v1.2.0 - 2020-05-28

### Added

- Support for Keep-a-Changelog's links in the heading [#4]
- Support for using en dashes instead of minus signs [#4]
- Support for passing multiple parameters to `markdown-lint` [#3]

## v1.1.0 - 2020-02-11

### Added

- Changelog rule `CHANGELOG-RULE-004` - Only one "unreleased" version header allowed

### Changed

- Changelog rule `CHANGELOG-RULE-004` enabled in changelog linter config `changelog.yml`

## v1.0.0 - 2020-01-18

### Changed

- First public release

## v0.0.2 - 2020-01-18

### Changed

- GitHub action parameter `path` renamed to `args`

## v0.0.1 - 2020-01-18

### Added

- Docker image auto-building
- Rules set (`CHANGELOG-RULE-001`, `CHANGELOG-RULE-002`, `CHANGELOG-RULE-003`) for changelog file linting
- Config file for changelog file linting

[keepachangelog]:https://keepachangelog.com/en/1.0.0/
[semver]:https://semver.org/spec/v2.0.0.html
[#3]:https://github.com/avto-dev/markdown-lint/pull/3
[#4]:https://github.com/avto-dev/markdown-lint/pull/4
