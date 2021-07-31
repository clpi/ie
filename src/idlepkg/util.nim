import terminal

const styleBold* = {styleBlink, styleBright}

proc er*(inp: string) =
  write stdout,inp

proc ei*(inp: string) =
  writeStyled inp, {styleItalic}

proc eb*(inp: string) =
  writeStyled inp, styleBold

proc ebGr*(inp: string) =
  setForegroundColor fgGreen
  writeStyled inp, styleBold

proc ebYe*(inp: string) =
  setForegroundColor fgYellow
  writeStyled inp, styleBold

proc ebBl*(inp: string) =
  setForegroundColor fgBlue
  writeStyled inp, styleBold

proc ebRe*(inp: string) =
  setForegroundColor fgRed
  writeStyled inp, styleBold

proc eBl*(inp: string) =
  setForegroundColor fgBlue
  writeStyled inp, {}

proc eYe*(inp: string) =
  setForegroundColor fgYellow
  writeStyled inp, {}

proc eGr*(inp: string) =
  setForegroundColor fgGreen
  writeStyled inp, {}

proc eRe*(inp: string) =
  setForegroundColor fgRed
  writeStyled inp, {}

proc ed*(inp: string) =
  writeStyled inp, {styleDim}
