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
	$$$sTime S Result = ..Part1(.Moves,Example, Debug) $$$eTime
	W !,"Total black: ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0, Debug = 0)
{
	D ..Read(Example, "", .Moves)
	S tmp = ..Part1(.Moves,Example, Debug, .TilesVec, .Idx)
	$$$sTime S Result=..Part2(.TilesVec, .Idx) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

/// run PART I with arrays
ClassMethod Part1(ByRef Moves, Example = 1, Debug = 0, ByRef TilesVec, ByRef Idx)
{
	F Line=1:1:$O(Moves(""),-1) {
		S Tile=1 I '$D(TilesVec) S TilesVec($I(TilesVec))="w"
		F MoveNo=1:1:Moves(Line) {
			S rc=Moves(Line,MoveNo), Move=rc
			S Tile= ..ExecMove(Tile, Move, .TilesVec, .Idx)
			}
		S TilesVec(Tile)=$Case(TilesVec(Tile),"b":"w","w":"b",:"XXXX")
		}
	S TotalBlack= ..CountBlack(.TilesVec)
	
	Quit TotalBlack
}

/// Count how many black tiles are
ClassMethod CountBlack(ByRef TilesVec, ByRef BlackTiles)
{
	S BlackTiles=""
	S Total=0 F i=1:1:TilesVec {
		S rc=TilesVec(i)
		I rc="b" S Total=Total+1, BlackTiles=BlackTiles_i_","
		}
	S BlackTiles=$ZSTRIP(BlackTiles,"<>",",")
	Quit Total
}

/// execute one move
ClassMethod ExecMove(Tile, Move, ByRef TilesVec, ByRef Idx)
{
	; build all nearby
	S DirStr="e,se,sw,w,nw,ne", Len=$L(DirStr,",")
	F i=1:1:Len {
		S Dir=$P(DirStr,",",i)
		S PrevDir=$P(DirStr,",",$S(i=1:Len,1:i-1)), NextDir=$P(DirStr,",",$S(i=Len:1,1:i+1))
		S newTile=..GetTile(Tile, Dir, .TilesVec, .Idx)
		S tile2=..GetTile(newTile, ..GetPrevDir(PrevDir), .TilesVec, .Idx)
		S Idx(Tile,PrevDir)=tile2, Idx(tile2,..GetOppositeDirection(PrevDir))=Tile
		;
		S tile3=..GetTile(newTile, ..GetNextDir(NextDir), .TilesVec, .Idx)
		S Idx(Tile,NextDir)=tile3, Idx(tile3, ..GetOppositeDirection(NextDir))=Tile
		;
		}
	S newTile=Idx(Tile,Move)
	Quit newTile
}

/// Get Opposite direction
ClassMethod GetOppositeDirection(Direction)
{
	Quit $Case(Direction,"w":"e","e":"w","nw":"se","se":"nw","ne":"sw","sw":"ne")
}

/// get prev direction (anti CW)
ClassMethod GetPrevDir(Direction)
{
	Quit $Case(Direction,"w":"sw","sw":"se","se":"e","e":"ne","ne":"nw","nw":"w")
}

/// get prev direction (CW)
ClassMethod GetNextDir(Direction)
{
	Quit $Case(Direction,"w":"nw","nw":"ne","ne":"e","e":"se","se":"sw","sw":"w")
}

/// Get a new tile or existing one
/// We check direction but also try to go in 2 steps (e.g. to check E we go NE & SE or NE & ) 
ClassMethod GetTile(Tile, Direction, ByRef TilesVec, ByRef Idx)
{
	S newTile="", RevDirection=$Case(Direction,"w":"e","e":"w","nw":"se","se":"nw","ne":"sw","sw":"ne")
	K Skip S newTile=..GetDirection(Tile,Direction, .Idx, .Skip)
	I '$L(newTile) {
		F tmpTile=1:1:TilesVec D ..FixIdx(tmpTile, .Idx)
		S newTile=$I(TilesVec), TilesVec(newTile)="w"
		}
	S Idx(Tile,Direction)=newTile, Idx(newTile,RevDirection)=Tile
	Quit newTile
	;
}

