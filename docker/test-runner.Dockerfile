FROM bash:${BASH_DOCKER_VERSION} as build

RUN mkdir /te
COPY "${MICROSPEC_SOURCE}" "${MICROSPEC_DEST}"

FROM build as test-runner

COPY "${DOCKERFILE_SCRIPTS_PATH}"/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
CMD ["${WORK_DIR}", "${SCRIPT}", "${MICROSPEC_PATH}", "${MICROSPEC_EXEC}", "${MICROSPEC_ARGS}"]
