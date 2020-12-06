Class AOC2020.day5 Extends (%RegisteredObject, AOC2020.Base)
{

ClassMethod Test1(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S sc=..Part1(.Vec)
	W !,"sc = ",sc
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S MySeat=..Part2(.Vec)
	W !,"My seat = ",MySeat
}

ClassMethod Part1(ByRef Vec)
{
	F i=1:1:Vec { S SeatIDvec(..Calc(Vec(i)))="" }
	W !,"Max seatID = ", $O(SeatIDvec(""),-1)
	Quit 1
}

ClassMethod Part2(ByRef Vec)
{
	F i=1:1:Vec { S SeatIDvec(..Calc(Vec(i)))="" }
	S LastSeat=$O(SeatIDvec(""),-1), Seat="" 
	F  S Seat=$O(SeatIDvec(Seat)) Q:Seat=""  I '$D(SeatIDvec(Seat+1)) && (Seat'=LastSeat) S MySeat=Seat
	Quit MySeat
}

ClassMethod Calc(Str)
{
	; process letters 1-7 for ROW
	S Min=0,Max=127
	F i=1:1:7 {
		S Letter=$E(Str,i), Tot=Max-Min+1, Half=Tot/2
		I Letter="F" { S Max=Min+Half-1 }
		ElseIf Letter="B" { S Min=Max-Half+1 }
	}
	S Row=Min  ; min & max will be the same at that stage
	; process letters 8-10 for COL
	S Min=0,Max=7
	F i=8:1:10 {
		S Letter=$E(Str,i), Tot=Max-Min+1,Half=Tot/2
		I Letter="L" { S Max=Min+Half-1 }
		ElseIf Letter="R" { S Min=Max-Half+1 }
		}
	S Col=Min
	Quit Row*8+Col
}

}
