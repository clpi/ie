import os, strformat, strutils, options, streams, parsecfg, tables
import util

type
  IdleConfig* = object
    config*: Config

  IdleSet* = object
    opts*: Table[string, string]
    cmds*: Table[string, string]
    auto*: Table[string, string]

  CompilerConfig =  object
    config*: Config
    debug: bool

  ReplConfig =  object
    color: bool
    prompt: string
    history: string
    indent: bool

proc newConfig* = 
  echo ""

proc configDir*: string = 
  result = getConfigDir() / "idle"
  discard existsOrCreateDir result

proc configDefaultStr*: string = 
  let gen = "history false\ndebug false\n"
  let user = "[user]\ndisplay\nname\n"
  let server = "[server]\nport 2738"
  &"{gen}{user}{server}"

proc configDefaultPath*: string = 
  configDir() / "config.toml"

proc configDelete* =
  removeFile configDefaultPath()


# Load config from filestream

proc configLoadFromFile*: IdleConfig = 
  var cFile = open(configDefaultPath(), fmRead)
  for l in lines cFile:
    case l
    of  "test": echo ""
    else: echo $l
  close cFile
  default IdleConfig


proc initConfig*: IdleConfig= 
  result = configLoadFromFile()
  # var cf = configLoadFileStream()
  # if cf != nil: 
  #   return cf
  # else: default IdleConfig
  # default IdleConfig

proc configTable*(name: string): Config = 
  loadConfig configDir() / name

proc configLoadFileStream*(): IdleConfig=
  var f = configDefaultPath().newFileStream fmRead
  var conf = default IdleConfig
  if f == nil:
    ebRe &"ERR: Cannot open {configDefaultPath()}"
    return
  var p: CfgParser
  p.open(f, configDefaultPath())
  while true:
    var e = next p
    case e.kind
    of cfgEof: break
    of cfgSectionStart:
      case e.section
      of "user":
        echo ""
      of "workspaces":
        echo ""
      of "logs":
        echo ""
      of "editor":
        echo ""
      of "ui":
        echo ""
      of "repl":
        echo ""
      of "compiler":
        echo ""
      of "server":
        echo ""
      eGr &"New section: {e.section}"
    of cfgKeyValuePair:
      eYe &"KV pair: {e.key}, {e.value}"
    of cfgOption:
      eBl &"Command: {e.key}, {e.value}"
    of cfgError:
      ebRe &"ERROR: {e.msg}"
  close p
  return conf
