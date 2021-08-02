import std/[terminal, strformat, options]
import ../util

proc welcomeMsg* =
  ebGr "\nWELCOME to the "
  ebYe "idle";eGr " automation environment.\n"
  ebYe "  -";er " The ultimate personal automation hub and workspace. \n"
  ebYe "  -";er " Version: ";ebGr "[v0.1.0-alpha.0]\n"
  ebYe "  -";er " Last updated: ";ebBl "July 30, 2021\n" 
  ebYe "  -";er " Author ";eYe "Chris Pecunies "
  er "<clp@clp.is>\n"

proc tipsMsg* = 
  er "\n- Run ";ebYe "idle ";eGr "help ";eGr "<command>";er " for "
  ebYe "cmd-specific info.\n"
  er "- More help: ";ebYe "idle ";eGr "help ";eBl "--verbose"; echo ""

proc echoEditHelp* =
  eb "USAGE";er " (idle edit)"

proc echoReplHelp* =
  eb "USAGE";er " (idle repl)"

proc echoNewHelp* =
  eb "USAGE";er " (idle new)"

proc echoRunHelp* =
  eb "USAGE";er " (idle run)"

proc echoBuildHelp* =
  eb "USAGE";er " (idle build)"
