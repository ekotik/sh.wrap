---
title: Pool of tasks
date: 2022-05-21T04:04:13+03:00
aliases:
  - /project/todo/todo.md
  - /project/todo/todo.org
url: /project/todo/todo.html
---

sh.wrap (project tasks)
=======================

1.  Code: sh.wrap (project tasks)

    1.  Code: core (project tasks)

        1.  NEXT \[\#A\] Add PoC prototype with somewhat core functionality

            **DEADLINE:** *\<2022-11-05 Sat\>* **SCHEDULED:** *\<2022-11-01 Tue\>*
            \<2022-10-31 Mon\>

2.  Docs: sh.wrap (project tasks)

    1.  NEXT Add README

    2.  NEXT Pass conversion options and command line arguments to pandoc-convert workflow

        \<2022-11-05 Sat\>

        1.  GOAL org-to-md.sh and pandoc-convert workflow \[0/5\]

            -   \[ \] extensions sets
                -   \[ \] clean set (-raw\_attribute...)
                -   \[ \] line break set (+hard\_line\_breaks...)
            -   \[ \] command-line arguments
                -   \[ \] --wrap=auto\|none\|preserve
                -   \[ \] --shift-heading-level-by=NUMBER
            -   \[ \] default sets of options enabled by default
            -   \[ \] rest command line options (by user request)
            -   \[ \] rest pandoc extensions (by user request)

    3.  Docs: Documentation system (project tasks)

        1.  NEXT \[\#C\] Describe documentation system

            \<2022-10-31 Mon\>

3.  Infra: sh.wrap (project tasks)

    1.  NEXT Add repository\_dispatch events to trigger documentation rebuild

        \<2022-10-30 Sun\>

    2.  Use ready docker images in GH actions (project tasks)

        1.  NEXT Create GH actions to use docker images from docker hub

            \<2022-10-31 Mon\>

4.  Plan: sh.wrap (project tasks)

    1.  Plan: Milestone 0.0.1 (project tasks):

        1.  NEXT Milestone 0.0.1: Select tasks from current active/backlog/stuck task pools

    2.  Plan: Roadmap (project tasks)

        1.  NEXT Write requirements for milestone 0.0.1

            <span id="wrfm001"></span>

5.  QA: sh.wrap (project tasks)

    1.  NEXT \[\#B\] Add issue/pr templates

sh.wrap (project backlog)
=========================

1.  Code: sh.wrap (project backlog)

    1.  <span class="todo TODO">TODO</span> Implement ccache module

    2.  <span class="todo TODO">TODO</span> Implement cert module

    3.  <span class="todo TODO">TODO</span> Implement config module

    4.  <span class="todo TODO">TODO</span> Implement git module

    5.  <span class="todo TODO">TODO</span> Implement path module

    6.  <span class="todo TODO">TODO</span> Implement repo module

        1.  <span class="todo TODO">TODO</span> Implement github module

        2.  <span class="todo TODO">TODO</span> Implement gitlab module

    7.  <span class="todo TODO">TODO</span> Implement scheduler module

    8.  <span class="todo TODO">TODO</span> Implement test module

        1.  <span class="todo TODO">TODO</span> Implement profile module

    9.  Code: core (project backlog)

        1.  NEXT Add function to scope

        2.  NEXT Add script for bashrc

2.  Docs: sh.wrap (project backlog)

    1.  NEXT Add license

    2.  NEXT Fix code blocks not colored properly with hugo renderer

        \<2022-10-31 Mon\>

    3.  NEXT Rework gh-publish workflow

        \<2022-11-05 Sat\>

        1.  GOAL Add features to gh-publish script \[0/3\]

            -   \[ \] pass commit message as argument
            -   \[ \] add option to keep commits history
            -   \[ \] add tag to commit

    4.  <span class="todo TODO">TODO</span> Add option to exclude path patterns from conversion in pandoc-convert workflow

        \<2022-11-05 Sat\>

    5.  <span class="todo TODO">TODO</span> Fix hugo bug with flickering project/docs tag

        \<2022-11-05 Sat\>

    6.  WRITE Describe knowledge system for the project

    7.  WRITE Describe useful workflows on the project

    8.  Docs: Documentation system (project backlog)

        1.  NEXT Describe documentation generation

            \<2022-10-31 Mon\>

3.  Infra: sh.wrap (project backlog)

    1.  NEXT Add repository\_dispatch action to generate documentation on the fly

        \<2022-11-05 Sat\>

    2.  <span class="todo TODO">TODO</span> Add nodejs workflow

        \<2022-11-05 Sat\>

        1.  <span class="todo TODO">TODO</span> Cache node\_modules in docsy site generation

            \<2022-11-05 Sat\>

    3.  <span class="todo TODO">TODO</span> Add spell checker action for project documentation

        \<2022-05-22 Sun\>

    4.  <span class="todo TODO">TODO</span> Make universal docker workflow and action

        \<2022-11-05 Sat\>

        1.  GOAL Docker workflows and actions \[0/2\]

            -   \[ \] one universal workflow and action to all tasks
            -   \[ \] workflow/action parameters
                -   \[ \] all parameters are serialized in one file (like workflow tests do)
                -   \[ \] no workaround when rest arguments are passed as string to parse

    5.  <span class="todo TODO">TODO</span> Write script to sync working repositories with upstream

    6.  Use ready docker images in GH actions (project backlog)

        1.  NEXT Create GH actions to generate and push docker images

            \<2022-10-31 Mon\>

4.  Plan: sh.wrap (project backlog)

    1.  <span class="todo TODO">TODO</span> Describe sh.wrap purpose and vision

        <span id="dswpav"></span>

    2.  <span class="todo TODO">TODO</span> Write project review/report templates

    3.  Plan: Milestone 0.0.1 (project backlog):

        1.  NEXT Milestone 0.0.1: Estimate tasks effort

        2.  <span class="todo TODO">TODO</span> Milestone 0.0.1: Schedule tasks

        3.  <span class="todo TODO">TODO</span> Milestone 0.0.1: Update roadmap

            1.  DEPENDENCY [Write requirements for milestone 0.0.1](#wrfm001)

    4.  Plan: Roadmap (project backlog)

        1.  NEXT Create roadmap diagram

        2.  DEPENDENCY [Describe sh.wrap purpose and vision](#dswpav)

5.  QA: sh.wrap (project backlog)

    1.  NEXT Review pr\#9

    2.  NEXT Write tests for core functions

    3.  <span class="todo TODO">TODO</span> Describe GH issue/pr workflows (life-cycle)

        \<2022-05-21 Sat\>

    4.  <span class="todo TODO">TODO</span> Describe issue/test/release verification processes

        \<2022-05-21 Sat\>

    5.  <span class="todo TODO">TODO</span> \[\#C\] Exploratory testing of site generation action

        \<2022-05-21 Sat\>

sh.wrap (project stuck)
=======================

1.  Code: sh.wrap (project stuck)

2.  Docs: sh.wrap (project stuck)

3.  Infra: sh.wrap (project stuck)

4.  Plan: sh.wrap (project stuck)

5.  QA: sh.wrap (project stuck)

sh.wrap (project goals)
=======================

1.  Code: sh.wrap (project goals)

    1.  GOAL Collection of useful shell scripts \[0/2\]

        -   \[ \] gpg functions
        -   \[ \] git functions

    2.  GOAL Maintainable shell scripts repository \[0/3\]

        -   \[ \] Shell scripts are at known locations
        -   \[ \] Shell scripts are reusable
        -   \[ \] Shell scripts have versions

sh.wrap (project archive)
=========================

1.  Code: sh.wrap (project archive)

2.  Docs: sh.wrap (project archive)

    1.  <span class="done DONE">DONE</span> Add auto-generation of project documentation

        **CLOSED:** *\[2022-11-05 Sat 16:12\]* **DEADLINE:** *\<2022-10-31 Mon\>* **SCHEDULED:** *\<2022-10-31 Mon\>*
        \<2022-10-31 Mon\>

        1.  COMPLETE [Rework org to markdown scripts and workflows](#rotmsaw)

            **CLOSED:** *\[2022-11-05 Sat 14:09\]*

    2.  <span class="done DONE">DONE</span> Add basic hugo templates and site config

        **CLOSED:** *\[2022-10-29 Sat 10:24\]* **DEADLINE:** *\<2022-05-21 Sat\>*
        \<2022-05-21 Sat\>

    3.  <span class="done DONE">DONE</span> Add styling for hugo site

        **CLOSED:** *\[2022-10-31 Mon 05:17\]*
        \<2022-05-21 Sat\>

    4.  <span class="done DONE">DONE</span> Choose and describe documentation system for the project

        **CLOSED:** *\[2022-10-31 Mon 05:14\]* **SCHEDULED:** *\<2022-05-21 Sat\>*

    5.  <span class="done DONE">DONE</span> Delete org files from repositories

        **CLOSED:** *\[2022-10-17 Mon 17:41\]* **DEADLINE:** *\<2022-10-17 Mon\>* **SCHEDULED:** *\<2022-10-17 Mon\>*
        \<2022-10-17 Mon\>

    6.  <span class="done DONE">DONE</span> Fix org-to-md output directory not found

        **CLOSED:** *\[2022-11-05 Sat 18:18\]*

    7.  <span class="done DONE">DONE</span> Fix: title and date parameters not exposed in in org-\>md export

        **CLOSED:** *\[2022-10-31 Mon 11:34\]*
        \<2022-05-21 Sat\>

3.  Infra: sh.wrap (project archive)

    1.  <span class="done DONE">DONE</span> Actions to export project documentation to GH pages

        **CLOSED:** *\[2022-10-29 Sat 10:24\]* **DEADLINE:** *\<2022-05-21 Sat\>* **SCHEDULED:** *\<2022-05-21 Sat\>*
        1.  <span class="done DONE">DONE</span> Create GH docker action to build hugo binary

            **CLOSED:** *\[2022-06-05 Sun 23:37\]* **SCHEDULED:** *\<2022-05-21 Sat\>*
            1.  <span class="done DONE">DONE</span> Add cache to hugo build action

                **CLOSED:** *\[2022-06-05 Sun 23:37\]*

        2.  <span class="done DONE">DONE</span> Create GH docker action to generate documentation

            **CLOSED:** *\[2022-06-05 Sun 23:37\]* **SCHEDULED:** *\<2022-05-21 Sat\>*

        3.  <span class="done DONE">DONE</span> Create a branch for GH docker action to build hugo binary

            **CLOSED:** *\[2022-06-05 Sun 23:29\]* **SCHEDULED:** *\<2022-05-21 Sat\>*

        4.  <span class="done DONE">DONE</span> Create a branch for GH docker action to generate documentation

            **CLOSED:** *\[2022-06-05 Sun 23:28\]* **SCHEDULED:** *\<2022-05-21 Sat\>*

    2.  <span class="done DONE">DONE</span> Add actions docker images to docker hub

        **CLOSED:** *\[2022-11-02 Wed 10:51\]* **DEADLINE:** *\<2022-11-01 Tue\>* **SCHEDULED:** *\<2022-10-31 Mon\>*
        \<2022-10-31 Mon\>

    3.  <span class="done DONE">DONE</span> Add docker image for hugo site generation

        **CLOSED:** *\[2022-10-29 Sat 10:24\]* **DEADLINE:** *\<2022-05-21 Sat\>*
        \<2022-05-21 Sat\>

    4.  <span class="done DONE">DONE</span> Check scripts and images in docker.org file

        **CLOSED:** *\[2022-10-30 Sun 16:02\]* **DEADLINE:** *\<2022-10-30 Sun\>* **SCHEDULED:** *\<2022-10-30 Sun\>*
        \<2022-10-30 Sun\>

    5.  <span class="done DONE">DONE</span> Create a branch for project tracking

        **CLOSED:** *\[2022-05-13 Fri 22:42\]* **SCHEDULED:** *\<2022-05-13 Fri\>*

    6.  <span class="done DONE">DONE</span> Create infra account on docker hub

        **CLOSED:** *\[2022-11-01 Tue 10:01\]* **DEADLINE:** *\<2022-11-01 Tue\>* **SCHEDULED:** *\<2022-10-31 Mon\>*
        \<2022-10-31 Mon\>

    7.  <span class="done DONE">DONE</span> Rework org to markdown scripts and workflows <span id="rotmsaw"></span>

        **CLOSED:** *\[2022-11-05 Sat 14:05\]* **DEADLINE:** *\<2022-10-31 Mon\>* **SCHEDULED:** *\<2022-10-31 Mon\>*
        \<2022-10-31 Mon\>

        1.  PASS Convert documentation from org to markdown \[4/6\]

            **CLOSED:** *\[2022-11-05 Sat 14:05\]*
            -   \[X\] convert whole directory
            -   \[-\] pass wanted default convertion options
                -   \[X\] clean
                -   \[ \] raw
            -   \[ \] pass additional convertion options as rest arguments
            -   \[X\] docker image for pandoc conversions
            -   \[X\] GH reusable workflow that wraps this script
            -   \[X\] Change existing GH workflows to use new script

        2.  <span class="done DONE">DONE</span> Remove conversion funcs from hugo-site workflow and script

            **CLOSED:** *\[2022-11-05 Sat 13:58\]* **DEADLINE:** *\<2022-11-05 Sat\>* **SCHEDULED:** *\<2022-11-05 Sat\>*
            \<2022-11-05 Sat\>

4.  Plan: sh.wrap (project archive)

    1.  <span class="done DONE">DONE</span> Fix project documentation not included in site generation

        **CLOSED:** *\[2022-10-30 Sun 16:02\]* **DEADLINE:** *\<2022-10-30 Sun\>* **SCHEDULED:** *\<2022-10-30 Sun\>*
        \<2022-10-30 Sun\>

5.  QA: sh.wrap (project archive)

    1.  <span class="done DONE">DONE</span> Review pr\#11

        **CLOSED:** *\[2022-10-30 Sun 12:23\]*
