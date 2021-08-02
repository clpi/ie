# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import iecomp/config

type
  ParseCtx = enum
    inParens, endParse


when isMainModule:
  echo "compiler module"
