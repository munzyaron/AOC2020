Include AOC2020.common

Class AOC2020.day11 Extends (%RegisteredObject, AOC2020.Base)
{

ClassMethod RunAll()
{
	S sc=..GetVec($CLASSNAME(), 0, "", .Vec)
	D ..VecToGrid(.Vec, .Grid) S MaxRow=$O(Grid(1,""),-1), MaxLine=$O(Grid(""),-1)
	K bckGrid M bckGrid=Grid $$$sTime S Result =..DoPart(1, .Grid, MaxRow, MaxLine) $$$eTime
	W !,"Part I result = ",Result
	$$$totTime
	;
	K Grid M Grid=bckGrid 
	$$$sTime S Result =..DoPart(2, .Grid, MaxRow, MaxLine) $$$eTime
	W !,"Part II result = ",Result
	$$$totTime
}

ClassMethod Test1(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	D ..VecToGrid(.Vec, .Grid) S MaxRow=$O(Grid(1,""),-1), MaxLine=$O(Grid(""),-1)
	$$$sTime S Result =..DoPart(1, .Grid, MaxRow, MaxLine) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	D ..VecToGrid(.Vec, .Grid) S MaxRow=$O(Grid(1,""),-1), MaxLine=$O(Grid(""),-1)
	$$$sTime S Result =..DoPart(2, .Grid, MaxRow,MaxLine) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

/// We do it for 2 parts.
ClassMethod DoPart(Part, ByRef Grid, MaxRow, MaxLine)
{
	;D ..Print(.Grid, MaxRow, MaxLine)
	S Changes=1
	While Changes {
		S Changes=..Calc(.Grid,MaxRow,MaxLine,Part)
		;D ..Print(.Grid, MaxRow, MaxLine)
		S Phase=$I(Phase)
		}	
	W !,"Total occ = ",..Count(.Grid,MaxRow,MaxLine)_"  (",Phase," phases)"	
	S Result=1
	Quit Result
}

/// Do one iteration on Grid
ClassMethod Calc(ByRef Grid, MaxRow, MaxLine, Part)
{
	S Changes=0
	K tmpGrid
	F Line=1:1:MaxLine {
		F Row=1:1:MaxRow {
			S rc=Grid(Line,Row)
			I rc="L" {  ; no empty seates arround L
				I Part=1 S Occ=..CountAdj(.Grid, "#", Line, Row, MaxRow, MaxLine)
				I Part=2 S Occ=..CountAdjDIr(.Grid,"#",Line,Row,MaxRow,MaxLine)
				I Occ=0 S tmpGrid(Line,Row)="#"
				}  
			ElseIf rc="#" { ; 4 or more occupied seats arround #
				I Part=1 S OccTreshold=4, Occ=..CountAdj(.Grid,"#",Line,Row,MaxRow, MaxLine)
				I Part=2 S OccTreshold=5, Occ=..CountAdjDIr(.Grid,"#",Line,Row,MaxRow,MaxLine)
				I Occ >=OccTreshold S tmpGrid(Line,Row)="L"
				 }
			}
		}
	S Changes=($D(tmpGrid)>0)
	M Grid=tmpGrid K tmpGrid
	Quit Changes
}

/// Count adjucent Type = # (occupied) or L (empty)
ClassMethod CountAdj(ByRef Grid, Type, Line, Row, MaxRow, MaxLine)
{
	S Total=0
	F L=Line-1:1:Line+1 {
		F R=Row-1:1:Row+1 {
			I (L=Line && (R=Row)) || (L<1) || (R<1) || (L>MaxLine) || (R>MaxRow) Continue ;; do not check myself
			I Grid(L,R)=Type S Total=Total+1
			}
		}
	Quit Total
}

/// PART II count adjucent by DIRECTION (U,D,L,R,UL,UR,DL,DR)
ClassMethod CountAdjDIr(ByRef Grid, Type, Line, Row, MaxRow, MaxLine)
{
	S Total=0
	S Found=0 F L=Line-1:-1:1 Q:Found  S t=Grid(L,Row) S:t=Type Total=Total+1 I t'="." S Found=1                                 ; up
	S Found=0 F L=Line+1:1:MaxLine Q:Found  S t=Grid(L,Row) S:t=Type Total=Total+1 I t'="." S Found=1                            ; down
	S Found=0 F R=Row-1:-1:1 Q:Found  S t=Grid(Line,R) S:t=Type Total=Total+1 I t'="." S Found=1                                 ; left
	S Found=0 F R=Row+1:1:MaxRow Q:Found  S t=Grid(Line,R) S:t=Type Total=Total+1 I t'="." S Found=1	                         ; right
	S Found=0,R=Row F L=Line-1:-1:1 Q:Found  S R=R-1 Q:R<1  S t=Grid(L,R) S:t=Type Total=Total+1 I t'="." S Found=1              ; upper left
	S Found=0,R=Row F L=Line-1:-1:1 Q:Found  S R=R+1 Q:R>MaxRow  S t=Grid(L,R) S:t=Type Total=Total+1 I t'="." S Found=1         ; upper right
	S Found=0,R=Row F L=Line+1:1:MaxLine Q:Found  S R=R-1 Q:R<1  S t=Grid(L,R) S:t=Type Total=Total+1 I t'="." S Found=1         ; down left
	S Found=0,R=Row F L=Line+1:1:MaxLine Q:Found  S R=R+1 Q:R>MaxRow  S t=Grid(L,R) S:t=Type Total=Total+1 I t'="." S Found=1    ; down right
	Quit Total
}

ClassMethod Test2Example(File, Line, Row)
{
	;day11-2-example1
	S sc=..GetVec($CLASSNAME(), 0, File, .Vec)
	D ..VecToGrid(.Vec, .Grid) S MaxRow=$O(Grid(1,""),-1), MaxLine=$O(Grid(""),-1)
	D ..Print(.Grid, MaxRow, MaxLine)
	S CanSee=..CountAdjDIr(.Grid,"#",Line,Row,MaxRow,MaxLine)
	W !!,"can see: ",CanSee
}

ClassMethod Count(ByRef Grid, MaxRow, MaxLine)
{
	S Total=0
	F Line=1:1:MaxLine {
		F Row=1:1:MaxRow {
			I Grid(Line,Row)="#" S Total=Total+1
			}
		}
	Quit Total
}

/// print the grid
ClassMethod Print(ByRef Grid, MaxRow, MaxLine)
{
	F Line=1:1:MaxLine {
		W !
		F Row=1:1:MaxRow W Grid(Line,Row)
		}
	W !
}

}
