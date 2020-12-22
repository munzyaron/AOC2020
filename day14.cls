Include AOC2020.common

Class AOC2020.day14 Extends (%RegisteredObject, AOC2020.Base)
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

ClassMethod Test1(Example = 0, File = "")
{
	S sc=..GetVec($CLASSNAME(), Example, File, .Vec)
	$$$sTime S Result = ..Part1(.Vec) $$$eTime
	W !,"PART I Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0, File = "")
{
	S sc=..GetVec($CLASSNAME(), Example, File, .Vec)
	$$$sTime S Result = ..Part2(.Vec) $$$eTime
	W !,"PART II Result = ",Result
	$$$totTime
}

ClassMethod Part1(ByRef Vec)
{
	F i=1:1:Vec {
		S rc=Vec(i)
		I rc?1"mask".e { S Mask=$P(rc,"mask = ",2) Continue}
		ElseIf rc?1"mem".e { S Addr=$P($P(rc,"[",2),"]",1), Val=$P(rc," = ",2) }
		S MemVec(Addr)=..Calc(Mask,Val)
		}
	; sum all addresses in MemVec
	S Tot=0, a="" F  S a=$O(MemVec(a)) Q:a=""  S Tot=Tot+MemVec(a)
	Quit Tot
}

/// PART I = calculate a number with mask
ClassMethod Calc(Mask, Val)
{
	S Bin=..DecToBin(Val,36)
	F i=1:1:$L(Mask) S t=$E(Mask,i) S:t=0 $E(Bin,i)=0 S:t=1 $E(Bin,i)=1
	S Result=..BinToDec(Bin)
	Quit Result
}

/// PART II = calculate the mask on addrss to get all possible addresses
ClassMethod Calc2(Mask, Addr, Val, ByRef AddrVec)
{
	K AddrVec S BinAddr=..DecToBin(Addr,36), BinVal=..DecToBin(Val,36)
	F i=1:1:$L(Mask) S t=$E(Mask,i) S:t=0 $E(Bin,i)=0 S:t=1 $E(Bin,i)=1  ; change value with mask
	F i=1:1:$L(Mask) S t=$E(Mask,i) S:t=1 $E(BinAddr,i)=1 S:t="X" $E(BinAddr,i)="X"  ; change the address with mask
	; build str with positions that have X
	S PosX="" F i=1:1:$L(BinAddr) I $E(BinAddr,i)="X" S PosX=PosX_","_($L(BinAddr)-i+1)
	S PosX=$ZSTRIP(PosX,"<>",",")
	; get all combinations for PosX string format "1,3,7..."
	D ##class(AOC2020.Math).Combinations(PosX,.CombVec)
	;
	;We need the 1st combination (all 0's manually))
	S Mask0=$Replace(BinAddr,"X",0)
	S AddrVec(..BinToDec(Mask0))=Val ;We need the 1st combination (all 0's manually))
	; Set the address to all combinations to AddrVec(Ln)=Decimal Number
	D ..AddrComb(Val, BinAddr, .CombVec, .AddrVec)
}

/// Get all possible of address based on CombVec
ClassMethod AddrComb(Val, Addr, ByRef CombVec, ByRef AddrVec)
{
	S Sub="" F  {
		S Sub=$O(CombVec(Sub))
		Q:Sub=""
		S tmpAddr=Addr F i=1:1:$L(Sub,",") S Ch=$P(Sub,",",i), $E(tmpAddr,$L(tmpAddr)-Ch+1)=1
		S tmpAddr=$Replace(tmpAddr,"X",0)  ; replace all rest X with 0
		S AddrVec(..BinToDec(tmpAddr))=Val
		}
}

ClassMethod Part2(ByRef Vec)
{
	F i=1:1:Vec {
		S rc=Vec(i)
		I rc?1"mask".e { S Mask=$P(rc,"mask = ",2) Continue}
		ElseIf rc?1"mem".e { S Addr=$P($P(rc,"[",2),"]",1), Val=$P(rc," = ",2) }
		K AddrVec D ..Calc2(Mask,Addr,Val,.AddrVec)
		M AllAddr=AddrVec
		}
	S Tot=0
	S Addr="" F  S Addr=$O(AllAddr(Addr)) Q:Addr=""  S Tot=Tot+AllAddr(Addr)
	Quit Tot
}

}
