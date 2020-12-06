Class AOC2020.day6 Extends (%RegisteredObject, AOC2020.Base)
{

ClassMethod Test1(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S sc=..Part1(.Vec)
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S sc=..Part2(.Vec)
}

ClassMethod Part1(ByRef Vec)
{
	S Sum=..Calc(.Vec,1)
	W !,"Sum = ",Sum
	Quit 1
}

ClassMethod Part2(ByRef Vec)
{
	S Sum=..Calc(.Vec,2)
	W !,"Sum = ",Sum
	Quit 1
}

/// Part = 1 (count answers with OR)
/// Part = 2 (count answers with AND)
ClassMethod Calc(ByRef Vec, Part)
{
	S Group=1, StartGroup=1
	F i=1:1:Vec {
		S rc=Vec(i)
		I rc=""||..LastLn(.Vec,i) S GrpSize=(i-StartGroup), AnsByGrp(Group)=..CountAnswers(.tmpVec,Part,GrpSize) K tmpVec S Group=Group+1,StartGroup=i+1 Continue
		F j=1:1:$L(rc) S t=$E(rc,j) S tmpVec(t)=$G(tmpVec(t))+1
		}
	; calculate the sum	
	S Sum=0,Grp="" F  S Grp=$O(AnsByGrp(Grp)) Q:Grp=""  S Sum=Sum+AnsByGrp(Grp)
	Quit Sum
}

ClassMethod CountAnswers(ByRef AnsVec, Part, GrpSize)
{
 
	I Part=1 {  ; if ANYONE in group answered
		S a="" F n=0:1 S a=$O(AnsVec(a)) Q:a=""
		S Reult=n
		}
	I Part=2 {  ; if ALL in group answered
		S Tot=0 S a="" F  S a=$O(AnsVec(a)) Q:a=""  I AnsVec(a)=GrpSize S Tot=Tot+1
		S Reult=Tot
		}
	Quit Reult
}

}
