Include AOC2020.common

Class AOC2020.day17 Extends (%RegisteredObject, AOC2020.Base)
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

ClassMethod Part1(ByRef Vec)
{
	D ..BuildGrid(.Vec, .Grid)
	;D ..Print(.Grid)
	;Quit 0
	F Phase=1:1:6 {
		D ..Calc(.Grid)
		;D ..Print(.Grid)
		}
	S Tot= ..CountAllGrid(.Grid)
	Quit Tot
}

ClassMethod Calc(ByRef Grid)
{
	K cngGrid
	D ..GetMinMax(.Grid, .mmVec)
	F z=mmVec("z","min")-1:1:mmVec("z","max")+1 {
		F y=mmVec("y","min")-1:1:mmVec("y","max")+1 {
			F x=mmVec("x","min")-1:1:mmVec("x","max")+1 {
				S Count =..CoutActive(.Grid,x,y,z)
				I ($G(Grid(x,y,z))="#") && (Count'=2) && (Count'=3) S cngGrid(x,y,z)="."
				I ('$D(Grid(x,y,z)) || (Grid(x,y,z)=".")) && (Count=3) S cngGrid(x,y,z)="#" 
				}
			}
		}
	M Grid=cngGrid
}

/// count active cubes arround pos x,y,z
ClassMethod CoutActive(ByRef Grid, x, y, z)
{
	S Count=0
	F nX=x-1:1:x+1 {
		F nY=y-1:1:y+1 {
			F nZ=z-1:1:z+1 {
				I (nZ=z) && (nY=y) && (nX=x) Continue
				I $G(Grid(nX,nY,nZ))="#" S Count=Count+1
				}
			}
		}
	Quit Count
}

/// count all active in grid
ClassMethod CountAllGrid(ByRef Grid) [ ProcedureBlock = 0 ]
{
	N (Grid)
	S a="Grid"
	F  S a=$ZO(@a) Q:a=""  I @a="#" S Tot=$I(Tot)
	Quit Tot
}

/// PART I - called once at start
ClassMethod BuildGrid(ByRef Vec, ByRef Grid)
{
	S z=0
	F y=1:1:Vec {
		S rc=Vec(y)
		F x=1:1:$L(rc) S Grid(x-1,y-1,z)=$E(rc,x) 
		}
}

/// print the grid
ClassMethod Print(ByRef Grid)
{
	D ..GetMinMax(.Grid, .mmVec)
	F z=mmVec("z","min"):1:mmVec("z","max") {
		W !,"z = ",z,!
		F y=mmVec("y","min"):1:mmVec("y","max") {
			F x=mmVec("x","min"):1:mmVec("x","max") {
				W $G(Grid(x,y,z),".")
				}
			W !
			}	
		W !!
		}
}

/// get min/max for x,y,z
ClassMethod GetMinMax(ByRef Grid, ByRef MinMaxVec) [ ProcedureBlock = 0 ]
{
	
	N (Grid,MinMaxVec)
	S a="Grid"
	F  {
		S a=$ZO(@a) Q:a=""
		S x=$QS(a,1), y=$QS(a,2), z=$QS(a,3)
		I '$D(MinMaxVec("x","min")) || (x<MinMaxVec("x","min")) S MinMaxVec("x","min")=x
		I '$D(MinMaxVec("x","max")) || (x>MinMaxVec("x","max")) S MinMaxVec("x","max")=x
		I '$D(MinMaxVec("y","min")) || (y<MinMaxVec("y","min")) S MinMaxVec("y","min")=y
		I '$D(MinMaxVec("y","max")) || (y>MinMaxVec("y","max")) S MinMaxVec("y","max")=y
		I '$D(MinMaxVec("z","min")) || (z<MinMaxVec("z","min")) S MinMaxVec("z","min")=z
		I '$D(MinMaxVec("z","max")) || (z>MinMaxVec("z","max")) S MinMaxVec("z","max")=z
		}
}

ClassMethod Part2(ByRef Vec)
{
	D ..BuildGrid2(.Vec, .Grid)
	F Phase=1:1:6 {
		D ..Calc2(.Grid)
		;D ..Print2(.Grid) r xxx
		}
	S Tot= ..CountAllGrid(.Grid)
	Quit Tot
}

ClassMethod Calc2(ByRef Grid)
{
	K cngGrid
	D ..GetMinMax2(.Grid, .mmVec)
	F w=mmVec("w","min")-1:1:mmVec("w","max")+1 {
		F z=mmVec("z","min")-1:1:mmVec("z","max")+1 {
			F y=mmVec("y","min")-1:1:mmVec("y","max")+1 {
				F x=mmVec("x","min")-1:1:mmVec("x","max")+1 {
					S Count =..CoutActive2(.Grid,x,y,z,w)
					I ($G(Grid(x,y,z,w))="#") && (Count'=2) && (Count'=3) S cngGrid(x,y,z,w)="."
					I ('$D(Grid(x,y,z,w)) || (Grid(x,y,z,w)=".")) && (Count=3) S cngGrid(x,y,z,w)="#" 
					}
				}
			}
		}
	M Grid=cngGrid
}

/// PART II = count active cubes arround pos x,y,z,w
ClassMethod CoutActive2(ByRef Grid, x, y, z, w)
{
	S Count=0
	F nX=x-1:1:x+1 {
		F nY=y-1:1:y+1 {
			F nZ=z-1:1:z+1 {
				F nW=w-1:1:w+1 {
					I (nW=w) && (nZ=z) && (nY=y) && (nX=x) Continue
					I $G(Grid(nX,nY,nZ,nW))="#" S Count=Count+1
					}
				}
			}
		}
	Quit Count
}

/// PART II = get min/max for x,y,z,w
ClassMethod GetMinMax2(ByRef Grid, ByRef MinMaxVec) [ ProcedureBlock = 0 ]
{
	N (Grid,MinMaxVec)
	S a="Grid"
	F  {
		S a=$ZO(@a) Q:a=""
		S x=$QS(a,1), y=$QS(a,2), z=$QS(a,3), w=$QS(a,4)
		I '$D(MinMaxVec("x","min")) || (x<MinMaxVec("x","min")) S MinMaxVec("x","min")=x
		I '$D(MinMaxVec("x","max")) || (x>MinMaxVec("x","max")) S MinMaxVec("x","max")=x
		I '$D(MinMaxVec("y","min")) || (y<MinMaxVec("y","min")) S MinMaxVec("y","min")=y
		I '$D(MinMaxVec("y","max")) || (y>MinMaxVec("y","max")) S MinMaxVec("y","max")=y
		I '$D(MinMaxVec("z","min")) || (z<MinMaxVec("z","min")) S MinMaxVec("z","min")=z
		I '$D(MinMaxVec("z","max")) || (z>MinMaxVec("z","max")) S MinMaxVec("z","max")=z
		I '$D(MinMaxVec("w","min")) || (w<MinMaxVec("w","min")) S MinMaxVec("w","min")=w
		I '$D(MinMaxVec("w","max")) || (w>MinMaxVec("w","max")) S MinMaxVec("w","max")=w
		}
}

/// PART II - called once at start build 4 dimentions x,y,z,w
ClassMethod BuildGrid2(ByRef Vec, ByRef Grid)
{
	S w=0,z=0
	F y=1:1:Vec {
		S rc=Vec(y)
		F x=1:1:$L(rc) S Grid(x-1,y-1,z,w)=$E(rc,x) 
		}
}

/// PART II - print the grid
ClassMethod Print2(ByRef Grid)
{
	D ..GetMinMax2(.Grid, .mmVec)
	F w=mmVec("w","min"):1:mmVec("w","max") {
		F z=mmVec("z","min"):1:mmVec("z","max") {
			W !,"z = ",z,", w = ",w,!
			F y=mmVec("y","min"):1:mmVec("y","max") {
				F x=mmVec("x","min"):1:mmVec("x","max") {
					W $G(Grid(x,y,z,w),".")
					}
				W !
				}
			W !!
			}
		}
}

}
