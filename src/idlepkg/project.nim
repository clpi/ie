import os, strutils

proc new*(name: string) =
  let pdir = joinPath(getCurrentDir(), name)
  try:
    createDir pdir
    echo "Created " & pdir
  except OSError:
    echo "Failed to create dir"

proc build*(path: string) =
  let inp = readFile path