/// get a tile in a direction - use recursion to find it
ClassMethod GetDirection(Tile, Direction, ByRef Idx, ByRef Skip)
{
	I $D(Skip(Tile,Direction)) Quit ""
	S newTile=""
	S PrevDir=..GetPrevDir(Direction), NextDir=..GetNextDir(Direction), Skip(Tile,Direction)=""
	I '$D(Idx(Tile,Direction)) {
		I $D(Idx(Tile,PrevDir)) {
		S PrevTile=Idx(Tile,PrevDir)
		I '$D(Idx(PrevTile,NextDir)) {
			S newTile=..GetDirection(PrevTile, NextDir, .Idx, .Skip)
			}
		Else { S newTile=Idx(PrevTile,NextDir) }
		}
		If ('$L(newTile) && $D(Idx(Tile,NextDir))) {
			S NextTile=Idx(Tile,NextDir)
			I '$D(Idx(NextTile,PrevDir)) {
				S newTile=..GetDirection(NextTile, PrevDir, .Idx, .Skip)
				}
			Else {
				S newTile=Idx(NextTile,PrevDir)
				}
			}
		}
	Else { S newTile=Idx(Tile,Direction) }
	Quit newTile
}

/// recalculate a tile with all positions to add links that were not build during the normal travel
ClassMethod FixIdx(Tile, ByRef Idx)
{
	S DirStr="e,se,sw,w,nw,ne", Len=$L(DirStr,",")
	F i=1:1:Len {
		S Dir=$P(DirStr,",",i), OppDir=..GetOppositeDirection(Dir)
		K Skip S newTile=..GetDirection(Tile, Dir, .Idx, .Skip)
		I $L(newTile) && '$D(Idx(Tile,Dir)) {
			S Idx(Tile,Dir)=newTile, Idx(newTile,OppDir)=Tile
			}
		}
}

/// recursive part
ClassMethod Part2(ByRef TilesVec, ByRef Idx)
{
	F Tile=1:1:TilesVec D ..FixIdx(Tile, .Idx)  ; just in case
	F Day=1:1:100 {
		S HowManyBlack=..CountBlack(.TilesVec, .BlackTiles)
		F j=1:1:$L(BlackTiles,",") {
			S BlackTile=$P(BlackTiles,",",j)
			D ..ChkEdge(BlackTile, .TilesVec, .Idx)
			}
		;D ..Print(.TilesVec, .Idx)
		D ..CalcBlacks(.TilesVec, .Idx)
		W !,"day: ",Day
		}
	W !,"Total blacks after day ",Day," ",..CountBlack(.TilesVec, .BlackTiles)
	
	Quit 1
}

/// calc black tiles for 1 day
ClassMethod CalcBlacks(ByRef TilesVec, ByRef Idx)
{
	K tmpTiles
	F Tile=1:1:TilesVec {
		S SelfColor=TilesVec(Tile)
		S AdjBlack = ..CountAdj(Tile, .TilesVec, .Idx)
		I SelfColor="b" {
			I AdjBlack=0 || (AdjBlack>2) S tmpTiles(Tile)="w"
			}
		ElseIf AdjBlack=2 {
			I SelfColor="w" S tmpTiles(Tile)="b"
			}
		}
	M TilesVec=tmpTiles
	Q
}

/// build more tiles if a tile is black and it is on the edge (not have 6 tiles adjacent
ClassMethod ChkEdge(Tile, ByRef TilesVec, ByRef Idx)
{
	F Dir="e","se","sw","w","nw","ne" {
		I '$D(Idx(Tile,Dir)) {
			S newTile=..GetTile(Tile,Dir, .TilesVec, .Idx)
			}
		}
}

