---
title: Docker images and scripts
date: 2022-10-26T05:20:14+03:00
aliases:
  - /actions/docker/docker.md
  - /actions/docker/docker.org
url: /actions/docker/docker.html
---

# Docker image for sh.wrap testing

## Build docker image

``` bash
<<common-variables>>
```

``` {#dockerfile-test .bash}
DOCKERFILE_TEMPLATE="$DOCKERFILES_PATH"/"test-shellcheck.Dockerfile"
DOCKER_IMAGE="shwrap:test-shellcheck"
DOCKER_PATH=$(realpath "../../../")
DOCKERFILE="$DOCKER_PATH"/"test-shellcheck.Dockerfile"
```

\`ubuntu:latest\` with \`shellcheck\` is a base image to run tests for
sh.wrap.

``` {.dockerfile tangle="../../../docker/test-shellcheck.Dockerfile" eval="no"}
FROM ubuntu:latest as build

RUN apt update
RUN apt install --yes bash
RUN apt install --yes shellcheck

FROM build

COPY "${DOCKERFILE_SCRIPTS_PATH}"/entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
CMD ["${WORK_DIR}", "${SCRIPT}", "${ARGS}"]
```

``` bash
env -i \
    DOCKERFILES_PATH="$DOCKERFILES_PATH" \
    DOCKERFILE_SCRIPTS_PATH="$DOCKERFILE_SCRIPTS_PATH" \
    bash "${DOCKERFILE_SCRIPTS_PATH}"/dockerfile.sh "$DOCKERFILE_TEMPLATE" "$DOCKERFILE"
