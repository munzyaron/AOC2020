Class AOC2020.day3 Extends (%RegisteredObject, AOC2020.Base)
{

/// D ##class(AOC2020.day3).Test1(1)
ClassMethod Test1(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S sc=..Part1(.Vec)
	W !,"sc = ",sc
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S sc=..Part2(.Vec)
	W !,"sc = ",sc
}

ClassMethod Part1(ByRef Vec)
{
	D ..GetParams(.Vec, .MaxLine, .MaxCol)
	S Trees=0, Move="3*1"
	S sc=..Go(.Vec, Move, 1,1, MaxCol, MaxLine,.Trees)
	W !,"Trees = ",Trees
	Quit 1
}

ClassMethod Part2(ByRef Vec)
{
	D ..GetParams(.Vec, .MaxLine, .MaxCol)
	S Mul=1
	S MoveVec(1)="1*1", MoveVec(2)="3*1", MoveVec(3)="5*1", MoveVec(4)="7*1", MoveVec(5)="1*2"
	F i=1:1:5 {
		S Trees=0
		S sc=..Go(.Vec, MoveVec(i), 1,1, MaxCol, MaxLine, .Trees)
		S $P(MoveVec(i),"*",3)=Trees, Mul=Mul*Trees
		}
	W !,"Mul = ",Mul,!
	Quit 1
}

/// main function to move. called recursively
ClassMethod Go(ByRef Vec, Move, Line, Col, MaxCol, MaxLine, Trees) As %Status
{
	
	I $E(Vec(Line),Col)="#" S Trees=Trees+1
	S AddCol=$P(Move,"*",1), AddRow=$P(Move,"*",2)  ; constants to move right=3 down=1
	S Col=Col+AddCol I Col>MaxCol S Col=Col-MaxCol
	S Line=Line+AddRow
	I Line>MaxLine Quit 1
	S Sc=..Go(.Vec, Move, Line, Col, MaxCol, MaxLine, .Trees)
	Quit 0
}

ClassMethod GetParams(ByRef Vec, ByRef MaxLine, ByRef MaxCol)
{
	S MaxCol=$L(Vec(1)), MaxLine=$O(Vec(""),-1)
}

}
