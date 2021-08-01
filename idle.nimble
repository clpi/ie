# Package

version       = "0.1.0"
author        = "Chris Pecunies"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["idle"]
#             = @["idle-lsp", "idle-lsp", "idle-tui"]


# Dependencies

requires "nim >= 1.4.2"

task editor, "Run/compile the editor":
  echo("Compiling editor")

task test, "Perform all base idle tests":
  exec "nim c -r tests/test.nim"