```

Build and tag an image.

``` {#build .bash results="code"}
docker build -t "$DOCKER_IMAGE" -f "$DOCKERFILE" "$DOCKER_PATH" --no-cache
docker tag "$DOCKER_IMAGE" "$DOCKER_REPO"/"$DOCKER_IMAGE"
```

## Push to Docker Hub (optionally)

``` {.bash eval="query"}
docker push "$DOCKER_REPO"/"$DOCKER_IMAGE"
```

## Test runner

``` {.bash tangle="no"}
LIVE_OR_DIE=live
LIVE_DEBUG=1
```

``` {.bash eval="no"}
<<preamble>>

<<options>>

<<options-debug>>
```

``` bash
<<help>>

<<live-or-die-trap>>

<<gh-mode>>
```

Help.

``` bash
help-test() {
    printf "Usage: %s: <SRCDIR...>" "$0"
    help echo "$@"
}

# greetings for github runner
echo '::notice::Shellcheck action started!' | gh_echo
```

Set up parameters.

``` {.bash tangle="no"}
dirs=("../../../test")
```

Check parameters.

``` {.bash eval="no"}
if [[ $# -eq 0 ]]; then
    echo >&2 "No source directories specified"
    help-test "$@"
fi

declare -a dirs
if [[ "$gh_mode" == 1 ]]; then
    readarray -t -d $'\n' dirs < <(echo -e "$@")
else
    dirs+=("$@")
fi
```

``` bash
echo '::group::Shellcheck action' | gh_echo
```

Scan for shell scripts.

``` bash
# scan for `sh` files in specified directories
files=()

for src_dir in "${dirs[@]}"; do
    while IFS=$'\0' read -d $'\0' -r src_file; do
        files+=("$src_file")
    done < <(find ./"$src_dir" -name '*.sh' -print0)
done
```

Shellcheck run.

``` bash
# run shellcheck
LAST_ERROR="No shell scripts for checking are found"
[[ "${#files[@]}" != 0 ]] || $live_or_die
{
    ret=$( shellcheck -f gcc "${files[@]}" >&3
           echo $? );
} 3>&1
```

``` bash
echo '::endgroup::' | gh_echo
```

``` bash
if [[ $ret != 0 ]]; then
    echo '::error::Shellcheck failed' | gh_echo
else
    echo '::notice::Shellcheck passed' | gh_echo
fi

# goodbye
echo '::notice::Shellcheck action ended!' | gh_echo
```

``` {.bash eval="no"}
exit "$ret"
```

## Run

### Run script

``` bash
script="../../../src/test-shellcheck.sh"
args="../../../test ../../../src"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 \
    bash "$script" ${args}
```

``` bash
args="../../../test
../../../src"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 LIVE_OR_DIE=live GH_MODE=1 \
    bash "$script" "$args"
```

### Run docker

``` bash
<<common-variables>>
<<dockerfile-test>>
```

``` bash
work_dir="/github/workspace"
script="$work_dir"/src/test-shellcheck.sh
args="test"
```

``` {.bash eval="query"}
docker run -it --rm --name shwrap-test \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$args"
```

``` bash
args="test
src"
```

``` {.bash eval="query"}
docker run -it --rm --name shwrap-test \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 -eLIVE_OR_DIE=live -eGH_MODE=1 \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$args"
```

### Run action

#### Template

``` {.json tangle="../../../test/workflow/data/test-shellcheck/01.json"}
{
  "ref": "${REF}",
  "inputs":
  {
    "run_id": "${RUN_ID}",
    "payload":
    {
      "dockerfile_template": "${DOCKERFILE_TEMPLATE}",
      "dockerfile": "${DOCKERFILE}",
      "work_dir": "${WORK_DIR}",
      "script": "${SCRIPT}",
      "args": "${ARGS}"
    }
  }
}
```

#### Data

``` {.bash tangle="../../../test/workflow/data/test-shellcheck/01/01.sh"}
#!/bin/bash
# shellcheck disable=SC2034

export WORKFLOW_ID="37075164"
export REF="actions"
export RUN_ID="test-shellcheck/01/01"
export DOCKERFILE_TEMPLATE="./_actions/docker/test-shellcheck.Dockerfile"
export DOCKERFILE="test-shellcheck.Dockerfile"
export WORK_DIR="/github/workspace/_actions"
export SCRIPT="./src/test-shellcheck.sh"
export ARGS="./src"
```

#### Test

``` bash
GITHUB_REPO="antirs/sh.wrap"
bash ../../../test/workflow/test-workflows.sh "$GITHUB_REPO" ../../../test/workflow/data/test-shellcheck
```

# Docker image for go build

## Build docker image

``` bash
<<common-variables>>
```

``` {#dockerfile-go-build .bash}
DOCKERFILE_TEMPLATE="$DOCKERFILES_PATH"/"go-build.Dockerfile"
DOCKER_IMAGE="shwrap:go-build"
DOCKER_PATH=$(realpath "../../../")
DOCKERFILE="$DOCKER_PATH"/"go-build.Dockerfile"
```

``` {.dockerfile tangle="../../../docker/go-build.Dockerfile" eval="no"}
FROM ubuntu:latest as build

RUN apt update
RUN apt install --yes bash
RUN apt install --yes git
RUN apt install --yes golang
RUN apt install --yes make

FROM build as hugo-build

COPY "${DOCKERFILE_SCRIPTS_PATH}"/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
CMD ["${WORK_DIR}", "${SCRIPT}", "${GIT_PATH}", "${GIT_REPO}", "${ARGS}"]
```

``` bash
env -i \
    DOCKERFILES_PATH="$DOCKERFILES_PATH" \
    DOCKERFILE_SCRIPTS_PATH="$DOCKERFILE_SCRIPTS_PATH" \
    bash "${DOCKERFILE_SCRIPTS_PATH}"/dockerfile.sh "$DOCKERFILE_TEMPLATE" "$DOCKERFILE"
```

``` {.bash results="code"}
docker build -t "$DOCKER_IMAGE" -f "$DOCKERFILE" "$DOCKER_PATH" --no-cache
docker tag "$DOCKER_IMAGE" "$DOCKER_REPO"/"$DOCKER_IMAGE"
```

## Push to Docker Hub (optionally)

``` {.bash eval="query"}
docker push "$DOCKER_REPO"/"$DOCKER_IMAGE"
```

## Go build

``` {.bash tangle="no"}
LIVE_OR_DIE=live
LIVE_DEBUG=1
```

``` {.bash eval="no"}
<<preamble>>

<<options>>

<<options-debug>>
```

``` bash
<<help>>

<<live-or-die-trap>>

<<git-trap>>

<<cd-trap>>

<<gh-mode>>
```

Help.

``` bash
help-go-build() {
    printf "Usage: %s: <GITPATH> <GITREPO> <GITHASH> [BUILDARGS...]\n" "$0"
    help "$@"
}

# greetings for github runner
echo '::notice::Go build action started!' | gh_echo
```

Set up parameters.

``` {.bash tangle="no"}
git_path=$(realpath "../../../")
git_repo="https://github.com/gohugoio/hugo"
git_hash="bfebd8c02cfc0d4e4786e0f64932d832d3976e92"
build_args="--tags\\nextended"
```

Check parameters.

``` {.bash eval="no"}
# check parameters
if [[ $# -eq 0 ]]; then
    echo >&2 "No git repository destination specified"
    help-go-build "$@"
fi

if [[ $# -eq 1 ]]; then
    echo >&2 "No git repository url specified"
    help-go-build "$@"
fi

if [[ $# -eq 2 ]]; then
    echo >&2 "No git commit hash specified"
    help-go-build "$@"
fi

# check working directory
git_path=$(realpath "$1")
git_repo="$2"
git_hash="$3"
shift 3

declare -a build_args
if [[ "$gh_mode" == 1 ]]; then
    readarray -t -d $'\n' build_args < <(echo -e "$@")
else
    build_args+=("$@")
fi
```

``` bash
LAST_ERROR="Working directory is invalid"
[[ -d "$git_path" ]] || $live_or_die
```

Set up hugo parameters.

``` bash
git_repo_dir=$(realpath "$git_path"/"${git_repo##*/}")
export GOPATH="$git_repo_dir"/.go
export GOCACHE="$git_repo_dir"/.cache
```

Clone and configure repository.

``` bash
echo '::group::Clone repository' | gh_echo
```

``` bash
LAST_ERROR="Git repository safe.directory configuration failed"
# fixes go build with -buildvcs option in unsafe git directories
GIT_DIR=.nogit git config --global --add safe.directory "$git_repo_dir" || $live_or_die

# clone go repo
mkdir -p "$git_repo_dir" || $live_or_die
git -C "$git_repo_dir" init || $live_or_die
git -C "$git_repo_dir" remote add origin "$git_repo" || $live_or_die
git -C "$git_repo_dir" pull --depth=1 origin "$git_hash"
```

``` bash
echo '::endgroup::' | gh_echo
```

Build go binary.

``` bash
echo '::group::Build go binary' | gh_echo
```

``` bash
# build hugo
LAST_ERROR="Change directory to '${git_repo_dir}' failed"
pushd "$git_repo_dir" || $live_or_die

LAST_ERROR="Go build failed"
{
    if [[ -f Makefile ]]; then
        make -k -B
    else
        go build -ldflags "-s -w" "${build_args[@]}"
    fi
} || $live_or_die

popd
```

``` bash
echo '::endgroup::' | gh_echo
```

``` bash
# goodbye
echo '::notice::Go build action ended!' | gh_echo
```

## Run go builds

### Run hugo build

#### Run script

``` bash
work_dir="/github/workspace"
script="../../../src/go-build.sh"
git_path=$(realpath "../../../")
git_repo="https://github.com/gohugoio/hugo"
git_hash="bfebd8c02cfc0d4e4786e0f64932d832d3976e92"
build_args="--tags\nextended"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 \
    bash "$script" "$git_path" "$git_repo" "$git_hash" "$build_args"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 LIVE_OR_DIE=live GH_MODE=1 \
    bash "$script" "$git_path" "$git_repo" "$git_hash" "$build_args"
```

#### Run docker

``` bash
<<common-variables>>
<<dockerfile-go-build>>
```

``` bash
work_dir="/github/workspace"
script="$work_dir"/src/go-build.sh
git_path="$work_dir"
git_repo="https://github.com/gohugoio/hugo"
git_hash="bfebd8c02cfc0d4e4786e0f64932d832d3976e92"
```

``` {.bash eval="query"}
docker run -it --rm --name shwrap-hugo-build \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$git_path" "$git_repo" "$git_hash"
```

``` {.bash eval="query"}
docker run -it --rm --name shwrap-hugo-build \
    --volume $(realpath `pwd`/../../../):/github/workspace \
    -eLIVE_DEBUG=1 -eLIVE_OR_DIE=live -eGH_MODE=1 \
    "$DOCKER_REPO"/"$DOCKER_IMAGE" \
    "$work_dir" "$script" "$git_path" "$git_repo" "$git_hash"
```

### Run gh build

#### Run script

``` bash
work_dir="../../../"
script="../../../src/go-build.sh"
git_path="../../../"
git_repo="https://github.com/cli/cli"
git_hash="7d71f807c48600d0d8d9f393ef13387504987f1d"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 \
    bash "$script" "$git_path" "$git_repo" "$git_hash"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 LIVE_OR_DIE=live GH_MODE=1 \
    bash "$script" "$git_path" "$git_repo" "$git_hash"
```

#### Run docker

``` bash
<<common-variables>>
<<dockerfile-go-build>>
```

``` bash
work_dir="/github/workspace"
script="$work_dir"/src/go-build.sh
git_path="$work_dir"
git_repo="https://github.com/cli/cli"
git_hash="7d71f807c48600d0d8d9f393ef13387504987f1d"
```

``` {.bash eval="query"}
docker run -it --rm --name shwrap-gh-build \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$git_path" "$git_repo" "$git_hash"
```

``` {.bash eval="query"}
docker run -it --rm --name shwrap-gh-build \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 -eLIVE_OR_DIE=live -eGH_MODE=1 \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$git_path" "$git_repo" "$git_hash"
```

#### Run action

1.  Template

    ``` {.json tangle="../../../test/workflow/data/go-build/01.json"}
    {
      "ref": "${REF}",
      "inputs":
      {
        "run_id": "${RUN_ID}",
        "payload":
        {
          "dockerfile_template": "${DOCKERFILE_TEMPLATE}",
          "dockerfile": "${DOCKERFILE}",
          "work_dir": "${WORK_DIR}",
          "script": "${SCRIPT}",
          "git_path": "${GIT_PATH}",
          "git_repo": "${GIT_REPO}",
          "git_hash": "${GIT_HASH}",
          "build_args": "${BUILD_ARGS}",
          "go_bin": "${GO_BIN}",
          "use_cache": ${USE_CACHE}
        }
      }
    }
    ```

2.  Data

    ``` {.bash tangle="../../../test/workflow/data/go-build/01/01.sh"}
    #!/bin/bash
    # shellcheck disable=SC2034

    export WORKFLOW_ID="37075163"
    export REF="actions"
    export RUN_ID="go-build/01/01"
    export DOCKERFILE_TEMPLATE="./_actions/docker/go-build.Dockerfile"
    export DOCKERFILE="go-build.Dockerfile"
    export WORK_DIR="/github/workspace"
    export SCRIPT="./_actions/src/go-build.sh"
    export GIT_PATH="./"
    export GIT_REPO="https://github.com/cli/cli"
    export GIT_HASH="7d71f807c48600d0d8d9f393ef13387504987f1d"
    export BUILD_ARGS=""
    export GO_BIN="./cli/bin"
    export USE_CACHE=true
    ```

3.  Test

    ``` bash
    GITHUB_REPO="antirs/sh.wrap"
    bash ../../../test/workflow/test-workflows.sh "$GITHUB_REPO" ../../../test/workflow/data/go-build
    ```

# Docker image for documentation

## Build docker image

``` bash
<<common-variables>>
```

``` {#dockerfile-hugo-site .bash}
DOCKERFILE_TEMPLATE="$DOCKERFILES_PATH"/"hugo-site.Dockerfile"
DOCKER_IMAGE="shwrap:hugo-site"
DOCKER_PATH=$(realpath "../../../")
DOCKERFILE="$DOCKER_PATH"/"hugo-site.Dockerfile"
```

``` {.dockerfile tangle="../../../docker/hugo-site.Dockerfile" eval="no"}
FROM ubuntu:latest as build

RUN apt update
RUN apt install --yes bash
RUN apt install --yes curl
RUN apt install --yes git
RUN apt install --yes golang
RUN apt install --yes pandoc
RUN mkdir /go
COPY "${HUGO_BIN_SOURCE}" "${HUGO_BIN_DEST}"

FROM build as hugo-site

COPY "${DOCKERFILE_SCRIPTS_PATH}"/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
CMD ["${WORK_DIR}", "${SCRIPT}", "${HUGO_BIN_DEST}", "${DOCS_DIR}", "${SITE_DIR}", "${PUBLIC_DIR}"]
```

``` bash
env -i \
    DOCKERFILES_PATH="$DOCKERFILES_PATH" \
    DOCKERFILE_SCRIPTS_PATH="$DOCKERFILE_SCRIPTS_PATH" \
    HUGO_BIN_SOURCE="./hugo/hugo" \
    HUGO_BIN_DEST="/go/hugo" \
    bash "${DOCKERFILE_SCRIPTS_PATH}"/dockerfile.sh "$DOCKERFILE_TEMPLATE" "$DOCKERFILE"
```

``` {.bash results="code"}
docker build -t "$DOCKER_IMAGE" -f "$DOCKERFILE" "$DOCKER_PATH" --no-cache
docker tag "$DOCKER_IMAGE" "$DOCKER_REPO"/"$DOCKER_IMAGE"
```

## Push to Docker Hub (optionally)

``` {.bash eval="query"}
docker push "$DOCKER_REPO"/"$DOCKER_IMAGE"
```

## Hugo site

``` {.bash tangle="no"}
LIVE_OR_DIE=live
LIVE_DEBUG=1
```

``` {.bash eval="no"}
<<preamble>>

<<options>>

<<options-debug>>
```

``` bash
<<help>>

<<live-or-die-trap>>

<<gh-mode>>
```

Help.

``` {#help-hugo-site .bash}
help-hugo-site() {
    printf "Usage: %s: <HUGOPATH> <DOCSDIR> <SITEDIR> <PUBLICDIR>\n" "$0"
    help "$@"
}
```

``` bash
# greetings for github runner
echo '::notice::Hugo site action started!' | gh_echo
```

Set up parameters.

``` {.bash tangle="no"}
hugo_bin=$(realpath "../../../hugo/hugo")
docs_dir=$(realpath "../../../test/hugo-site/")
site_dir=$(realpath "$docs_dir"/site)
public_dir=$(realpath "$site_dir"/public)
```

Check parameters.

``` {#check-hugo-site .bash eval="no"}
# check parameters
if [[ $# -eq 0 ]]; then
    echo >&2 "No hugo binary path specified"
    help-hugo-site "$@"
fi

if [[ $# -eq 1 ]]; then
    echo >&2 "No documentation directory specified"
    help-hugo-site "$@"
fi

if [[ $# -eq 2 ]]; then
    echo >&2 "No site directory specified"
    help-hugo-site "$@"
fi

if [[ $# -eq 3 ]]; then
    echo >&2 "No publish directory specified"
    help-hugo-site "$@"
fi

hugo_bin=$(realpath "$1")
docs_dir=$(realpath "$2")
site_dir=$(realpath "$3")
public_dir=$(realpath "$4")
```

``` bash
# check paths
LAST_ERROR="hugo binary not found"
[[ -f "$hugo_bin" ]] || $live_or_die
LAST_ERROR="documentation directory not found"
[[ -d "$site_dir" ]] || $live_or_die
```

Generate documentation.

``` bash
<<org-to-md>>
```

``` bash
# generate documentation
LAST_ERROR="generating documentation failed"
while IFS= read -d $'\0' -r page; do
    page_out="${page/${docs_dir}\//}"
    page_dir="${page_out%/*}"
    section_dir=""
    if [[ "$page_dir" != "$page_out" ]]; then
        section_dir="$page_dir"
    fi

    mkdir -p "$site_dir"/content/"$section_dir" || true 2> /dev/null
    org_to_md "$page" 1 > "$site_dir"/content/"${page_out%.org}".md
done < <(find "$docs_dir" -name '*.org' -print0)
```

Hugo.

``` bash
echo '::group::Generate hugo site' | gh_echo
# hugo run
chmod u+x "$hugo_bin"
{ pushd "$site_dir"; "$hugo_bin" mod get -u; popd; } || $live_or_die
"$hugo_bin" -s "$site_dir" -d "$public_dir" || $live_or_die
echo '::endgroup::' | gh_echo
```

``` bash
# goodbye
echo '::notice::Hugo site action ended!' | gh_echo
```

### Docsy site

``` {.bash tangle="no"}
LIVE_OR_DIE=live
LIVE_DEBUG=1
```

``` {.bash eval="no"}
<<preamble>>

<<options>>

<<options-debug>>
```

``` bash
<<help>>

<<live-or-die-trap>>

<<gh-mode>>
```

Help.

``` bash
help-docsy-site() {
    printf "Usage: %s: <HUGOPATH> <DOCSDIR> <SITEDIR> <PUBLICDIR>\n" "$0"
    help "$@"
}

# greetings for github runner
echo '::notice::Docsy site export started!' | gh_echo
```

Check parameters.

``` {.bash eval="no"}
# check parameters
if [[ $# -eq 0 ]]; then
    echo >&2 "No arguments specified"
    help-docsy-site "$@"
fi
```

``` bash
<<help-hugo-site>>
<<check-hugo-site>>
```

``` bash
LAST_ERROR="docsy site export failed"
echo '::group::Install docsy theme dependencies' | gh_echo
nvm &> /dev/null || git clone --depth=1 -b v0.39.2 https://github.com/nvm-sh/nvm ~/.nvm || $live_or_die
# shellcheck disable=SC1090
source ~/.nvm/nvm.sh
nvm use 18 || { nvm install 18; nvm use 18; } || $live_or_die
# get npm modules
pushd "${site_dir}/themes/docsy"
npm install || $live_or_die
popd
npm install --save-dev autoprefixer postcss-cli postcss || $live_or_die
echo '::endgroup::' | gh_echo
```

Run generation script.

``` {.bash eval="no"}
bash "${DOCKERFILE_SCRIPTS_PATH}"/hugo-site.sh  "$hugo_bin" "$docs_dir" "$site_dir" "$public_dir"
```

``` bash
# goodbye
echo '::notice::Docsy site export ended!' | gh_echo
```

## Run

### Run script

``` bash
<<common-variables>>
```

``` bash
hugo_bin="../../../hugo/hugo"
docs_dir="../../../test/hugo-site/"
site_dir="$docs_dir"/site
public_dir="$site_dir"/public
```

#### Hugo

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 \
    bash ../../../src/hugo-site.sh "$hugo_bin" "$docs_dir" "$site_dir" "$public_dir"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 LIVE_OR_DIE=live GH_MODE=1 \
    bash ../../../src/hugo-site.sh "$hugo_bin" "$docs_dir" "$site_dir" "$public_dir"
```

#### Docsy

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 \
    bash ../../../src/docsy-site.sh "$hugo_bin" "$docs_dir" "$site_dir" "$public_dir"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 LIVE_OR_DIE=live GH_MODE=1 DOCKERFILE_SCRIPTS_PATH="${DOCKERFILE_SCRIPTS_PATH}" \
    bash ../../../src/docsy-site.sh "$hugo_bin" "$docs_dir" "$site_dir" "$public_dir"
```

### Run docker

``` bash
<<common-variables>>
<<dockerfile-hugo-site>>
```

``` bash
work_dir="/github/workspace"
script="$work_dir"/src/hugo-site.sh
hugo_bin="$work_dir"/hugo/hugo
docs_dir="$work_dir"/doc
site_dir="$docs_dir"/site
public_dir="$site_dir"/public
```

``` {.bash eval="query"}
docker run -it --rm --name shwrap-hugo-site \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$hugo_bin" "$docs_dir" "$site_dir" "$public_dir"
```

``` {.bash eval="query"}
docker run -it --rm --name shwrap-hugo-site \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 -eLIVE_OR_DIE=live -eGH_MODE=1 \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$hugo_bin" "$docs_dir" "$site_dir" "$public_dir"
```

### Run action

#### Template

``` {.json tangle="../../../test/workflow/data/hugo-site/01.json"}
{
  "ref": "${REF}",
  "inputs":
  {
    "run_id": "${RUN_ID}",
    "payload":
    {
      "dockerfile_template": "${DOCKERFILE_TEMPLATE}",
      "dockerfile": "${DOCKERFILE}",
      "work_dir": "${WORK_DIR}",
      "script": "${SCRIPT}",
      "hugo_bin_source": "${HUGO_BIN_SOURCE}",
      "hugo_bin_dest": "${HUGO_BIN_DEST}",
      "hugo_bin_path": "${HUGO_BIN_PATH}",
      "hugo_repo": "${HUGO_REPO}",
      "hugo_hash": "${HUGO_HASH}",
      "hugo_build_args": "${HUGO_BUILD_ARGS}",
      "docs_dir": "${DOCS_DIR}",
      "site_dir": "${SITE_DIR}",
      "public_dir": "${PUBLIC_DIR}",
      "public_cache": "${PUBLIC_CACHE}"
    }
  }
}
```

#### Data

``` {.bash tangle="../../../test/workflow/data/hugo-site/01/01.sh"}
#!/bin/bash
# shellcheck disable=SC2034

export WORKFLOW_ID="37469369"
export REF="actions"
export RUN_ID="hugo-site/01/01"
export DOCKERFILE_TEMPLATE="./_actions/docker/hugo-site.Dockerfile"
export DOCKERFILE="hugo-site.Dockerfile"
export WORK_DIR="/github/workspace"
export SCRIPT="./_actions/src/hugo-site.sh"
export HUGO_BIN_SOURCE="./hugo/hugo"
export HUGO_BIN_DEST="/go/hugo"
export HUGO_BIN_PATH="./hugo"
export HUGO_REPO="https://github.com/gohugoio/hugo"
export HUGO_HASH="bfebd8c02cfc0d4e4786e0f64932d832d3976e92"
export HUGO_BUILD_ARGS="--tags\\nextended"
export DOCS_DIR="./test/hugo-site"
export SITE_DIR="./test/hugo-site/site"
export PUBLIC_DIR="./_actions/public"
export PUBLIC_CACHE="hugo-site-01-01"
```

#### Test

``` bash
GITHUB_REPO="antirs/sh.wrap"
bash ../../../test/workflow/test-workflows.sh "$GITHUB_REPO" ../../../test/workflow/data/hugo-site
```

# Docker image for git tasks

## Build docker image

``` bash
<<common-variables>>
```

``` {#dockerfile-git-tasks .bash}
DOCKERFILE_TEMPLATE="$DOCKERFILES_PATH"/"git-tasks.Dockerfile"
DOCKER_IMAGE="shwrap:git-tasks"
DOCKER_PATH=$(realpath "../../../")
DOCKERFILE="$DOCKER_PATH"/"git-tasks.Dockerfile"
```

``` {.dockerfile tangle="../../../docker/git-tasks.Dockerfile" eval="no"}
FROM ubuntu:latest as build

RUN apt update
RUN apt install --yes ca-certificates
RUN apt install --yes bash
RUN apt install --yes curl
RUN apt install --yes gettext
RUN apt install --yes git
RUN apt install --yes jq
RUN mkdir /go
COPY "${GH_BIN_SOURCE}" "${GH_BIN_DEST}"

FROM build as git-tasks

COPY "${DOCKERFILE_SCRIPTS_PATH}"/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
CMD ["${WORK_DIR}", "${SCRIPT}", "${GH_BIN_DEST}", "${ARGS}"]
```

``` bash
env -i \
    DOCKERFILES_PATH="$DOCKERFILES_PATH" \
    DOCKERFILE_SCRIPTS_PATH="$DOCKERFILE_SCRIPTS_PATH" \
    GH_BIN_SOURCE="./cli/bin/gh" \
    GH_BIN_DEST="/go/gh" \
    bash "${DOCKERFILE_SCRIPTS_PATH}"/dockerfile.sh "$DOCKERFILE_TEMPLATE" "$DOCKERFILE"
```

``` {.bash results="code"}
docker build -t "$DOCKER_IMAGE" -f "$DOCKERFILE" "$DOCKER_PATH" --no-cache
docker tag "$DOCKER_IMAGE" "$DOCKER_REPO"/"$DOCKER_IMAGE"
```

## Push to Docker Hub (optionally)

``` {.bash eval="query"}
docker push "$DOCKER_REPO"/"$DOCKER_IMAGE"
```

## GH publish

``` {.bash tangle="no"}
LIVE_OR_DIE=live
LIVE_DEBUG=1
```

``` {.bash eval="no"}
<<preamble>>

<<options>>

<<options-debug>>
```

``` bash
<<help>>

<<live-or-die-trap>>

<<gh-mode>>

<<xtrace>>
```

Help.

``` bash
help-gh-publish() {
    printf "Usage: %s: <GHPATH> <GHPAGESREPO> <GHPAGESBRANCH> <PUBLICDIR>\n" "$0"
    help "$@"
}

echo '::notice::GH publish action started!' | gh_echo
```

Set up parameters.

``` {.bash tangle="no"}
gh_bin=$(realpath "../../../cli/bin/gh")
gh_pages_repo="file:///home/enomem/REPO/REMOTE/github.com/antirs/sh.wrap.git"
gh_pages_branch="gh-pages"
public_dir=$(realpath "./site/public")
```

Check parameters.

``` {.bash eval="no"}
# check parameters
if [[ $# -eq 0 ]]; then
    echo >&2 "No gh binary path specified"
    help-gh-publish "$@"
fi

if [[ $# -eq 1 ]]; then
    echo >&2 "No gh-pages repository specified"
    help-gh-publish "$@"
fi

if [[ $# -eq 2 ]]; then
    echo >&2 "No gh-pages branch specified"
    help-gh-publish "$@"
fi

if [[ $# -eq 3 ]]; then
    echo >&2 "No publish directory specified"
    help-gh-publish "$@"
fi

gh_bin=$(realpath "$1")
gh_pages_repo="$2"
gh_pages_branch="$3"
public_dir=$(realpath "$4")
```

Authentication token for github pages.

``` {.bash tangle="no"}
read -s -p 'Enter token: ' gh_token
```

``` {.bash eval="no" padline="no"}
reset_xtrace
gh_token="${GITHUB_TOKEN}"
restore_xtrace
```

``` bash
# check paths
LAST_ERROR="gh binary not found"
[[ -f "$gh_bin" ]] || $live_or_die
LAST_ERROR="publish directory not found"
[[ -d "$public_dir" ]] || $live_or_die
# check token
LAST_ERROR="authentication token is empty"
reset_xtrace
[[ -n "$gh_token" ]] || $live_or_die
restore_xtrace
```

Authenticate.

``` bash
# authenticate with token
LAST_ERROR="authentication failed"
chmod u+x "$gh_bin"
unset GITHUB_TOKEN
GIT_DIR=.nogit "$gh_bin" auth login --git-protocol https --with-token <<< "$gh_token"
GIT_DIR=.nogit "$gh_bin" auth setup-git
```

``` bash
echo '::group::Push site to GH pages' | gh_echo
```

Publish to gh-pages (on push event).

``` bash
# publish site
if [[ "$GITHUB_EVENT_NAME" == "push" ]] || [[ "$GITHUB_EVENT_NAME" == "workflow_dispatch" ]]; then
    LAST_ERROR="publish site failed"
    pushd "$public_dir"
    git init
    git config --global --add safe.directory "$public_dir" || $live_or_die
    git config user.name "gh-publish action"
    git config user.email "nobody@nowhere"
    git checkout -b "$gh_pages_branch" || $live_or_die
    git remote add -t "$gh_pages_branch" "origin" "$gh_pages_repo" || $live_or_die
    git add .
    git commit --allow-empty -m "pages: update gh pages" \
        --author="gh-publish action <nobody@nowhere>" || $live_or_die
    git push "origin" "$gh_pages_branch" --force || $live_or_die
    popd
fi
```

``` bash
echo '::endgroup::' | gh_echo
```

``` bash
echo '::notice::GH publish action ended!' | gh_echo
```

## Git submodules update

``` {.bash tangle="no"}
LIVE_OR_DIE=live
LIVE_DEBUG=1
```

``` {.bash eval="no"}
<<preamble>>

<<options>>

<<options-debug>>
```

``` bash
<<help>>

<<live-or-die-trap>>

<<gh-mode>>

<<xtrace>>
```

Help.

``` bash
help-git-submodule() {
    printf "Usage: %s: <GHBIN> <GITREPO> <GITBRANCH> <GITDIR>\n" "$0"
    help "$@"
}

echo '::notice::git submodules update started!' | gh_echo
```

Set up parameters.

``` {.bash tangle="no"}
gh_bin=$(realpath "../../../cli/bin/gh")
git_repo="file:///home/enomem/REPO/REMOTE/github.com/antirs/antirs.github.io.git"
git_branch="main"
git_repo_dir=$(realpath "./antirs.github.io")
```

Check parameters.

``` {.bash eval="no"}
# check parameters
if [[ $# -eq 0 ]]; then
    echo >&2 "No gh binary path specified"
    help-git-submodule "$@"
fi

if [[ $# -eq 1 ]]; then
    echo >&2 "No git repository specified"
    help-git-submodule "$@"
fi

if [[ $# -eq 2 ]]; then
    echo >&2 "No git branch specified"
    help-git-submodule "$@"
fi

if [[ $# -eq 3 ]]; then
    echo >&2 "No git path specified"
    help-git-submodule "$@"
fi

gh_bin=$(realpath "$1")
git_repo="$2"
git_branch="$3"
git_repo_dir=$(realpath "$4")
```

Authentication token for github pages.

``` {.bash tangle="no"}
read -s -p 'Enter token: ' gh_token
```

``` {.bash eval="no" padline="no"}
reset_xtrace
gh_token="${GITHUB_TOKEN}"
restore_xtrace
```

``` bash
# check paths
LAST_ERROR="gh binary not found"
[[ -f "$gh_bin" ]] || $live_or_die
# check token
LAST_ERROR="authentication token is empty"
reset_xtrace
[[ -n "$gh_token" ]] || $live_or_die
restore_xtrace
```

Authenticate.

``` bash
# authenticate with token
LAST_ERROR="authentication failed"
chmod u+x "$gh_bin"
unset GITHUB_TOKEN
GIT_DIR=.nogit "$gh_bin" auth login --git-protocol https --with-token <<< "$gh_token"
GIT_DIR=.nogit "$gh_bin" auth setup-git
```

``` bash
echo '::group::Update git submodules' | gh_echo
```

Update git submodules (on push event).

``` bash
# update git submodules
LAST_ERROR="git submodules update failed"
git clone -b "$git_branch" "$git_repo" "$git_repo_dir" || $live_or_die
pwd
ls -al
pushd "$git_repo_dir"
ls -al
git config --global --add safe.directory "$git_repo_dir" || $live_or_die
git config user.name "git-submodule action"
git config user.email "nobody@nowhere"
git submodule update --init --force --remote --recursive
git add .
git commit --amend --allow-empty -m "actions: update git submodules" \
    --author="git-submodule action <nobody@nowhere>" || $live_or_die
git push "origin" "$git_branch" --force
popd
```

``` bash
echo '::endgroup::' | gh_echo
```

``` bash
echo '::notice::git submodules update ended!' | gh_echo
```

## Run git tasks

### Run gh publish

Authentication token for github pages.

``` {.bash tangle="no"}
read -s -p 'Enter token: ' gh_token
```

#### Run script

``` bash
gh_bin="../../../cli/bin/gh"
gh_repo="https://github.com/antirs/sh.wrap.git"
public_dir="./site/public"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 GITHUB_TOKEN="${gh_token}" GITHUB_EVENT_NAME="push" \
    bash gh-publish.sh "$gh_bin" "$gh_repo" "$public_dir"
```

``` {.bash eval="query"}
env -i LIVE_OR_DIE=live GH_MODE=1 GITHUB_TOKEN="${gh_token}" GITHUB_EVENT_NAME="push" \
    bash gh-publish.sh "$gh_bin" "$gh_repo" "$public_dir"
```

#### Run docker

``` bash
<<common-variables>>
<<dockerfile-git-tasks>>
<<xtrace>>
```

``` bash
work_dir="/github/workspace"
script="$work_dir"/src/gh-publish.sh
gh_bin="$work_dir"/cli/bin/gh
gh_repo="https://github.com/antirs/sh.wrap.git"
gh_branch="gh-pages/test"
public_dir="$work_dir"/doc/site/public
```

``` {.bash eval="query"}
reset_xtrace
docker run -it --rm --name shwrap-gh-publish \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 -eGITHUB_TOKEN="${gh_token}" -eGITHUB_EVENT_NAME="push" \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$gh_bin" "$gh_repo" "$gh_branch" "$public_dir"
restore_xtrace
```

``` {.bash eval="query"}
reset_xtrace
docker run -it --rm --name shwrap-gh-publish \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 -eLIVE_OR_DIE=live -eGH_MODE=1 -eGITHUB_TOKEN="${gh_token}" -eGITHUB_EVENT_NAME="push" \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$gh_bin" "$gh_repo" "$public_dir"
restore_xtrace
```

#### Run action

1.  Template

    ``` {.json tangle="../../../test/workflow/data/gh-publish/01.json"}
    {
      "ref": "${REF}",
      "inputs":
      {
        "run_id": "${RUN_ID}",
        "payload":
        {
          "dockerfile_template": "${DOCKERFILE_TEMPLATE}",
          "dockerfile": "${DOCKERFILE}",
          "work_dir": "${WORK_DIR}",
          "script": "${SCRIPT}",
          "gh_bin_source": "${GH_BIN_SOURCE}",
          "gh_bin_dest": "${GH_BIN_DEST}",
          "gh_bin_path": "${GH_BIN_PATH}",
          "gh_repo": "${GH_REPO}",
          "gh_hash": "${GH_HASH}",
          "gh_build_args": "${GH_BUILD_ARGS}",
          "gh_pages_repo": "${GH_PAGES_REPO}",
          "gh_pages_branch": "${GH_PAGES_BRANCH}",
          "public_dir": "${PUBLIC_DIR}",
          "public_cache": "${PUBLIC_CACHE}"
        }
      }
    }
    ```

2.  Data

    ``` {.bash tangle="../../../test/workflow/data/gh-publish/01/01.sh"}
    #!/bin/bash
    # shellcheck disable=SC2034

    export WORKFLOW_ID="37482756"
    export REF="actions"
    export RUN_ID="gh-publish/01/01"
    export DOCKERFILE_TEMPLATE="./_actions/docker/git-tasks.Dockerfile"
    export DOCKERFILE="git-tasks.Dockerfile"
    export WORK_DIR="/github/workspace"
    export SCRIPT="./_actions/src/gh-publish.sh"
    export GH_BIN_SOURCE="./cli/bin/gh"
    export GH_BIN_DEST="/go/gh"
    export GH_BIN_PATH="./cli/bin"
    export GH_REPO="https://github.com/cli/cli"
    export GH_HASH="7d71f807c48600d0d8d9f393ef13387504987f1d"
    export GH_BUILD_ARGS=""
    export GH_PAGES_REPO="https://github.com/antirs/sh.wrap"
    export GH_PAGES_BRANCH="gh-pages/test"
    export PUBLIC_DIR="./_actions/public"
    export PUBLIC_CACHE="gh-publish-01-01"
    ```

3.  Test

    ``` bash
    GITHUB_REPO="antirs/sh.wrap"
    bash ../../../test/workflow/test-workflows.sh "$GITHUB_REPO" ../../../test/workflow/data/gh-publish
    ```

### Run git submodules update

Authentication token for github pages.

``` {.bash tangle="no"}
read -s -p 'Enter token: ' gh_token
```

#### Run script

``` bash
#+begin_src bash :tangle no
gh_bin=$(realpath $(which gh))
git_repo="file:///home/enomem/REPO/REMOTE/github.com/antirs/antirs.github.io.git"
git_branch="gh-pages/sh.wrap"
git_path="./antirs.github.io"
```

``` {.bash eval="query"}
env -i LIVE_DEBUG=1 GITHUB_TOKEN="${gh_token}" GITHUB_EVENT_NAME="push" \
    bash update-submodules.sh "$gh_bin" "$git_repo" "$git_branch" "$git_path"
```

``` {.bash eval="query"}
env -i LIVE_OR_DIE=live GH_MODE=1 GITHUB_TOKEN="${gh_token}" GITHUB_EVENT_NAME="push" \
    bash update-submodules.sh "$gh_bin" "$git_repo" "$git_branch" "$git_path"
```

#### Run docker

``` bash
<<common-variables>>
<<dockerfile-git-tasks>>
<<xtrace>>
```

``` bash
work_dir="/github/workspace"
script="$work_dir"/src/update-submodules.sh
gh_bin="$work_dir"/cli/bin/gh
git_repo="https://github.com/antirs/sh.wrap"
git_branch="gh-pages/sh.wrap"
git_path="gh-pages-sh.wrap"
```

``` {.bash eval="query"}
reset_xtrace
docker run -it --rm --name shwrap-git-submodule \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 -eGITHUB_TOKEN="${gh_token}" -eGITHUB_EVENT_NAME="push" \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$gh_bin" "$git_repo" "$git_branch" "$git_path"
restore_xtrace
```

``` {.bash eval="query"}
reset_xtrace
docker run -it --rm --name shwrap-git-submodule \
       --volume $(realpath `pwd`/../../../):/github/workspace \
       -eLIVE_DEBUG=1 -eLIVE_OR_DIE=live -eGH_MODE=1 -eGITHUB_TOKEN="${gh_token}" -eGITHUB_EVENT_NAME="push" \
       "$DOCKER_REPO"/"$DOCKER_IMAGE" \
       "$work_dir" "$script" "$gh_bin" "$git_repo" "$git_branch" "$git_path"
restore_xtrace
```

#### Run action

1.  Template

    ``` {.json tangle="../../../test/workflow/data/update-submodules/01.json"}
    {
      "ref": "${REF}",
      "inputs":
      {
        "run_id": "${RUN_ID}",
        "payload":
        {
          "dockerfile_template": "${DOCKERFILE_TEMPLATE}",
          "dockerfile": "${DOCKERFILE}",
          "work_dir": "${WORK_DIR}",
          "script": "${SCRIPT}",
          "gh_bin_source": "${GH_BIN_SOURCE}",
          "gh_bin_dest": "${GH_BIN_DEST}",
          "gh_bin_path": "${GH_BIN_PATH}",
          "gh_repo": "${GH_REPO}",
          "gh_hash": "${GH_HASH}",
          "gh_build_args": "${GH_BUILD_ARGS}",
          "git_repo": "${GIT_REPO}",
          "git_branch": "${GIT_BRANCH}",
          "git_repo_dir": "${GIT_REPO_DIR}"
        }
      }
    }
    ```

2.  Data

    ``` {.bash tangle="../../../test/workflow/data/update-submodules/01/01.sh"}
    #!/bin/bash
    # shellcheck disable=SC2034

    export WORKFLOW_ID="37251119"
    export REF="actions"
    export RUN_ID="update-submodules/01/01"
    export DOCKERFILE_TEMPLATE="./_actions/docker/git-tasks.Dockerfile"
    export DOCKERFILE="git-tasks.Dockerfile"
    export WORK_DIR="/github/workspace/_actions"
    export SCRIPT="./src/update-submodules.sh"
    export GH_BIN_SOURCE="./cli/bin/gh"
    export GH_BIN_DEST="/go/gh"
    export GH_BIN_PATH="./cli/bin"
    export GH_REPO="https://github.com/cli/cli"
    export GH_HASH="7d71f807c48600d0d8d9f393ef13387504987f1d"
    export GH_BUILD_ARGS=""
    export GIT_REPO="https://github.com/antirs/sh.wrap"
    export GIT_BRANCH="gh-pages/sh.wrap"
    export GIT_REPO_DIR="gh-pages-sh.wrap"
    ```

3.  Test

    ``` bash
    GITHUB_REPO="antirs/sh.wrap"
    bash ../../../test/workflow/test-workflows.sh "$GITHUB_REPO" ../../../test/workflow/data/update-submodules
    ```