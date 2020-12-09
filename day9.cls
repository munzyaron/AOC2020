Include AOC2020.common

Class AOC2020.day9 Extends (%RegisteredObject, AOC2020.Base)
{

ClassMethod Test1(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	$$$sTime S Num =..Part1(.Vec, $S(Example:5,1:25) ) $$$eTime
	W !,"Num = ",Num
	$$$totTime
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	$$$sTime
	S Num =..Part1(.Vec, $S(Example:5,1:25) )  ; we need the number from Part 1 as input here
	S sc = ..Part2(.Vec,Num, .Sum) $$$eTime
	I sc W !,"Sum = ",Sum
	$$$totTime
}

/// Find the 1st number that its PREAMBLE numbers does not have a sum of two
ClassMethod Part1(ByRef Vec, Premable)
{
	F i=Premable+1:1:Vec {
		K PreVec F j=i-Premable:1:i-1 S PreVec($I(PreVec))=Vec(j)  ; build the PreVec
		S Num=Vec(i)
		S Found = ..Check(Num, .PreVec)
		I 'Found Return Num  ; looking for the 1st number that does not have a sum in Preamble
		}
	Quit 1
}

/// Find Contiguous numbers that give a sum = Num
ClassMethod Part2(ByRef Vec, Num, ByRef Sum)
{
	S Found = ..FindContiguous(.Vec,Num, .ConVec)
	I Found S Sum = $O(ConVec("")) + $O(ConVec(""),-1)
	Quit 1
}

/// Find Contiguous numbers that give a sum = Num
ClassMethod FindContiguous(ByRef Vec, ToSum, ConVec)
{
	K ConVec
	S Found=0
	F i=1:1:Vec {
		Q:Found
		S n1=Vec(i)
		S Tot=0,TooBig=0
		K ConVec
		F j=i+1:1:Vec {
			Q:Found||TooBig
			S n2=Vec(j), ConVec(n2)=""
			S Tot=Tot+n2
			I Tot>ToSum S TooBig=1
			I Tot=ToSum S Found=1
			}
		}
	Quit Found
}

/// check if num is sum of 2 numbers in PreVec. Return 0/1
ClassMethod Check(Num, ByRef PreVec)
{
	S Found=0 
	F a=1:1:PreVec {
		Q:Found
		S n1=PreVec(a)
		F b=a+1:1:PreVec {
			Q:Found
			S n2=PreVec(b)
			I n1+n2=Num S Found=1
			}
		}
	Quit Found
}

}
