import os, strformat, strutils, options, streams, parsecfg, tables
import util

# Config for the idle workspace package
type
  IdleConfig* = object
    config*: Config

  IdleConfigUser* = enum
    cfUserName = "name"
    cfUserApiKey = "apiKey"
    cfUserEmail = "email"

proc configDir*: string = 
  result = getConfigDir() / "idle"
  discard existsOrCreateDir result

proc configDefaultPath*: string = 
  result = configDir() / "config.ini"
  if not fileExists result:
    writeFile result, ""

proc configLoadFromFile*: IdleConfig = 
  IdleConfig(config: loadConfig configDefaultPath())

proc configDelete* =
  removeFile configDefaultPath()

proc initConfig*: IdleConfig = 
  result = configLoadFromFile()

proc configToStr*(): string = 
  discard readAll open configDefaultPath()

proc iterConfig*: string = 
  var f  = configDefaultPath().newFileStream fmRead
  if f == nil:
    ebRe &"ERR: Cannot open {configDefaultPath()}"
    return
  var p: CfgParser
  p.open f, configDefaultPath()
  while true:
    var e = next p
    case e.kind
    of cfgEof: break
    of cfgSectionStart:
      case e.section
      of "user": echo "user"
      else: echo "base"
    of cfgKeyValuePair:
      echo fmt "kv {e.key} {e.value}"
    of cfgError:
      echo "error iter config"
    of cfgOption:
      echo fmt "opt {e.option}"
  
proc getBase*(self: IdleConfig, key: string): string =
  getSectionValue self.config, "", key

proc getUser*(self: IdleConfig, key: string): string =
  getSectionValue self.config, "user", key

proc setUserConf*(self: IdleConfig; key, val: string) =
  var cfg: Config = self.config
  setSectionKey cfg, "user", key, val
  writeConfig cfg, configDefaultPath()

proc setBaseConf*(self: IdleConfig; key, val: string) =
  var cfg: Config = self.config
  setSectionKey cfg, "", key, val
  writeConfig cfg, configDefaultPath()

proc rmSection*(self: IdleConfig, section: string) =
  var cfg: Config = self.config
  delSection cfg, section
  writeConfig cfg, configDefaultPath()

proc rmSectionKey*(self: IdleConfig; section, key: string) =
  var cfg: Config = self.config
  delSectionKey cfg, section, key
  writeConfig cfg, configDefaultPath()

proc getVal*(self: IdleConfig; section, key: string): string =
  getSectionValue self.config, section, key

proc defaultConfig*: IdleConfig = 
  var cfg = newConfig()
  setSectionKey cfg, "", "debug", "false"
  setSectionKey cfg, "", "charset", "utf-8"
  setSectionKey cfg, "user", "name", ""
  setSectionKey cfg, "user", "email", ""
  setSectionKey cfg, "user", "api-key", ""
  setSectionKey cfg, "projects", "path", ""
  setSectionKey cfg, "dashboard", "default-view", ""
  setSectionKey cfg, "repl", "path", ""
  writeConfig cfg, configDefaultPath()
  IdleConfig(config: cfg)







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

type 
  # experimental custom config syntax
  IdlegCfg* = object
    opts*: Table[string, string]
    cmds*: Table[string, string]
    keys*: Table[string, string]
    auto*: Table[string, string]

  IdleCfgTok* = enum
    icCmt = "~~"
    icMlCmtBegin = "~~!"
    icMlCmtEnd = "!~~"
    icBracketBegin = "["
    icBracketEnd = "]"

  CfgParserCtx* = enum
    icReadSection
    icReadBody

proc cfgDefaultStr*: string = 
  let gen = "history false\ndebug false\n"
  let user = "[user]\ndisplay\nname\n"
  let server = "[server]\nport 2738"
  &"{gen}{user}{server}"

proc cfgLoadFromFile*: IdleConfig = 
  var cFile = open(configDefaultPath(), fmRead)
  var currSection: string
  for ln in lines cFile:
    if ln.startsWith $icCmt:
      echo "Comment line "
    elif ln.startswith $icBracketBegin:
      echo "Section line "

    case ln
    of  "test": echo ""
    else: echo $ln
  close cFile
  default IdleConfig

