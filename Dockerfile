FROM davidanson/markdownlint-cli2:0.4.0

LABEL \
    # Docs: <https://github.com/opencontainers/image-spec/blob/master/annotations.md>
    org.opencontainers.image.title="Markdown linter" \
    org.opencontainers.image.description="Markdown linter with rules and settings presetts" \
    org.opencontainers.image.url="https://github.com/avto-dev/markdown-lint" \
    org.opencontainers.image.source="https://github.com/avto-dev/markdown-lint" \
    org.opencontainers.image.vendor="avto-dev" \
    org.opencontainers.image.licenses="MIT"

# We need "bash" for shopt (used in docker-entrypoint.sh)
USER root
RUN apk add --no-cache bash

USER node

# copy additional image files
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY lint /lint

ENTRYPOINT ["bash", "/docker-entrypoint.sh"]