/// count how many black are adjacent to Tile
ClassMethod CountAdj(Tile, ByRef TilesVec, ByRef Idx)
{
	S Count=0,Dir="" F  {
		S Dir=$O(Idx(Tile,Dir)) Q:Dir=""
		S newTile=Idx(Tile,Dir), Color=TilesVec(newTile)
		I Color="b" S Count=Count+1
		}
	Quit Count
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

/// print the floor for debug
ClassMethod Print(ByRef TilesVec, ByRef Idx)
{
	S (StartTile,Tile)=1, cc=0
	S Line=0, vv(Line,cc)=StartTile
	; line 0 - EAST
	S Tile=StartTile
	While $L(Tile) {
		s cc=cc+2, val=$G(Idx(Tile,"e")) S:$L(val) vv(Line,cc)=val
		S Tile=$G(Idx(Tile,"e"))
		}
	; line 0 - WEST
	S Tile=StartTile, cc=0
	S Line(0,cc)=Tile
	While $L(Tile) {
		S cc=cc-2, val=$G(Idx(Tile,"w")) S:$L(val) vv(Line,cc)=val
		S Tile=$G(Idx(Tile,"w"))
		}
	;
	; run lines DOWN from 0
	S Ln=1, End=0
	While 'End {
		S Pos="" F  {
			S Pos=$O(vv(Ln-1,Pos)) Q:Pos=""
			S prevNum=vv(Ln-1,Pos) Q:'$L(prevNum)
			S NumRight=$G(Idx(prevNum,"se")) S:$L(NumRight) vv(Ln,Pos+1)=NumRight
			S NumLeft=$G(Idx(prevNum,"sw")) S:$L(NumLeft) vv(Ln,Pos-1)=NumLeft
			}
		;D ..AddEdges(Ln, .Idx)
		S Ln=Ln+1
		I '$D(vv(Ln-1)) S End=1
		}
	; run lines UP from 0
	S Ln=-1, End=0
	While 'End {
		S Pos="" F  {
			S Pos=$O(vv(Ln+1,Pos)) Q:Pos=""
			S prevNum=vv(Ln+1,Pos) Q:'$L(prevNum)
			S NumRight=$G(Idx(prevNum,"ne")) S:$L(NumRight) vv(Ln,Pos+1)=NumRight
			S NumLeft=$G(Idx(prevNum,"nw")) S:$L(NumLeft) vv(Ln,Pos-1)=NumLeft
			}
		;D ..AddEdges(Ln, .Idx)
		S Ln=Ln-1
		I '$D(vv(Ln+1)) S End=1
		}
	D ..DoPrint(.vv, .TilesVec)
}

/// do the print of the vv
ClassMethod DoPrint(ByRef vv, ByRef TilesVec)
{
	S $P(Spaces," ",1000)="", $P(Dash,"-",10)="",	 MaxLen=4, csi=$C(27)_"[", revAnsi=csi_"7m",clrAnsi=csi_"0m"
	S Min=9999,l="" F  S l=$O(vv(l)) Q:l=""  S p="" F  S p=$O(vv(l,p)) Q:p=""  S:p<Min Min=p  ; get minimum
	S ll="" F  {
		S ll=$O(vv(ll)) Q:ll=""
		K PosVec M PosVec=vv(ll)
		S StrSpace=$E(Spaces,1,2*$ZABS(Min-$O(PosVec(""))))
		W !,StrSpace S Pos="" F  S Pos=$O(PosVec(Pos)) Q:Pos=""  W " /"_$E(Dash,1,MaxLen-2)_"\"
		W !,StrSpace
		S Pos="" F  {
			S Pos=$O(PosVec(Pos)) Q:Pos=""
			S Tile=PosVec(Pos), isLast=($O(PosVec(Pos))=""), isFirst=($O(PosVec(Pos),-1)=""), isBlack=($L(Tile) && ($G(TilesVec(Tile))="b"))
			S val=..FixSP(Tile, Spaces, MaxLen)
			I isBlack S val=revAnsi_val_clrAnsi
			W "| "_val_" "_$S(isLast:"|",1:"")
			}
		W !,StrSpace S Pos="" F  S Pos=$O(PosVec(Pos)) Q:Pos=""  W " \"_$E(Dash,1,MaxLen-2)_"/"
		}
}

ClassMethod AddEdges(Ln, ByRef vv, ByRef Idx)
{
	Q:'$D(vv(Ln))
	S Left=$O(vv(Ln,"")), Right=$O(vv(Ln,""),-1)
	S tmpTile=vv(Ln,Left)
	While $L(tmpTile) { ; scan w
		S newTile=$G(Idx(tmpTile,"w"))
		I $L(newTile) S Left=Left-2, vv(Ln,Left)=newTile
		S tmpTile=newTile
		}
	S tmpTile=vv(Ln,Right)
	While $L(tmpTile) { ; scan e
		S newTile=$G(Idx(tmpTile,"e"))
		I $L(newTile) S Right=Right+2, vv(Ln,Right)=newTile
		S tmpTile=newTile
		}
}

ClassMethod FixSP(Str, Spaces, MaxLen)
{
	Quit Str_$E(Spaces,1,MaxLen-$L(Str)-2)
}

}
