Include AOC2020.common

Class AOC2020.day19 Extends (%RegisteredObject, AOC2020.Base)
{

ClassMethod RunAll()
{
	S sc=..GetVec($CLASSNAME(), 0, "", .Vec)
	$$$sTime S Result =..Part1(.Vec) $$$eTime
	W !,"Part I result = ",Result
	$$$totTime
	;
	$$$sTime S Result =..Part2(.Vec) $$$eTime
	W !,"Part II result = ",Result
	$$$totTime
}

ClassMethod Test1(Example = 0)
{
	D ..Read(Example,"", .RuleVec, .MsgVec)
	$$$sTime S Result = ..Part1(.RuleVec, .MsgVec) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0, File = "")
{
	S File=$S(Example:"day19-example-2.txt",1:"")
	D ..Read(Example, File,	 .RuleVec, .MsgVec)
	$$$sTime S Result=..Part2(.RuleVec, .MsgVec) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

/// doing operator precedence evaluated left-to-right = native to Cache !!!
ClassMethod Part1(ByRef RuleVec, ByRef MsgVec) [ ProcedureBlock = 0 ]
{
	S rr=..ExecRule(0,.RuleVec,0)
	S Match=0 F i=1:1:MsgVec {
		S Msg=MsgVec(i)
		I $Match(Msg,rr) S Match=Match+1  ; use regex match
		}
	Quit Match
}

ClassMethod Part2(ByRef RuleVec, ByRef MsgVec)
{
	;S Result1=..Part1(.RuleVec,.MsgVec)
	;W !,"Result PART I = ",Result1
	; now change the two rules for PART II
	S RuleVec(8)="42 | 42 8"
	S RuleVec(11)="42 31 | 42 11 31"
	S Result2=..Part1(.RuleVec,.MsgVec)
	Quit Result2
}

/// Exec rule, recursively build a regex
ClassMethod ExecRule(RuleNo, ByRef RuleVec, Level)
{
	I Level=15 Quit ""   ; for part II - to avoid <FRAMESTACK> due to infinate loop !
	S rc=RuleVec(RuleNo), newRule=""
	F i=1:1:$L(rc," ") {
		S t=$P(rc," ",i)
		S newRule=newRule_$S(t="|":"|",t?.n:"("_..ExecRule(t,.RuleVec,Level+1)_")",1:$TR(t,"""",""))
		}
	I Level=0 S newRule="^("_newRule_")$"  ; to wrap the regext
	Quit newRule
}

/// read the file into RuleVec (rules) & MsgVec (messages)
ClassMethod Read(Example = 1, File = "", ByRef RuleVec, ByRef MsgVec)
{
	S Msgs=0
	S sc=..GetVec($CLASSNAME(), Example, File, .Vec)
	F i=1:1:Vec {
		S rc=Vec(i)
		I '$L(rc) S Msgs=1 Continue
		I 'Msgs S RuleVec($P(rc,":",1))=$ZSTRIP($P(rc,":",2),"<>w")
		I Msgs S MsgVec($I(MsgVec))=rc
		}
}

}
