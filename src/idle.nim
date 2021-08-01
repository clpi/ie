
import idlepkg/config, idlepkg/util, idlepkg/cmd
import os,  strformat, strutils

const DEBUG = true

proc `<->`*(a, b:string): bool =
  a == b

proc main(config: IdleConfig) = 
  if DEBUG:
    echo &"[DEBUG] Config directory: {configDir()}, exists: {dirExists configDir()}"
    echo &"[DEBUG] Config file: {configDefaultPath()}, exists: {fileExists configDefaultPath()} "
  matchArgs config
  # print_help()

when isMainModule:
  main configLoadFromFile()




