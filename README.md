<p align="center">
 <img src="https://hsto.org/webt/jj/z4/-o/jjz4-ofmx_k18yeslacjnjuzrve.png" width="128" alt="icon">
</p>

# Linter for markdown <sub><sup>| with presets</sup></sub>

![Release][badge_release]
[![Build][badge_ci]][link_actions]
[![Build][badge_build]][link_hub]
[![Docker Pulls][badge_pulls]][link_hub]
[![Issues][badge_issues]][link_issues]
[![License][badge_license]][link_license]

This repository contains source files of docker image (and [GitHub action][github_actions_doc]) for markdown files linting. Additionally, we provide setting _(rules)_ for the most useful cases, like changelog file linting.

All docker images always can be found on **[this page][link_hub_tags]**.

## Usage

This image contains [markdownlint-cli2][markdownlint-cli2] (node-js) and:

- Additional rules for `changelog` file linting _(`/lint/rules/changelog.js`)_
- Configuration file for `changelog` file linting _(it uses additional linting rules, `/lint/config/changelog.yml`)_

> Major image tag can be updated in any time.

`markdownlint-cli2` relies on [markdown-lint configuration](https://github.com/DavidAnson/markdownlint/blob/main/README.md#configuration) and thus does not offer special configuration files and relies on [glob patterns] only. More details can be found [on the project page][markdownlint-cli2].

For using special rule files, there is `markdownlint-cli2-config`.
For triggering automatic fixing, there is `markdownlint-cli2-fix`.

### Environment variables

Some linter execution options can be passed through environment variables _(multiple variables usage are allowed)_:

Environment variable    | Interpretation
----------------------- | --------------
`INPUT_CONFIG=/bar.yml` | `markdownlint-cli2-config /bar.yml ...`
`INPUT_FIX=true`        | Execute `markdownlint-cli2-fix ...`
`DEBUG=true`            | Output environment variables and the calculated arguments

Note that due to the design on `markdownlint-cli2`, `INPUT_CONFIG` and `INPUT_FIX` are mutually exclusive.

### Docker

For example, you can lint your `CHANGELOG.md` file using following command:

```bash
$ docker run --rm \
    -v "$(pwd)/CHANGELOG.md:/CHANGELOG.md:ro" \
    avtodev/markdown-lint:v1 \
    --rules /lint/rules/changelog.js \
    --config /lint/config/changelog.yml \
    /CHANGELOG.md
```

or

```bash
$ docker run --rm \
    -v "$(pwd)/CHANGELOG.md:/CHANGELOG.md:ro" \
    -e INPUT_RULES=/lint/rules/changelog.js \
    -e INPUT_CONFIG=/lint/config/changelog.yml \
    avtodev/markdown-lint:v1 \
    /CHANGELOG.md
```

### GitHub Actions

```yaml
jobs:
  lint-changelog:
    name: Lint changelog file
    runs-on: ubuntu-latest
    steps:
    - name: Check out code
      uses: actions/checkout@v2

    - name: Lint changelog file
      uses: docker://avtodev/markdown-lint:v1 # fastest way
      with:
        rules: '/lint/rules/changelog.js'
        config: '/lint/config/changelog.yml'
        args: './CHANGELOG.md'
        ignore: './one_file.md ./another_file.md' # multiple files must be separated with single space

    # Or using current repository as action:

    - name: Lint changelog file
      uses: avto-dev/markdown-lint@v1
      with:
        rules: '/lint/rules/changelog.js'
        config: '/lint/config/changelog.yml'
        args: './CHANGELOG.md'
```

### License

MIT. Use anywhere for your pleasure.

[badge_release]:https://img.shields.io/github/v/release/avto-dev/markdown-lint?include_prereleases&style=flat-square&maxAge=10
[badge_ci]:https://img.shields.io/github/workflow/status/avto-dev/markdown-lint/CI?style=flat-square&maxAge=10
[badge_pulls]:https://img.shields.io/docker/pulls/avtodev/markdown-lint.svg?style=flat-square&maxAge=30
[badge_issues]:https://img.shields.io/github/issues/avto-dev/markdown-lint.svg?style=flat-square&maxAge=30
[badge_build]:https://img.shields.io/docker/cloud/build/avtodev/markdown-lint.svg?style=flat-square&maxAge=30
[badge_license]:https://img.shields.io/github/license/avto-dev/markdown-lint.svg?style=flat-square&maxAge=30
[link_hub]:https://hub.docker.com/r/avtodev/markdown-lint/
[link_hub_tags]:https://hub.docker.com/r/avtodev/markdown-lint/tags
[link_license]:https://github.com/avto-dev/markdown-lint/blob/master/LICENSE
[link_issues]:https://github.com/avto-dev/markdown-lint/issues
[link_actions]:https://github.com/avto-dev/markdown-lint/actions
[markdownlint-cli2]:https://github.com/DavidAnson/markdownlint-cli2
[github_actions_doc]:https://help.github.com/en/actions
[glob patterns]:https://github.com/sindresorhus/globby#globbing-patterns

<!-- markdownlint-disable-file MD033 MD041 -->
