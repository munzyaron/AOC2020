Include AOC2020.common

Class AOC2020.day20 Extends (%RegisteredObject, AOC2020.Base)
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
	D ..Read(Example,"", .AllTileVec)
	$$$sTime S Result = ..Part1(.AllTileVec) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0, File = "")
{
	D ..Read(Example, File,	 .AllTileVec)
	$$$sTime S Result=..Part2(.AllTileVec, Example) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

/// order the tiles
ClassMethod Part1(ByRef AllTileVec)
{
	S Tile="" F NumOfTiles=0:1 S Tile=$O(AllTileVec(Tile)) Q:Tile=""  ; count the number of tiles
	S GridSize=$ZSQR(NumOfTiles)
	W !,"Num of Tiles = ",NumOfTiles,"   grid size = " ,GridSize
	;
	K %InGrid
	S Tile=""
	F  {
		S Tile=$O(AllTileVec(Tile)) Q:Tile=""||($G(%InGrid)=NumOfTiles)
		D ..ProcessTile(Tile, .AllTileVec, GridSize, NumOfTiles, .PartGrid,0)
		}
	;
	M ^image=%InGrid  ; to save to PART II
	D ..PrintPart(.PartGrid)
	K SortVec S Tile="" F  S Tile=$O(%InGrid(Tile)) Q:Tile=""  S n=$P(%InGrid(Tile),"*",1) S SortVec(n)=Tile
	S Tot=0,Mul=1,n="" F Count=1:1 S n=$O(SortVec(n)) Q:n=""  I (Count=1)||(Count=GridSize)||(Count=(GridSize**2-GridSize+1))||(Count=(GridSize**2)) S Mul=Mul*SortVec(n)
	Quit Mul
}

/// trt to add tile and check all options. %InGrid = number we have in PartGird
ClassMethod ProcessTile(Tile, ByRef AllTileVec, GridSize, NumOfTiles, ByRef PartGrid, Level)
{
	F Angle=0,90,180,270 {
		Q:$G(%InGrid)=NumOfTiles
		F Flip="N","X","Y" {
			Q:$G(%InGrid)=NumOfTiles
			I Level=0 K PartGrid,%InGrid
			K TileVec M TileVec=AllTileVec(Tile)
			D ..RotateTile(Angle, .TileVec)
			D ..FlipTile(Flip, .TileVec)
			S OK=..AddTile(Tile, Angle, Flip, .TileVec, .PartGrid, GridSize)
			I OK {
				S NewTile=""
				F  {
					S NewTile=$O(AllTileVec(NewTile)) Q:NewTile=""
					I $D(%InGrid(NewTile)) Continue
					D ..ProcessTile(NewTile, .AllTileVec, GridSize, NumOfTiles, .PartGrid, Level+1)
					}
				}
			}
		}
	Q
}

/// Add a tile to to right/bottom
/// Where = R = right / "B" = bottom
/// Part = 1 /2 in part I we build only frame, but in part II we build all
ClassMethod AddTile(Tile, Angle, Flip, ByRef TileVec, ByRef PartGrid, GridSize, Part = 1)
{
	M tmpPartGrid=PartGrid
	; find MAX line then check MAX ROW on that line
	S MaxLine=0,Row="" F  S Row=$O(tmpPartGrid(Row)) Q:Row=""  S Line="" F  S Line=$O(tmpPartGrid(Row,Line)) Q:Line=""  I Line>MaxLine S MaxLine=Line
	S MaxRow=0,Row="" F  S Row=$O(tmpPartGrid(Row)) Q:Row=""  I $D(tmpPartGrid(Row,MaxLine)) && (Row>MaxRow) S MaxRow=Row
	I MaxRow<(10*GridSize) { S:MaxLine>0 MaxLine=MaxLine-10 }
	ELse { S MaxRow=0 }  ; We finished a row
	;
	;; asume time size is always 10x10
	;D ..PrintPart(.TileVec)
	F Line=1:1:10 {
		F Row=1:1:10 {
			S newRow=MaxRow+Row,newLine=MaxLine+Line
			I Part=2 || ((newRow#10<2) || (newLine#10<2)) {
				S tmpPartGrid(newRow,newLine)=TileVec(Row,Line)
				}
			
			
			}
		}
	;
	S GridOK=$S(Part=1:..chkPartGrid(.tmpPartGrid),1:1)  ; asume grid ok for part II
	I GridOK {
		K PartGrid M PartGrid=tmpPartGrid
		S %InGrid(Tile)=$I(%InGrid)_"*"_Angle_"*"_Flip
		}
	Quit GridOK
}

/// check partial grid is having its tiles is border that should line up exactly with its adjacent tiles
/// TODO: make sure it check what we have already = PARTIAL !
ClassMethod chkPartGrid(ByRef PartGrid)
{
	S OK=1
	D ..GetMaxLineRow(.PartGrid, .MaxRow, .MaxLine)  ; get max line & row
	; check vertical
	F Line=1:1:MaxLine {
		Q:'OK
		F Row=10:10:MaxRow {
			Q:'OK
			Q:'$D(PartGrid(Row+1,Line))
			I PartGrid(Row,Line)'=PartGrid(Row+1,Line) S OK=0
			}
		}
	; check horizontal
	I OK {
		F Line=10:10:MaxLine {
			F Row=1:1:MaxRow {
				Q:'OK
				Q:'$D(PartGrid(Row,Line+1))
				I PartGrid(Row,Line)'=PartGrid(Row,Line+1) S OK=0
				}
			}	
		}
	Quit OK
}

/// print any part of the Partial Grid
ClassMethod PrintPart(ByRef PartGrid, TileSize = 10)
{
	D ..GetMaxLineRow(.PartGrid, .MaxRow, .MaxLine)  ; get max line & row
	F Line=1:1:MaxLine { 
		W !
		F Row=1:1:MaxRow W $S($D(PartGrid(Row,Line)):PartGrid(Row,Line),1:"-") I Row#TileSize=0 W "|"
		I Line#TileSize=0 W !,Line,"------------------------------"
		}
}

/// Get the max Row & Line for PartGird
ClassMethod GetMaxLineRow(ByRef PartGrid, ByRef MaxRow, ByRef MaxLine)
{
	S MaxRow=$O(PartGrid(""),-1)
	S MaxLine=0,Row="" F  S Row=$O(PartGrid(Row)) Q:Row=""  S Line="" F  S Line=$O(PartGrid(Row,Line)) Q:Line=""  S:Line>MaxLine MaxLine=Line
}

/// Rotate Tile in angle (90,180,270)
ClassMethod RotateTile(Angle, ByRef TileVec)
{
	I Angle=0 Q  ; angel 0 = Return the same
	K tmpTileVec
	S Max=$O(TileVec(""),-1)
	F Line=1:1:Max {
		F Row=1:1:Max {
			S newRow=$Case(Angle,90:Max-Line+1,180:Max-Row+1,270:Line,:Row)
			S newLine=$Case(Angle,90:Row,180:Max-Line+1,270:Max-Row+1,:Line)
			S tmpTileVec(newRow,newLine)=TileVec(Row,Line)
			}
		}
	K TileVec M TileVec=tmpTileVec
}

/// Flip tile (X/Y). FlipX = [ x --> x , y --> max-y+1 ]  / FlipY = [ x --> max-x+1 , y --> y]
/// if Flip = "N" no rotate will return same
ClassMethod FlipTile(Flip, ByRef TileVec)
{
	I Flip="N" Q  ; Flip = "N" return the same
	K tmpTileVec
	S Max=$O(TileVec(""),-1)
	F Line=1:1:Max {
		F Row=1:1:Max {
			S newRow=$Case(Flip,"X":Row,"Y":Max-Row+1)
			S newLine=$Case(Flip,"X":Max-Line+1,"Y":Line)
			S tmpTileVec(newRow,newLine)=TileVec(Row,Line)
			}
		}
	K TileVec M TileVec=tmpTileVec
}

ClassMethod Part2(ByRef AllTileVec, Example)
{
	S Glo=$S(Example:"^image11",1:"^image")
	; We have the final result of Part I in ^image
	; TODO chage ^image11 to ^image
	S Tile="" F  {
		S Tile=$O(@Glo@(Tile)) Q:Tile=""
		S SortVec($P(@Glo@(Tile),"*",1))=Tile_"*"_$P(@Glo@(Tile),"*",2,*)
		}
	; insert images at the order we build it
	S GridSize=$ZSQR($O(SortVec(""),-1))
	F Count=1:1 {
		Q:'$D(SortVec(Count))
		S rc=SortVec(Count), Tile=$P(rc,"*",1),Angle=$P(rc,"*",2), Flip=$P(rc,"*",3)	
		K TileVec M TileVec=AllTileVec(Tile)
		D ..RotateTile(Angle, .TileVec)
		D ..FlipTile(Flip, .TileVec)
		D ..AddTile(Tile, Angle, Flip, .TileVec, .PartGrid, GridSize, 2)
		}
	;
	; remove the borders
	D ..GetMaxLineRow(.PartGrid, .MaxRow, .MaxLine)
	; build New Grid without borders
	F Line=1:1:MaxLine {
		I Line#10<2 Continue
		S newLine=$I(newLine), newRow=0
		F Row=1:1:MaxRow {
			I Row#10<2 Continue
			S newRow=$I(newRow)
			S newPartGrid(newRow,newLine)=PartGrid(Row,Line)
			}
		}
	D ..GetMonster(.MonsterVec)
	D ..GetMaxLineRow(.newPartGrid, .MaxRow, .MaxLine)
	; Count how many # are in the grid
	S Tot=0 F Row=1:1:MaxRow F Line=1:1:MaxLine I newPartGrid(Row,Line)="#" S Tot=Tot+1
	W !,"Total # is new grid (",MaxLine,")  :",Tot
	; Main loop on all combinations
	S Total=0
	F Angle=0,90,180,270 {
		F Flip="N","X","Y" {
			K TileVec M TileVec=newPartGrid
			D ..RotateTile(Angle, .TileVec)
			D ..FlipTile(Flip, .TileVec)
			S Count=..FindMonster(.TileVec, MaxLine, .MonsterVec)  ; MaxLine = MaxRow without the borders
			I Count {
				W !,"Angle = ",Angle,"  Flip = ",Flip,"  Count = ",Count r xxx
				S Total=Total+Count
				}
			
			}
		}
	W !,"Total = ",Total
	S Result=Tot-(Total*15)  ; we hace 15 # in moster
	W !,"Result = ",Result
	
	Quit Result
}

/// find how many mosters are in Gird
ClassMethod FindMonster(ByRef Grid, Max, ByRef MonsterVec)
{
	S Count=0
	F Line=1:1:Max-3+1 {   ; moster size is 20x3
		F Row=1:1:Max-20+1 {
			I ..CheckMonster(Row,Line, .Grid, .MonsterVec) S Count=Count+1
			}
		}
	Quit Count
}

/// check id mostoer fit in Row,Line on the gird
ClassMethod CheckMonster(Row, Line, ByRef Grid, ByRef MonsterVec)
{
	S OK=1  ; assume all ok
	S mRow="" F  {
		Q:'OK
		S mRow=$O(MonsterVec(mRow)) Q:mRow=""
		S mLine="" F  {
			Q:'OK
			S mLine=$O(MonsterVec(mRow,mLine)) Q:mLine=""
			I Grid(Row+mRow-1,Line+mLine-1)'="#" S OK=0
			}
		}
	Quit OK
}

/// read the file with the moster definition
ClassMethod GetMonster(ByRef MonsterVec)
{
	K MonsterVec
	S sc=..GetVec($CLASSNAME(), 0, "day20-sea-monster.txt", .Vec)
	F Line=1:1:Vec {
		S rc=Vec(Line)
		W !,rc
		S Pos=-1 
		F  {
			S Pos=$Find(rc,"#",Pos) Q:Pos=0
			S MonsterVec(Pos-1,Line)="#", Count=$I(Count)
			}
		}
	S MonsterVec=Count  ; total # in moster
}

/// read the file into TileVec(Tile,x,y)
ClassMethod Read(Example = 1, File = "", ByRef AllTileVec)
{
	S Msgs=0
	S sc=..GetVec($CLASSNAME(), Example, File, .Vec)
	F i=1:1:Vec {
		S rc=Vec(i)
		I rc["Tile" {
			S Tile=$P($P(rc," ",2),":",1),y=1
			}
		ElseIf $L(rc) {  ; to skip empty line
			F x=1:1:10 { S t=$E(rc,x), AllTileVec(Tile,x,y)=t }
			S y=y+1
		}
	}
}

}
