Class AOC2020.day8 Extends (%RegisteredObject, AOC2020.Base)
{

ClassMethod Test1(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S sc =..Part1(.Vec, .Acc)
	W !,"sc=",sc," acc = ",Acc
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S Acc =..Part2(.Vec)
	W !,"Acc = ",Acc
}

ClassMethod Part1(ByRef Vec, ByRef Acc)
{
	S Acc=0,Pos=1, NormalExit=0
	K PosVisit
	F  {
		I $D(PosVisit(Pos)) Q             ; we already visited this pos
		I Pos>Vec S NormalExit=1 Q        ; here we at the last pos means no loop !
		S PosVisit(Pos)=""
		S Pos=..Loop(.Vec, .Pos, .Acc)
		}
	Quit NormalExit
}

ClassMethod Loop(ByRef Vec, Pos, Acc)
{
	S rc=Vec(Pos), op=$P(rc," ",1), val=$P(rc," ",2)
	I op="acc" { S Pos=Pos+1, Acc=Acc+val }
	ElseIf op="nop" { S Pos=Pos+1 }
	ElseIf op="jmp" { S Pos=Pos+val }
	Quit Pos
}

ClassMethod Part2(ByRef Vec, ByRef Acc)
{
	F i=1:1:Vec {
		S rc=Vec(i),op=$P(rc," ",1)
		I op="jmp" || (op="nop") {
			S newop=$S(op="jmp":"nop",1:"jmp")
			S $P(rc," ",1)=newop
			K NewVec M NewVec=Vec S NewVec(i)=rc
			S sc=..Part1(.NewVec, .Acc)
			I sc Q   ; normal exit - no loop 
			}
		}
	Quit +$G(Acc)
}

}
