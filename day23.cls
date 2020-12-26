Include AOC2020.common

Class AOC2020.day23 Extends (%RegisteredObject, AOC2020.Base)
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

ClassMethod Test1(Example = 0, Debug = 0)
{
	S Input=$S(Example:"389125467",1:"614752839")
	$$$sTime S Result = ..Part1(Input,Example, Debug) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0, Debug = 0)
{
	S Input=$S(Example:"389125467",1:"614752839")
	$$$sTime S Result=..Part2(Input, Example, Debug) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

/// run PART I with arrays
ClassMethod Part1(Input, Example = 1, Debug = 0)
{
		D ..BuildArrays(Input, 0, .NumVec, .PosVec)
		S CurrentPos=1, Runs=$S(Example:10,1:100)
		W !,"Doing ",$FN(Runs,",",0)," runs for input: ",Input
		F Move=1:1:Runs D ..PlayRound(Input, .NumVec, .PosVec, .CurrentPos, Move, Debug)
		D ..PrintCups(CurrentPos, Move, .PosVec, .NumVec)
		S PosOfOne=$F(Input,1)-1  ;=4
		S Pos=PosVec(PosOfOne)
		S Str=""
		F i=1:1:PosVec-1 {
			S Num=$S(Pos<10:NumVec(Pos),1:Pos), Str=Str_Num
			S Pos=PosVec(Pos)
			}
		W !,"Str = ",Str
		Quit Str
}

ClassMethod Print(Input, CurrentPos, Move, Pick, Dest)
{
	W !!,"-- move ",Move," --",!,"cups: "
	F i=1:1:$L(Input) {
		W:i=CurrentPos "("
		W $E(Input,i)
		W:i=CurrentPos ")"
		W " "
		}
	W !,"pick up: " F i=1:1:$L(Pick) W $E(Pick,i)," "
	W !,"destination: ",Dest,!!
}

ClassMethod Part2(Input, Example = 1, Debug = 0)
{
	D ..BuildArrays(Input, 1e6, .NumVec, .PosVec)
	S CurrentPos=1, Runs=10000000
	W !,"Doing ",$FN(Runs,",",0)," runs for input: ",Input
	F Move=1:1:Runs {
		D ..PlayRound(Input, .NumVec, .PosVec, .CurrentPos, Move, Debug)
		}
	; get two next numbers from 1 clockwize
	S Pos=$F(Input,1)-1 ;; pos of "1" = 4
	S Pos=PosVec(Pos), Mul=1
	F i=1:1:2 {
		S Num=$S(Pos<10:NumVec(Pos),1:Pos), Mul=Mul*Num 
		S Pos=PosVec(Pos)
		}
	
	Quit Mul
}

/// play a round with arrays (for PART II)
ClassMethod PlayRound(Input, ByRef NumVec, ByRef PosVec, ByRef CurrentPos, Move, Debug)
{
	I Debug D ..PrintCups(CurrentPos, Move, .PosVec, .NumVec)
	S CurrentVal=$S(CurrentPos<10:NumVec(CurrentPos),1:CurrentPos)
	D ..Pick3(CurrentPos, .PickPos, .PosVec, .NumVec, .PickValues)
	S Destination=CurrentVal-1, Found=0
	While 'Found {
		I Destination=0 S Destination=PosVec
		I PickValues'[(","_Destination_",") S Found=1 Q  ; if it not on the pick ones, it is on the main list
		S Destination=Destination-1 
		}
	;
	I Debug D ..PrintPick(PickPos, .NumVec, .PosVec, Destination)
	;S DestPos=NumIdx(Destination), oldPickNext=PosVec(DestPos), PosVec(DestPos)=PickPos, PickLast=PickPos
	S DestPos=$S(Destination<10:$F(Input,Destination)-1,1:Destination), oldPickNext=PosVec(DestPos), PosVec(DestPos)=PickPos, PickLast=PickPos
	F i=1:1:2 S PickLast=PosVec(PickLast)
	S PosVec(PickLast)=oldPickNext, CurrentPos=PosVec(CurrentPos)
}

/// pick 3 after current Position
/// using Arrays for PART II
/// PickPos = return the START pos we picked from 
/// PickValuesVec(val)=""  will hold the values we picked
ClassMethod Pick3(CurrentPos, ByRef PickPos, ByRef PosVec, ByRef NumVec, ByRef PickValues)
{
	S PickValues=","
	S newPos=PosVec(CurrentPos), PickPos=newPos
	F i=1:1:3 S PickValues=PickValues_$S(newPos<10:NumVec(newPos),1:newPos)_",", newPos=PosVec(newPos)
	S PosVec(CurrentPos)=newPos
}

/// print the cups
ClassMethod PrintCups(CurrentPos, Move, ByRef PosVec, ByRef NumVec)
{
	W !!,"-- move ",Move," --",!,"cups: "
	S Pos=$O(PosVec(""))
	F i=1:1:PosVec {
		W:Pos=CurrentPos "(" W $S(Pos<9:NumVec(Pos),1:Pos) W:Pos=CurrentPos ")"
		W " "
		S Pos=PosVec(Pos)
		}
}

ClassMethod PrintPick(PickPos, ByRef NumVec, ByRef PosVec, Destination)
{
	W !,"pick up: "
	S pos=PickPos
	F i=1:1:3 {
		W $S(pos<10:NumVec(pos),1:pos)," "
		S pos=PosVec(pos)
		}
	W !,"destination: ",Destination
}

/// ////////// worknig with array + pointers - for part II /////////
/// Build Array of inputes in 2 vectors: NumVec(ln)=Number & PosVec(Pos)=NextPos  PosVec=MaxPos
/// Max = to add to the Input. PART I = 0, PART II = 1,000,000
ClassMethod BuildArrays(Input, Max = 0, ByRef NumVec, ByRef PosVec)
{
	F i=1:1:$L(Input) {
		S t=$E(Input,i)
		S NumVec($I(NumVec))=t
		S PosVec(i)=$S(i<$L(Input):i+1,1:1) ; we connect last to first
		}
	I Max {  ; add more to the list assume the list is always 1..9 without any repeat
		F Num=i+1:1:Max {
			S PosVec(Num)=$S(Num<Max:Num+1,1:1)
			}
		S PosVec(i)=i+1, PosVec(Max)=1
		}
	S PosVec=$S(Max:Max,1:i)
}

}
