# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import idlepkg/config, idlepkg/util, idlepkg/cmd
import os,  strformat, strutils
       # terminal,  
       # sequtils, 
       # times, 
       # strformat, 
       # parsecfg, 
       # sugar

const DEBUG = true

proc `<->`*(a, b:string): bool =
  a == b

proc main(config: Conf) = 
  if DEBUG:
    echo &"[DEBUG] Config directory: {configDir()}, exists: {dirExists configDir()}"
    echo &"[DEBUG] Config file: {configFile()}, exists: {fileExists configFile()} "
  matchArgs config
  # print_help()

when isMainModule:
  main Conf.default




