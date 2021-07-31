import os, parseopt, osproc, strformat, strutils, options, tables,
       terminal,sequtils, times, strformat, parsecfg, sugar

import util, repl, edit, server, config, compile, cmd/help

type 
  Cmd* = tuple[short: string, long: string, desc: string]
  Opt* = tuple[short: string, long: string, desc: string]

const CMDS* = [
  ("b", "build", "Build a project or compile a file"),
  ("r", "run ", "Run a .ie file or project"),
  ("c", "config", "Configure idle settings"),
  ("e", "edit", "Run the idle editor"),
  ("h", "help", "Show the help/docs in terminal"),
  ("d", "display", "Show the idle dashboard in terminal"),
  ("R", "repl", "Start the REPL"),
  ("n", "new ", "Start a new idle workspace")
]

const OPTS* = [
  ("d", "debug", "Add verbose debug log output of varying levels."),
  ("h", "help", "Print this help message, or by command"),
  ("c", "config", "Configure variables for idle settings"),
]

proc short*(cmd: Cmd): string =
  cmd[0]

# match proc for commands
template `->`* (arg: string, cmd: Cmd): bool =
  arg == cmd.short or  arg == cmd.long

proc help*(cmd: Cmd): void =
  eb "  - "
  ebGr &"{cmd.short}"
  er " or "
  eGr &"{cmd.long}   \t "
  echo &"{cmd.desc}"

# TODO should be string list
proc matchCmd*(args: string; cmd: Cmd) = 
  echo ""

proc echoHelp* = 
  welcomeMsg()

  eb "\nUSAGE:\n"; eb "\nCOMMANDS:\n"
  for cmd in CMDS: help cmd

  eb "\nFLAGS:\n"
  for opt in OPTS: help opt

  tipsMsg()


proc matchNewArgs*(name: string; config: Conf) =
  eb &"Creating new idle workspace {name}"

proc matchEditArgs*(file: string; config: Conf) =
  eb &"Starting idle edit instance for file {file}"

proc matchConfigArgs*(file: string; config: Conf) =
  eb &"Config"



# eventually return subcmd here
proc matchSubcmd(key: string, val:string, config: Conf) = 
  var cmd: Cmd;
  case key
  of "c", "config": 
    cmd = CMDS[0]
    ebBl &"Got config"
    matchConfigArgs val, config

  of "b" , "build": ebYe &"Got build command, file? {val}\n"
  of "r" , "run": ebGr &"Running {val}\n"
  of "n" , "new": 
    ebBl &"Creating new workspace {val}\n"
    matchNewArgs val, config
  of "e" , "edit":
    eGr &"Got edit command {val}\n"
    matchEditArgs val, config
  of "R" , "repl": ebRe &"Got REPL command\n"
  of "h" , "help":
    ebYe &"Got help command\n"
    echoHelp()
  else:
    echo "Unknwon command: ", key
    echoHelp()


# eventualy mutate config here (?)
proc matchOpts(key:string, val:string) =
  case key
  of "c" , "config":
    ebGr &"config {key} and {val}\n"
  of "r" , "verbose":
    ebGr &"Got verbose {key} and {val}\n"
  of "h" , "help":
    ebBl &"Got help {key} and {val}\n"
    echoHelp()
  else: 
    echo "Unknown option: ",key," and val ",val
    echoHelp()

template cmd*(cstr: string) =
  body

template `!=` (a, b: untyped): untyped =
  not (a == b)

proc matchArgs*(config: Conf) =
  var argCtr: int = 1;
  # const opts = initOptParser()
  for kind, key, val in getOpt():
    case kind
    of cmdArgument:
      if argCtr == 1: 
        matchSubcmd key, val, config
      else:
        continue
      argCtr.inc
    of cmdLongOption, cmdShortOption:
      matchOpts key, val
    of cmdEnd:
      ebYe "Cmd end"
      discard
      echoHelp()

