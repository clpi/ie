# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import idlepkg/config, idlepkg/util

import os, parseopt, osproc, strformat, strutils, terminal, 
       sequtils, times, strformat, parsecfg, sugar

proc repl() =
  while true:
    echo "e"

proc new(name: string) =
  let pdir = joinPath(getCurrentDir(), name)
  try:
    createDir pdir
    echo "Created " & pdir
  except OSError:
    echo "Failed to create dir"

proc build(path: string) =
  let inp = readFile path

proc print_help() = 
  ebGr "Welcome to ";ebBl "idle ";
  er "Version: ";ebGr "[v0.1.0-alpha.0]\n"
  er "Last updated: "; ebBl "July 30, 2021\n" 

  eb "\nCommands:\n"
  eb "  - "; ebGr "build \t ";echo "Build a new file"
  eb "  - "; ebGr "run   \t ";echo "Run a file"
  eb "  - "; ebGr "config\t ";echo "Change config"
  eb "  - "; ebGr "edit  \t ";echo "Run the editor"
  eb "  - "; ebGr "help  \t ";echo "Display this help"

  eb "\nFlags:\n"
  eb "  - ";eBl "-d";er " or "; eBl "--debug \t ";echo "Build a new file"
  eb "  - ";eBl "-h";er " or "; eBl "--help \t ";echo "Build a new file"
  eb "  - ";eBl "-c";er " or "; eBl "--config \t ";echo "Build a new file"

proc getArgs() =
  var argCtr: int = 1;
  for kind, key, val in getOpt():
    case kind
    of cmdArgument:
      echo "Got arg ", argCtr, ": \"", key, "\""
      argCtr.inc
    of cmdLongOption, cmdShortOption:
      case key
      of "b" , "config":
        setForegroundColor(fgYellow)
        styledEcho styleBold,"Got config",key,"and",val
      of "r" , "verbose":
        setForegroundColor(fgGreen)
        styledEcho styleBold,"Got verbose",key,"and",val
      of "h" , "help":
        setForegroundColor(fgBlue)
        ebBl "Got REPL"
      else: echo "Unknown option: ",key," and val ",val
    of cmdEnd:
      ebYe "Cmd end"
      discard


proc main(config: Config) = 
  for ii in 1..paramCount():
    echo "param ",ii, ": " & paramStr(ii)
  print_help()

main Config.default




