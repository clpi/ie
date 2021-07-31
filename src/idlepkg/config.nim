import re, os, strformat, strutils, tables

type 
  Config = ref object
    dict: OrderedTable[string, seq[string]]
    repl: ReplConfig
    conpiler: CompilerConfig

  CompilerConfig = ref object
    debug: bool

  ReplConfig = ref object
    color: bool
    prompt: string
    history: string
    indent: bool

proc init(): Config = 
  Config.default

proc configPath(): string = 
  let idle = getConfigDir().joinPath("idle")
  idle.createDir()

proc createFile(path: string): Config =
  Config.default

proc loadFile(path: string): Config = 
  Config.default
