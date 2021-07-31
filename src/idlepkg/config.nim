import re, os, strformat, strutils, tables, options

type 
  Conf* = ref object
    repl: ReplConfig
    conpiler: CompilerConfig

  CompilerConfig = ref object
    debug: bool

  ReplConfig = ref object
    color: bool
    prompt: string
    history: string
    indent: bool

proc configDir*(): string = 
  joinPath getConfigDir(), "idle"

proc configDefault*(): string = 
  let gen = "history false\ndebug false\n"
  let user = "[user]\ndisplay\nname\n"
  let server = "[server]\nport 2738"
  &"{gen}{user}{server}"

proc configFile*(): string = 
  discard existsOrCreateDir configDir()
  joinpath configDir(), "config.toml"

proc configFromFile*(): Option[Conf] =
  if existsFile configFile():
    return some(default Conf)
  writeFile configFile(), configDefault()
  return some(default Conf)


proc initConfig*(): Conf = 
  var config = configFromFile()
  if isSome config:
    return get config
  else: 
    default Conf
