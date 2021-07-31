# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import idlepkg/config, idlepkg/util, idlepkg/cmd
import os, parseopt, osproc, strformat, strutils, 
       terminal,  sequtils, times, strformat, parsecfg, sugar



proc `<->`*(a, b:string): bool =
  a == b

proc main(config: Conf) = 
  matchArgs config
  # print_help()

when isMainModule:
  main Conf.default




