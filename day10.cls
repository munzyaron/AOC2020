Include AOC2020.common

Class AOC2020.day10 Extends (%RegisteredObject, AOC2020.Base)
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
	$$$sTime S Result =..Part1(.Vec) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test1a()
{
	S sc=..GetVec($CLASSNAME(), "", "day10-example2.txt", .Vec)
	$$$sTime S Result =..Part1(.Vec) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	$$$sTime S sc =..Part2(.Vec) $$$eTime
	W !,"sc = ",sc
	$$$totTime
}

ClassMethod Test2a()
{
	S sc=..GetVec($CLASSNAME(), "", "day10-example2.txt", .Vec)
	$$$sTime S sc =..Part2(.Vec) $$$eTime
	W !,"sc = ",sc
	$$$totTime
}

ClassMethod Part1(ByRef Vec)
{
	D ##class(AOC2020.day1).SortVec(.Vec)
	S Result=..Calc(.Vec)
	Quit Result
}

ClassMethod Calc(ByRef Vec, ByRef DiffVec)
{
	K DiffVec S Last=0
	F Pos=1:1:Vec {
		S Num=Vec(Pos)
		S Diff=Num-Last, DiffVec(Diff,Num)="", Last=Num
		}
	S DiffVec(3,Num+3)=""  ; last adapter is constant
	;
	S Mul=1
	F Diff=1,3 {
		S a="" F i=0:1 S a=$O(DiffVec(Diff,a)) Q:a=""
		S Mul=Mul*i
		}
	Quit Mul
}

ClassMethod Calc2(ByRef Vec)
{
	S Vec(0)=1  ; initialize the first value
	; build a difference string: e.g. 11113113311113331331131111311113
	S DiffStr="" F i=1:1:Vec S rc=Vec(i), Diff=Vec(i)-Vec(i-1), DiffStr=DiffStr_Diff
	; run on DiffStr and break all 1's between 3's
	; substruct 1 from each piece
	; options are:
	; Len  Result
	; 1  -> 2^1     = 2 options
	; 2  -> 2^2     = 4 options
	; 3  -> 2^3 - 1 = 7 options (because not all three could be jumped)
	S Mul=1  ; init multiplier
	F i=1:1:$L(DiffStr,3) {
		S t=$P(DiffStr,"3",i), Len=$L(t)-1
		I Len>0 S a=2**Len S:Len=3 a=a-1 S Mul=Mul*a
		}
	Quit Mul
}

ClassMethod Part2(ByRef Vec)
{
	D ##class(AOC2020.day1).SortVec(.Vec)
	S Result = ..Calc2(.Vec)
	Quit Result
}

}
