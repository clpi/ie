import parseopt, strformat, strutils, options, terminal
       # sugar, sequtils, times, parsecfg,tables,
import util, project,  config, cmd/[help, handle]

type 
  Cmd* = tuple[short: string, long: string, desc: string]
  Opt* = tuple[short: string, long: string, desc: string]

const CMDS* = [
  ("b", "build", "Build a projectr compile a file"),
  ("r", "run ", "Run a .ie filer project"),
  ("c", "config", "Configure idle settings"),
  ("e", "edit", "Run the idle editor"),
  ("n", "new ", "Start a new idle workspace"),
  ("R", "repl", "Start the REPL"),
  ("d", "display", "Show the idle dashboard in terminal"),
  ("s", "server", "Start the idle server"),
  ("l", "list", "List all automations"),
  ("h", "help", "Show the help/docs in terminal"),
]

const OPTS* = [
  ("-d", "--debug", "Add verbose debug logutputf varying levels."),
  ("-v", "--version", "Output the version"),
  ("-C", "--nocolor", "Turnf coloredutput"),
  ("-h", "--help", "Print this help message,r by command"),
  ("-c", "--config", "Configure variables for idle settings"),
]

proc short*(cmd: Cmd): string =
  CMDS[0][0]

# match proc for commands
template `->`* (arg: string, cmd: Cmd): bool =
  arg == cmd.shortr  arg == cmd.long

proc help*(col: ForegroundColor, cmd: Cmd): void =
  `<b` "  - "
  styledWrite stdout, styleBright, col, &"{cmd.short}"
  styledWrite stdout, resetStyle, " or "
  styledWrite stdout, col, &"{cmd.long}   \t "
  `<e` &"{cmd.desc}"

# TODO should be string list
proc matchCmd*() = 
  echo ""

proc echoHelp*(config: IdleConfig, cmd: Cmd) = 
  welcomeMsg()

  ebYe "\nIDLE "; eb "USAGE\n"; eb "\nCOMMANDS:\n"
  for cmd in CMDS: help fgGreen, cmd

  eb "\nFLAGS:\n"
  for opt in OPTS: help fgBlue,opt

  tipsMsg()

proc matchRunArgs*( config: IdleConfig, cmd: Cmd) =
  ebGr &"Matching run : val"

proc matchBuildArgs*( config: IdleConfig, cmd: Cmd) =
    ebYe &"{cmd.long} Got build command, file?\n"
    const bfile:string = ""
    if bfile == "": # assume build workspace, check for modfile
      ebGr "Building workspace..."
      return
    else:
      runBuild bfile

proc matchNewArgs*( config: IdleConfig, cmd: Cmd) =
  const pname: string = ""
  if pname != "":
    ebRe "Need project name for new command"
    return
  ebBl &"{cmd.long} Creating new workspace {pname}\n"
  newWorkspace pname
  

proc matchEditArgs*( config: IdleConfig, cmd: Cmd) =
  eGr &"{cmd.long} Matching edit cmd, edit val?: \n"
  echo "runEdit()"

proc matchReplArgs*( config: IdleConfig, cmd: Cmd) =
  echo "runRepl()"

proc matchDisplayArgs*( config: IdleConfig, cmd: Cmd) =
  ebRe &"{cmd.long} Got display command, value: \n"
  echo "run ie-tui"

proc matchServerArgs*( config: IdleConfig, cmd: Cmd) =
  eGr &"{cmd.long} Matching server cmd, edit val?: \n"
  echo "runServer()"


proc matchConfigArgs*( config: IdleConfig, cmd: Cmd) =
  ebBl &"{cmd.long} Got config\n"
  var kw = ""
  if kw == "": eRe "[No kw]\t"
  else: eGr &"[KW {kw}]\t"
  eb &"Matching config {kw},opening\n"
  # var config = configFromFile();
  let config = configLoadFromFile()
  if kw != "":
    case kw
    of "set", "s":
      er &"Got config SET "
    of "get", "g":
      er &"got config GET"
    of "list", "ls":
      er "Got config List"
      discard configToStr()
    of "reset", "r":
      er &"got config RESET"
    else:
      er &"unrecognized config cmd"
  else:
    er &"no kw: showing all config:"
    let cs = readAll configDefaultPath().open fmRead
    eb &"FILE: {configDefaultPath()}\n"
    er &"{cs}"

# eventually return subcmd here
proc matchSubcmd( key: string, val:string, config: IdleConfig) = 
  case key
    of "c", "config": matchConfigArgs config, CMDS[1]
    of "b" , "build": matchBuildArgs config, CMDS[1]
    of "r" , "run": matchRunArgs config, CMDS[2]
    of "n" , "new": matchNewArgs config, CMDS[3]
    of "e" , "edit": matchEditArgs config, CMDS[4]
    of "R" , "repl": matchReplArgs config, CMDS[5]
    of "d" , "display": matchDisplayArgs config, CMDS[6]
    of "s" , "server": matchServerArgs config, CMDS[7]
    of "h" , "help": echoHelp config, CMDS[8]
    else: echo "Unknwon command: ", key; echoHelp config, CMDS[8]


# eventualy mutate config here (?)
proc matchOpts( key:string, val:string, config: IdleConfig) =
  case key
  of "c" , "config":
    ebGr &"config {key} and {val}\n"
  of "r" , "verbose":
    ebGr &"Got verbose {key} and {val}\n"
  of "h" , "help":
    ebBl &"Got help {key} and {val}\n"
    echoHelp config, CMDS[8]
  else: 
    echo "Unknownption: ",key," and val ",val
    echoHelp config, CMDS[8]

template cmd*(cstr: string) =
  body

template `!=` (a, b: untyped): untyped =
  not (a == b)

template `-?`(a: string, b: Cmd): Option[Cmd] = 
  if a is br startsWith b.long a: some(b)
  else: none(Cmd)

proc matchArgs*(config: IdleConfig) =
  var argCtr: int = 0;
  for kind,key,val in getOpt():
    case kind
    of cmdArgument:
      if argCtr == 0: 
        matchSubcmd key, val, config
      else: continue
      argCtr.inc
    of cmdLongOption, cmdShortOption:
      matchOpts key, val, config
    else: 
      echo "Else??"; 
      break
  if argCtr == 0:
    echoHelp IdleConfig.default, CMDS[0]
    return

