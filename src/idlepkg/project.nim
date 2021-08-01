import os, strutils

type Project* = object
  name: string
  absoluteDir: string
  bin: bool

proc newWorkspace*(name: string) =
  let pdir = joinPath(getCurrentDir(), name)
  try:
    createDir pdir
    echo "Created " & pdir
  except OSError:
    echo "Failed to create dir"

proc runBuild*(path: string) =
  let inp = readFile path


