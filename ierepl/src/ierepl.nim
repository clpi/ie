import terminal, os
import "../../ielib/src"/[ielib]

type ReplCtx* = ref object
  hist: bool
  quit: bool

proc replDataDir(): string = 
  let dir = getAppDir().joinPath "idle"
  discard existsOrCreateDir dir
  dir

proc replHistoryFile(): string = 
  replDataDir().joinPath "hist"

proc addToReplHistory*(inp: string): void = 
  let histFile = replHistoryFile().open fmAppend
  write histfile, inp


proc replWelcomeMsg*() =
  styledWrite stdout, styleBright, fgGreen, "Welcome to the "
  styledWrite stdout, styleBright, fgBlue, "idle REPL.\n"
  styledEcho styleBright, "- Evaluate", resetStyle, " idlescript in the REPL to quickly construct automations and channels."
  write stdout, "- Version: "; 
  styledWrite stdout, styleBright, fgGreen, "v0.1.0-alpha.0"; 
  write stdout, " (last updated "
  styledWrite stdout, fgBlue, " July 31, 2021"
  write stdout, ")\n"
  styledEcho "- Press ", fgGreen, "CTRL+C", resetStyle, " at any time to quit.\n"

proc printReplHelp() =
  replWelcomeMsg()

proc runRepl* =
  replWelcomeMsg()
  let hist = replHistoryFile().open fmAppend
  while true:
    styledWrite stdout, fgGreen, styleBright, "idle > ", resetStyle
    var rep = readLine stdin
    write hist, rep
    case rep
    of "ls": styledWrite stdout, styleBright, fgBlue, "LS!\n"
    of "cat": styledWrite stdout, styleBright, fgBlue, "CAT!\n"
    of "help", "h", "--help", "-h":
      printReplHelp()
    of "exit", "quit", "q", "close":
      break
    else:
      styledWrite stdout, styleBright, fgBlue, "Got "; echo rep
  styledEcho styleBright, fgGreen,"Closed out of the idle REPL." 
  close hist



