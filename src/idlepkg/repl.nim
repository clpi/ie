import terminal, os
import cmd, util, config

proc replDataDir(): string = 
  let dir = getAppDir().joinPath "idle"
  discard existsOrCreateDir dir
  dir

proc replHistoryFile(): string = 
  replDataDir().joinPath "hist"

proc addToReplHistory(inp: string): void = 
  let histFile = replHistoryFile().open fmAppend
  write histfile, inp


proc replWelcomeMsg*() =
  ebGr "Welcome to the "
  ebBl "idle REPL.\n"
  styledEcho styleBright, "- Evaluate", resetStyle, " idlescript in the REPL to quickly construct automations and channels."
  er "- Version: "; ebGr "v0.1.0-alpha.0"; er " (last updated "; eBl " July 31, 2021"; er ")\n"
  styledEcho "- Press ", fgGreen, "CTRL+C", resetStyle, " at any time to quit.\n"

proc printReplHelp() =
  replWelcomeMsg()

proc runRepl* =
  replWelcomeMsg()
  while true:
    styledWrite stdout, fgGreen, styleBold, "idle > ", resetStyle
    var rep = readLine stdin
    case rep
    of "ls": ebBl "LS!\n"
    of "cat": ebBl "CAT!\n"
    of "help", "h", "--help", "-h":
      printReplHelp()
    of "exit", "quit", "q", "close":
      break
    else:
      ebBl "Got "; echo rep
  styledEcho styleBold, fgGreen,"Closed out of the idle REPL." 


