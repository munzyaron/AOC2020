Include AOC2020.common

Class AOC2020.day18 Extends (%RegisteredObject, AOC2020.Base)
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
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	$$$sTime S Result = ..Part1(.Vec) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0, File = "")
{
	S sc=..GetVec($CLASSNAME(), Example, File, .Vec)
	$$$sTime S Result = ..Part2(.Vec) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

/// doing operator precedence evaluated left-to-right = native to Cache !!!
ClassMethod Part1(ByRef Vec) [ ProcedureBlock = 0 ]
{
	N (Vec)
	S tot=0
	F i=1:1:Vec {
		S rc=Vec(i)
		X "S tot = tot + ("_rc_")"
		}
	Quit tot
}

ClassMethod Part2(ByRef Vec)
{
	S tot=0
	F i=1:1:Vec {
		S rc=Vec(i)
		S tot=tot+..Eval(rc)
		}
	Quit tot
}

/// eval a string with () - so we do recursion,
/// store each level result in LevelVec(Level)
ClassMethod Eval(Str)
{
	S Level=0
	F i=1:1:$L(Str) {
		S t=$E(Str,i)
		I t="(" {
			S Level=Level+1
			Continue
			}
		I t=")" {
			S Level=Level-1
			S LevelVec(Level)=$G(LevelVec(Level))_..Eval(LevelVec(Level+1)) K LevelVec(Level+1)  ; put in 1-upper level the result of current level
			Continue
			}
		S LevelVec(Level)=$G(LevelVec(Level))_t         ; concat what we found
	}
	S Value=..Eval1(LevelVec(0))  ;; lower level always = 0
	Quit Value
}

/// eval a string doing add BEFORE multiple 
/// string comes WITHOUT ( )
ClassMethod Eval1(Str)
{
	S Mul=1
	F i=1:1:$L(Str,"*") {
		S p=$P(Str,"*",i)
		S Mul=Mul * ..Calc(p)
		}
	Quit Mul
}

/// calculte the value of a string
ClassMethod Calc(Str) [ ProcedureBlock = 0 ]
{
	N (Str)
	X "S Result = "_Str
	Quit Result
}

}
