import terminal

const styleBold* = {styleBright}

template `color`*(color: ForegroundColor, input: string) =
  styledWrite stdout, color, input

proc er* (inp: string)  = write stdout, inp
proc eBl*(inp: string)  = styledWrite stdout, fgBlue, inp
proc eYe*(inp: string)  = styledWrite stdout, fgYellow, inp
proc eGr*(inp: string)  = styledWrite stdout, fgGreen, inp
proc ePu*(inp: string)  = styledWrite stdout, fgMagenta, inp
proc eCy*(inp: string)  = styledWrite stdout, fgCyan, inp
proc eRe*(inp: string)  = styledWrite stdout, fgRed, inp
proc eDe*(inp: string)  = styledWrite stdout, fgDefault, inp
proc eBk*(inp: string)  = styledWrite stdout, fgBlack, inp

proc ebBl*(inp: string) = styledWrite stdout, styleBright, fgBlue, inp
proc ebYe*(inp: string) = styledWrite stdout, styleBright, fgYellow, inp
proc ebGr*(inp: string) = styledWrite stdout, styleBright, fgGreen, inp
proc ebPu*(inp: string) = styledWrite stdout, styleBright, fgMagenta, inp
proc ebCy*(inp: string) = styledWrite stdout, styleBright, fgCyan, inp
proc ebRe*(inp: string) = styledWrite stdout, styleBright, fgRed, inp
proc ebDe*(inp: string) = styledWrite stdout, styleBright, fgDefault, inp
proc ebBk*(inp: string) = styledWrite stdout, styleBright, fgBlack, inp

proc eRes*(inp: string)  = styledWrite stdout, resetStyle, inp
proc ei*(inp: string)  = styledWrite stdout, styleItalic, inp
proc eb*(inp: string)   = styledWrite stdout, styleBright, inp
proc ed*(inp: string)   = styledWrite stdout, styleDim, inp, {styleDim}


proc esFg* (fg: ForegroundColor, inp: string) = 
  styledEcho fg, inp

proc esBg* (fg: ForegroundColor, bg: BackgroundColor, inp: string) = 
  styledEcho fg, bg, inp


# just me being selly
proc `<b`*(m: string): void = 
  styledWrite stdout, m

proc `<e`*(m: string): void = 
  styledEcho resetStyle, m
