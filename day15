Include AOC2020.common

Class AOC2020.day15 Extends (%RegisteredObject, AOC2020.Base)
{

/// Run PART I && II = same 
ClassMethod RunAll(Example = 0)
{
	S Input=$S(Example:"0,3,6",1:"2,0,1,9,5,19")
	;
	F Part = 1,2 {
		S TurnsToRun = $Case(Part,1:2020,2:30000000)
		$$$sTime S Result = ..Run(Input,TurnsToRun) $$$eTime
		W !,"PART ",Part," Result = ",Result
		$$$totTime
		}
}

ClassMethod Run(Input, Turns)
{
	S List=Input
	F i=1:1:$L(Input,",") S Num=$P(Input,",",i), SaidNum(Num)=i
	S Last=$P(Input,",",*), StratTurn=$L(Input,",")
	F Turn=StratTurn+1:1:Turns S Last=..Calc(Turn, Last, .SaidNum)
	Quit Last
}

/// PART I = Get next number to say based on last number
ClassMethod Calc(Turn, Last, ByRef SaidNum)
{
	S rc=SaidNum(Last)
	I $P(rc,"*",2)'="" {  ; previous: $P=2
		S Result=($P(rc,"*",1)-$P(rc,"*",2)) ; last: $P=1
		}
	Else { S Result=0 }
	S SaidNum(Result)=Turn_"*"_$P($G(SaidNum(Result)),"*",1)
	Quit Result
}

}
