Include AOC2020.common

Class AOC2020.day12 Extends (%RegisteredObject, AOC2020.Base)
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
	$$$sTime S sc =..Part1(.Vec) $$$eTime
	$$$totTime
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	$$$sTime
	S sc = ..Part2(.Vec) $$$eTime
	$$$totTime
}

/// Find the 1st number that its PREAMBLE numbers does not have a sum of two
ClassMethod Part1(ByRef Vec)
{
	S Sum=..Calc(.Vec, "E")
	W !,"sum = ",Sum
	Quit 1
}

ClassMethod Calc(ByRef Vec, Dir)
{
	S x=0, y=0
	F i=1:1:Vec {
		S rc=Vec(i),cmd=$E(rc,1), val=$E(rc,2,*)
		If cmd="N" { S x=x+val }
		ElseIf cmd="S" { S x=x-val }
		ElseIf cmd="E" { S y=y+val }
		ElseIf cmd="W" { S y=y-val }
		ElseIf cmd="L" { S Ang=$Case(Dir,"N":0,"S":180,"E":90,"W":270,:""), NewAng=Ang-val S:NewAng<0 NewAng=NewAng+360 S Dir=$Case(NewAng,0:"N",90:"E",180:"S",270:"W",:"") }
		ElseIf cmd="R" { S Ang=$Case(Dir,"N":0,"S":180,"E":90,"W":270,:""), NewAng=Ang+val S:NewAng>=360 NewAng=NewAng-360 S Dir=$Case(NewAng,0:"N",90:"E",180:"S",270:"W",:"") }
		ElseIf cmd="F" {
			I Dir="N" { S x=x+val}
			ElseIf Dir="S" { S x=x-val }
			ElseIf Dir="W" { S y=y-val }
			ElseIf Dir="E" { S y=y+val }
			}
		}
		S x=$ZABS(x), y=$ZABS(y)
	Quit (x+y)
}

ClassMethod Calc2(ByRef Vec, Dir)
{
	S x=0, y=0, WayX=10, WayY=1
	F i=1:1:Vec {
		S rc=Vec(i),cmd=$E(rc,1), val=$E(rc,2,*)
		If cmd="N" { S WayY=WayY+val }
		ElseIf cmd="S" { S WayY=WayY-val }
		ElseIf cmd="E" { S WayX=WayX+val }
		ElseIf cmd="W" { S WayX=WayX-val }
		; optional code with trigonometry - slower !
		;ElseIf cmd="L" { D ..CalcXY(val, .WayX, .WayY) }
		;ElseIf cmd="R" { D ..CalcXY(-val, .WayX, .WayY) }
		; code without trigonometry
		ElseIf cmd="L" {
			I val=90 { S t=WayX, WayX=WayY*-1, WayY=t }
			ElseIf val=180 { S WayX=WayX*-1, WayY=WayY*-1 }
			ElseIf val=270 { S t=WayX, WayX=WayY, WayY=t*-1 }
			}
		ElseIf cmd="R" {
			I val=90 { S t=WayX, WayX=WayY, WayY=t*-1 }
			ElseIf val=180 { S WayX=WayX*-1, WayY=WayY*-1 }
			ElseIf val=270 { S t=WayX, WayX=WayY*-1, WayY=t }
			}
		
		ElseIf cmd="F" { S x=x+(WayX*val), y=y+(WayY*val) }
		}
	S x=$ZABS(x), y=$ZABS(y)
	Quit (x+y)
}

/// Find Contiguous numbers that give a sum = Num
ClassMethod Part2(ByRef Vec)
{
	S Sum=..Calc2(.Vec, "E")
	W !,"sum = ",Sum
	Quit 1
}

/// get New X,Y for a roration angle
ClassMethod CalcXY(Ang, ByRef x, ByRef y)
{
	S Sin=$ZSIN(Ang*$ZPI/180), Cos=$ZCOS(Ang*$ZPI/180)
	S NewX = +$FN((x * Cos) - (y * Sin),"",3), NewY = +$FN((x * Sin) + (y * Cos),"",3)
	S x=NewX, y=NewY
}

}
