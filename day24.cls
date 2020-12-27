Include AOC2020.common

Class AOC2020.day24 Extends (%RegisteredObject, AOC2020.Base)
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
	D ..Read(Example, "", .Moves)
	$$$sTime S Result = ..Part1(.Moves, Example, .Idx) $$$eTime
	W !,"Total black: ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0, Days = 1)
{
	D ..Read(Example, "", .Moves)
	S dummy = ..Part1(.Moves, Example, .Idx)
	S Result = ..Part2(.Idx, Example, Days)
	$$$sTime S Result=..Part2(.TilesVec, .Idx) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

///           | +z
///  -y \     |     / +x
///      \   /|\+z /
///        \ /| \/
///        |\ | /|
///        | |/  |
///        | /|\ |
///        /\ | / \
///       /  \|/    \
///   -x /    |      \ +y
///           | -z
/// run PART I with coordinates
ClassMethod Part1(ByRef Moves, Example = 0, ByRef Idx)
{
	F Line=1:1:$O(Moves(""),-1) {
		S (X,Y,Z)=0
		F MoveNo=1:1:Moves(Line) {
			S rc=Moves(Line,MoveNo), Move=rc
			I Move="e" { S X=X+1, Y=Y-1 }         ; z = same
			ElseIf Move="w" { S X=X-1, Y=Y+1 }    ; z = same
			ElseIf Move="nw" { S Y=Y+1, Z=Z-1 }   ; x = same
			ElseIf Move="se" { S Y=Y-1, Z=Z+1 }   ; x = same
			ElseIf Move="ne" { S X=X+1, Z=Z-1 }   ; y = same
			ElseIf Move="sw" { S X=X-1, Z=Z+1 }   ; y = same
			}
		D ..PutMoveInIdx(X, Y, Z, .Idx)	
		}
	S TotalBlack= ..CountIdx(.Idx)
	Quit TotalBlack
}

/// recursive part
ClassMethod Part2(ByRef Idx, Example = 0, Days = 100)
{
	F Day=1:1:Days {
		K tmpIdx M tmpIdx=Idx  ; to enable all changes at once
		S X="" F  {
			S X=$O(Idx(X)) Q:X=""
			S Y="" F  {
				S Y=$O(Idx(X,Y)) Q:Y=""
				S Z="" F  {
					S Z=$O(Idx(X,Y,Z)) Q:Z=""
					D ..AdjacentChange(X, Y, Z, .Idx, .tmpIdx)
					F Dir="e","w","nw","se","ne","sw" {
						S tX=X, tY=Y, tZ=Z
						I Dir="e" { S tX=tX+1, tY=tY-1 }
						ElseIf Dir="w" { S tX=tX-1, tY=tY+1 }
						ElseIf Dir="nw" { S tY=tY+1, tZ=tZ-1 }
						ElseIf Dir="se" { S tY=tY-1, tZ=tZ+1 }
						ElseIf Dir="ne" { S tX=tX+1, tZ=tZ-1 }
						ElseIf Dir="sw" { S tX=tX-1, tZ=tZ+1 }
						D ..AdjacentChange(tX, tY, tZ, .Idx, .tmpIdx)
						}
					}
				}
			}
		K Idx M Idx=tmpIdx  ; restore with all changes
		
		}
	W !,"Total blacks after day ",Day," ",..CountIdx(.Idx)
	
	Quit 1
}

/// index all points that end a line. If point already exists it is black, so we kill it to become white
ClassMethod PutMoveInIdx(X, Y, Z, ByRef Idx)
{
	I $D(Idx(X,Y,Z)) K Idx(X,Y,Z) Q  ; already been here - flip back to white = kill/unmark
	S Idx(X,Y,Z)=""
}

/// count how many blacks we have 
ClassMethod CountIdx(ByRef Idx) [ ProcedureBlock = 0 ]
{
	N (Idx)
	S a="Idx" F Count=0:1 S a=$ZO(@a) Q:a=""
	Quit Count
}

/// change all adjacent according to rules:
/// Any black tile with zero or more than 2 black tiles immediately adjacent to it is flipped to white.
/// Any white tile with exactly 2 black tiles immediately adjacent to it is flipped to black.
ClassMethod AdjacentChange(X, Y, Z, ByRef Idx, ByRef tmpIdx)
{
	S Count=0
	F Dir="e","w","nw","se","ne","sw" {
		S tX=X, tY=Y, tZ=Z
		I Dir="e" { S tX=tX+1, tY=tY-1 }
		ElseIf Dir="w" { S tX=tX-1, tY=tY+1 }
		ElseIf Dir="nw" { S tY=tY+1, tZ=tZ-1 }
		ElseIf Dir="se" { S tY=tY-1, tZ=tZ+1 }
		ElseIf Dir="ne" { S tX=tX+1, tZ=tZ-1 }
		ElseIf Dir="sw" { S tX=tX-1, tZ=tZ+1 }
		S Count=Count+$D(Idx(tX,tY,tZ))
		}
	I $D(Idx(X,Y,Z)) {  ; black
		I (Count=0) || (Count>2) k tmpIdx(X,Y,Z)  ; black  becomes a white 
		}
	Else {  ; white
		I Count=2 S tmpIdx(X,Y,Z)=""  ; white becomes a black
		}
}

/// read the file into FoodVec(food,ingredian)=""  
ClassMethod Read(Example = 1, File = "", ByRef Moves)
{
	S sc=..GetVec($CLASSNAME(), Example, File, .Vec)
	F i=1:1:Vec {
		S rc=Vec(i)
		F j=1:1:$L(rc) {  ; break into parts e, se, sw, w, nw, ne
			I $E(rc,j)="w" { S Moves(i,$I(Moves(i)))="w" }
			ElseIf $E(rc,j)="e" { S Moves(i,$I(Moves(i)))="e" }
			ElseIf $E(rc,j,j+1)="se" { S Moves(i,$I(Moves(i)))="se",j=j+1 }
			ElseIf $E(rc,j,j+1)="sw" { S Moves(i,$I(Moves(i)))="sw",j=j+1 }
			ElseIf $E(rc,j,j+1)="ne" { S Moves(i,$I(Moves(i)))="ne",j=j+1 }
			ElseIf $E(rc,j,j+1)="nw" { S Moves(i,$I(Moves(i)))="nw",j=j+1 }
			}
	}
}

}
