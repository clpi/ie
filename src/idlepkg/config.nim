import re, os, strformat, strutils, tables

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

proc init*(): Conf = 
  default Conf

proc configPath*(): string = 
  let configFile = getConfigDir().joinPath "idle"
  createDir configFile
  configFile

proc createFile*(path: string): Conf =
  default Conf

proc loadConfig*(path: string): Conf = 
  let confStr = readAll open configPath()
  echo confstr
  default Conf
