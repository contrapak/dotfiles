
" Remove any old syntax stuff hanging around
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

 " Comments (belong everywhere)
syn region myhsLineComment start="[-!#$%&\*\+./<=>\?@\\^|~]\@<!--[!#$%&\*\+./<=>\?@\\^|~]\@!" excludenl end="$"
syn region myhsBlockComment start="{-" end="-}"
syn region myhsPragma matchgroup=myhsPragmaDelim start="{-#" end="#-}" contains=myhsPragmaKeyword
syn match myhsPragmaKeyword "\%({-#\s*\)\@<=[a-zA-Z0-9_]*" contained
syn match myhsTitle "^------*.*$"
syn cluster myhsComments contains=myhsLineComment,myhsBlockComment,myhsTitle
hi def link myhsLineComment myhsComment
hi def link myhsBlockComment myhsComment
hi def link myhsPragmaDelim myhsComment
hi def link myhsPragmeKeyword PreProc
hi def link myhsComment Comment
hi def link myhsTitle Title

 " Constants (belong in both normal expressions and patterns)
syn match myhsSpecialChar contained "\\\%([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match myhsSpecialChar contained "\\\%(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match myhsSpecialCharError contained "\\&\|'''\+"
 " Tried many ways to make multi-line strings work but apparently just this works
syn match myhsStringExtend contained "\\\s*$"
syn match myhsStringExtend contained "^\s*\\"
syn region myhsString start=+"+  skip=+\\\\\|\\"+  end=+"\|$+  contains=myhsSpecialChar,myhsStringExtend
syn match myhsCharacter "[a-zA-Z0-9_']\@<!'\%([^\\]\|\\[^']\+\|\\'\)'" contains=myhsSpecialChar,myhsSpecialCharError
syn match myhsNumber "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
syn match myhsFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
syn match myhsConstructor "\<[A-Z][a-zA-Z0-9_]*\>'*\.\@!"
syn match myhsCons "[\-!#$%&*+/<=>?@\\\^|~.:]\@<!:[\-!#$%&*+/<=>?@\\\^|~.:]\@!"
syn match myhsUnit "()"
syn match myhsListDelim "\[\|\]"
syn match myhsComma ","
syn cluster myhsConstants contains=myhsString,myhsCharacter,myhsNumber,myhsFloat,myhsConstructor,myhsCons,myhsUnit,myhsListDelim,myhsComma,myhsBadComma
hi def link myhsSpecialChar Special
hi def link myhsSpecialCharError Error
hi def link myhsStringExtend Special
hi def link myhsString myhsConstant
hi def link myhsCharacter myhsConstant
hi def link myhsNumber myhsConstant
hi def link myhsFloat myhsConstant
hi def link myhsConstructor myhsConstant
hi def link myhsCons myhsConstant
hi def link myhsUnit myhsConstant
hi def link myhsListDelim myhsConstant
hi def link myhsTupleDelim myhsConstant
hi def link myhsComma myhsConstant
hi def link myhsConstant Constant
 " Error detection
syn match myhsBadComma ",\%(\_s*[\])}]\)\@="
syn match myhsBadNonComma "[a-zA-Z0-9_')]\@<=\s\s*[a-zA-Z0-9_'(]\@=" contained
syn match myhsBadDC "[\-!#$%&*+/<=>?@\\\^|~.:]\@<!::[\-!#$%&*+/<=>?@\\\^|~.:]\@!" contained
hi def link myhsBadComma Error
hi def link myhsBadNonComma Error
hi def link myhsBadDC Error

 " Misc statement stuff
syn keyword myhsStatement do mdo rec proc case of let in where
syn keyword myhsConditional if then else
syn match myhsStatementOp "[\-!#$%&*+/<=>?@\\\^|~.:]\@<!\%(=\|<-\||\|\\\|\.\.\)[\-!#$%&*+/<=>?@\\\^|~.:]\@!"
syn match myhsArrow "[\-!#$%&*+/<=>?@\\\^|~.:]\@<!->[\-!#$%&*+/<=>?@\\\^|~.:]\@!"
syn cluster myhsStatements contains=myhsStatement,myhsConditional,myhsStatementOp,myhsArrow,myhsLambda
hi def link myhsStatement Statement
hi def link myhsConditional Conditional
hi def link myhsStatementOp Statement
hi def link myhsArrow myhsStatementOp
hi def link myhsLambda myhsStatementOp

 " Normal expressions
syn region myhsParensN matchgroup=myhsParensN start="()\@!" end=")" contains=@myhsExprs,myhsPattern
syn region myhsTupleN matchgroup=myhsTupleDelim start="(\%(\%(\_[^(),\[\]]\|(\_[^()]\{-})\|\[\_[^\[\]]\{-}\]\)\{-},\)\@=" end=")" contains=@myhsExprs
syn region myhsRecordN matchgroup=myhsRecordDelim start="\%(\<[A-Z][a-zA-Z0-9_]*\>'*\_s*\)\@<={-\@!" end="}" contains=@myhsExprs
syn cluster myhsExprs contains=myhsParensN,myhsTupleN,myhsRecordN,@myhsComments,@myhsConstants,@myhsStatements
hi def link myhsRecordDelim myhsConstant

 " Pattern expressions
syn match myhsBinding "\<[a-z][a-zA-Z0-9_]*\>'*\|:\@<![\-!#$%&*+/<=>?@\\\^|~]\+" contained
syn match myhsBindingR "\<[a-z][a-zA-Z0-9_]*\>'*\%(\s*=\)\@!" contained
syn match myhsPatternOp "[\-!#$%&*+/<=>?@\\\^|~.:]\@<!\%(@\|!\)[\-!#$%&*+/<=>?@\\\^|~.:]\@!" contained
syn region myhsParensP start="()\@!" end=")" contained contains=@myhsPatterns
syn region myhsTupleP matchgroup=myhsTupleDelim start="()\@!\%(\%(\_[^(),]\|(\_[^()]\{-})\)\{-},\)\@=" end=")" contained contains=@myhsPatterns
syn region myhsRecordP start="\%(\<[A-Z][a-zA-Z0-9_]*\>'*\_s*\)\@<={-\@!" end="}" contained contains=@myhsPatternsR
syn cluster myhsPatterns contains=myhsPatternOp,myhsParensP,myhsTupleP,myhsRecordP,myhsBinding,@myhsComments,@myhsConstants,@myhsStatements
syn cluster myhsPatternsR contains=myhsPatternOp,myhsParensP,myhsTupleP,myhsRecordP,myhsBindingR,@myhsComments,@myhsConstants,@myhsStatements
syn match myhsPattern _\%(^\|\\\|\<where\>\|\<let\>\)\%([^\\:'"\-{}]\|--\@!\|::\@!\|"\%([^\\"]\|\\\\\|\\"\)\{-}"\|'\%([^\\']\|\\\\\|\\'\)\{-}'\)\{-}\ze[\-!#$%&*+/<=>?@\\\^|~.]\@<!\%(|\|=\|<-\|->\|::\)[\-!#$%&*+/<=>?@\\\^|~.]\@!_ transparent contains=@myhsPatterns,myhsDC,myhsLambda
hi def link myhsBindingR myhsBinding
hi def link myhsPatternOp myhsStatementOp
hi def link myhsBinding Identifier

 " Down here so it overrides
syn match myhsLambda "\\" contained

 " Type expressions
syn match myhsContext "=>" contained
syn keyword myhsForall forall contained
syn match myhsTypeVar "\<[a-z][a-zA-Z0-9_]*\>'*" contained
syn region myhsParensT matchgroup=myhsParensT start="(" end=")" contained contains=@myhsTypes
syn region myhsListT start="\[" end="]" contained contains=@myhsTypes
syn region myhsRecordT start="\%(\<[A-Z][a-zA-Z0-9_]*\>'*\_s*\)\@<={-\@!" end="}" contained contains=myhsRecordTField,myhsBadComma
syn match myhsRecordTField "\<[a-z][a-zA-Z0-9_]*\>'*" contained nextgroup=myhsRecordTDC skipwhite
syn match myhsRecordTDC "[\-!#$%&*+/<=>?@\\\^|~.:]\@<!::[\-!#$%&*+/<=>?@\\\^|~.:]\@!" contained nextgroup=myhsRecordTType skipwhite
syn region myhsRecordTType start="" end="\%(,\|}\)\@=" contained contains=@myhsTypes,myhsBadDC
syn cluster myhsTypes contains=myhsContext,myhsForall,myhsTypeVar,myhsParensT,myhsListT,myhsRecordT,@myhsComments,myhsStatementOp
syn region myhsTypeExpr start="" end="\%(\n\%(\s*\(=>\|->\)\)\@!\|\]\|)\|}\|,\|\<of\>\)\@=" contained contains=@myhsTypes
syn match myhsDC "[\-!#$%&*+/<=>?@\\\^|~.:]\@<!::[\-!#$%&*+/<=>?@\\\^|~.:]\@!" nextgroup=myhsTypeExpr
syn region myhsTypeAnnotation start="\z(\%(^\|\<where\>\|\<let\>\)\s*\)\%([a-z][a-zA-Z0-9_]*\>'*\|([\-!#$%&*+/<=>?@\\\^|~]*)\)\s*::" skip="\n\z1\s\s*\S" end="$" keepend transparent contains=myhsBinding,myhsDC
hi def link myhsContext myhsStatementOp
hi def link myhsTypeVar myhsBinding
hi def link myhsRecordTField myhsBinding
hi def link myhsDC myhsStatementOp
hi def link myhsRecordTDC myhsStatementOp

 " Data declarations (Assumed to start on new line always)
syn keyword myhsDataAux deriving nextgroup=myhsDeriving skipwhite skipempty
syn region myhsDeriving start="(" end=")" contained contains=myhsBadComma
syn keyword myhsDataKeyword data newtype contained
syn match myhsTypeBinding "\<[A-Z][a-zA-Z0-9_]*\>'*" contained
syn region myhsDataLeft start="\<data\>\|\<newtype\>" end="\%(=\|$\)\@=" nextgroup=myhsDataRight transparent contains=myhsDataKeyword,myhsTypeBinding,@myhsTypes,@myhsComments
syn match myhsDataRight "=\s*[A-Z][a-zA-Z0-9_]*\>'*" transparent contained contains=myhsTypeBinding,myhsStatementOp nextgroup=myhsTypeExpr
syn match myhsDataOr "|\s*[A-Z][a-zA-Z0-9_]*\>'*" transparent contains=myhsTypeBinding,myhsStatementOp nextgroup=myhsTypeExpr
hi def link myhsTypeBinding myhsBinding
hi def link myhsDataKeyword PreProc
hi def link myhsDataAux PreProc

 " Guard goes here so it overrides myhsDataOr
syn match myhsGuard "|\%([^\\:-]\|--\@!\|::\@!\)\{-}[\-!#$%&*+/<=>?@\\\^|~.]\@<!\%(=\|->\)[\-!#$%&*+/<=>?@\\\^|~.]\@!" transparent contains=@myhsExprs

 " Type aliases
syn region myhsTypeAlias matchgroup=myhsTypeKeyword start="\<type\>" end="=\@=" transparent contains=myhsTypeBinding,myhsTypeVar nextgroup=myhsTypeExpr
hi def link myhsTypeKeyword PreProc

 " Class declarations
syn region myhsClassDecl start="^\z(\s*\)\<class\>" skip="\n\z1\s\s*\S" end="\n\@=" transparent contains=myhsClassLeft,@myhsExprs,myhsPattern,myhsTypeAnnotation
syn region myhsClassLeft matchgroup=myhsClassKeyword start="\<class\>" end="\<where\>" transparent contained contains=myhsTypeBinding,myhsTypes,myhsContext,myhsClassKeyword,@myhsComments
hi def link myhsClassKeyword PreProc

 " Instance declarations
syn region myhsInstanceDecl start="^\z(\s*\)\<instance\>" skip="\n\z1\s\s*\S" end="\n\@=" transparent contains=myhsInstanceLeft,@myhsExprs,myhsPattern,myhsTypeAnnotation
syn region myhsInstanceLeft matchgroup=myhsInstanceKeyword start="\<instance\>" end="\<where\>" transparent contained contains=myhsTypes,myhsContext,myhsInstanceKeyword,@myhsComments
hi def link myhsInstanceKeyword PreProc

 " Other special declarations
syn keyword myhsModuleKeyword module where contained
syn match myhsModuleExportDP "\.\." contained
syn region myhsModuleExport start="(" skip="([^()]*)" end=")" keepend contained contains=myhsBinding,myhsTypeBinding,myhsModuleExportDP,myhsBadComma,myhsBadNonComma,@myhsComments
syn region myhsModuleDecl start="\<module\>" end="\<where\>" keepend transparent contains=myhsModuleKeyword,myhsModuleExport,@myhsComments
syn keyword myhsImportKeyword import as qualified hiding contained
syn region myhsImportDecl start="\<import\>" excludenl end="$" contains=myhsImportKeyword,@myhsComments
syn keyword myhsInfixKeyword infix infixl infixr
syn match myhsInfixDecl "\<infix[lr]\?\>\s*[0-9]\+\s*[\-!#$%&*+/<=>?@\\\^|~.]*" transparent contains=myhsInfixDeclBinding,myhsInfixKeyword,myhsNumber
syn match myhsInfixDeclBinding "[\-!#$%&*+/<=>?@\\\^|~.]" contained
hi def link myhsModuleKeyword PreProc
hi def link myhsImportKeyword PreProc
hi def link myhsInfixKeyword PreProc

let b:current_syntax = "myhs2"

