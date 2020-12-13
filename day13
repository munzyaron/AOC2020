Include AOC2020.common

Class AOC2020.day13 Extends (%RegisteredObject, AOC2020.Base)
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
	$$$sTime S Result = ..Part1(Vec(1), Vec(2)) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	$$$sTime S Result = ..Part2("",Vec(2)) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Part1(TimeStamp, Sched) [ ProcedureBlock = 0 ]
{
	N (TimeStamp,Sched)
	F i=1:1:$L(Sched,",") S Id=$P(Sched,",",i) Continue:Id="x"  S IdVec(Id)=""
	S MaxId=$O(IdVec(""),-1)
	S Id="" F  S Id=$O(IdVec(Id)) Q:Id=""  F j=0:Id:TimeStamp+MaxId S TimeVec(j,Id)=""
	; find the next one after TimeStamp
	S Glo="TimeVec("_TimeStamp_")"
	S Next=$ZO(@Glo), NextTime=$QS(Next,1), NextId=$QS(Next,2), Wait=NextTime-TimeStamp, Mul=NextId*Wait
	Quit Mul
}

ClassMethod Part2(TimeStamp, Input)
{
	F i=1:1:$L(Input,",") S rc=$P(Input,",",i) Continue:rc="x"  S IdVec(rc,i-1)="", TimeVec(i-1,rc)=""
	S p=1, fo=0
	S t="" F  S t=$O(TimeVec(t)) Q:t=""  D
		. S x=$O(TimeVec(t,""))
		. S fo=..FindNext(x, t, fo, p)
		. S p = p * x
	S Result=fo
	Quit Result
}

ClassMethod FindNext(x, t, fo, p)
{
	S ans=fo
	While (ans+t)#x '= 0 { S ans=ans+p }
	Quit ans
}

}
