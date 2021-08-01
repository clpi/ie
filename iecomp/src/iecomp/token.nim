type
  IdleToken = enum
    modif = enum
      global = "g" | "global",
      recursive = "r" | "recursive"
      local = "l" | "local"
      condIf = "if"
      condSo = "so" | "so that" | "such that"
      quantifier = "t" | "times" 
    kw = enum
      set = "set" | "$" | "s"
      exec = "exec" | "%" | "e"
      trigger = "trigger" | "t" | "@"
      defBegin = "def" | "define" | "d" | "^"
      variable = "let" | "l" | "*"
    op = enum
      parenBegin = "(", parenEnd = ")"
      blockBegin = "[", blockEnd = "]"
      bracketBegin = "[", bracketEnd = "]"
      modifier = ":"
      dQuote = "\"", sQuote = "'"
      commentHyphen =  "--"
      commentPound = "#"
      checkEq = "==" | "equals" | "eq" | "is"
      checkDoes = "?=>" | "does"
      checkDid = "=>?" | "did"
      checkWillDo
type 
  # performs the actions of prepositions, adverbs, question words
  istQualifiers = enum # the operator to qualify actions and attributes during specification
    modOp = ":" | "::" # initiates 
    qualIf = "?" | "!if"
    qualBut = "*" | "!but"
    qualOf = "." | "::" | "!of"
    qualWith = "+" | "!w"
    condKwOp = "" | "!if"

  istDescriptors = enum # Looks for modifiers after a : immediately following a kw action
    local = "l" | "loc" | local"
    global = "g" | "glob" | "global",
    recursive = "r" | "recur" | recursive"
    condIf = "i" | "if" | "?"
    prepAs = "a" | "as"
    prepFor = "f" | "for"
    
  istVerbs = enum
    set = "set" | "$" | "s"
    exec = "exec" | "%" | "e"
    trigger = "trigger" | "t" | "@"
    def = "def" | "define" | "d" | "^"
    variable = "let" | "l" | "*"

  istNouns = enum
    true = "true" | 1 | "t" | "yes" | "y"
    false = "false" |  0 | "f" | "no" | "n"



  istOp = enum
    modKwOp = ":" | "!mod"
    condKwOp = "?" | "!if"
    condKwOp = "" | "!if"
    dQuote = "\"", sQuote = "'"
    commentTilde =  "~~"
    commentBlockBegin = "!~~", commentBlockEnd = "~~!"
