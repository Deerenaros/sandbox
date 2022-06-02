# Fill with requests

## Conditions

There is web-server at localhost:5000 with set of endpoints:

* GET /api/token -> {"success": "error|ok", "token": [A-Z0-9]}
* POST /api/<TOKEN>/add key=[_a-z0-9] content=[*] -> {"success": "error|ok", "key": "[_a-z0-9]"}
* GET /api/<TOKEN>/get/<key=[_a-z0-9]> -> content
* GET /api/<TOKEN>/list -> html page with links to added contents

and set of files with subset of markdown syntax.

## Task

Fill server with html content from markdown files. Keys should be taken from the first first-level header.

## Requirements

Any of thoose tools are applicable:

* python 3.5+
* golang
* bash/busybox+ (mv/cp/find/sort/uniq/tail/*sum/etc)
* pandoc or else is also can be usefull

If not livecoding it should be another (commited or built) container image with `solution.sh` script inside as entrypoint. The image can be stored at any kind.

## DoD-

Just fill with script server without converting markdown files.

## DoD

Any valid script if server filled with set of pages (given token would be enought).

## DoD+

Number of md-files can be up to 1 billion. Solution should support interrupting and continue with logging.

## Code analysis

There are also little `server.py`. Check and report one to:

* security issues
* lifecycle limitations
* any other errors or remarks
