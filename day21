Include AOC2020.common

Class AOC2020.day21 Extends (%RegisteredObject, AOC2020.Base)
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
	D ..Read(Example,"", .FoodVec)
	$$$sTime S Result = ..Part1(.FoodVec) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0, File = "")
{
	D ..Read(Example, File,	 .FoodVec)
	$$$sTime S Result=..Part2(.FoodVec, .Found) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

/// order the tiles
ClassMethod Part1(ByRef FoodVec, ByRef Found)
{
	D ..BuildIdx(.FoodVec, .Idx)
	F Food=1:1:FoodVec {
		K tmpAllergan M tmpAllergan=FoodVec(Food,"A")
		S Ing="" F  {
			S Ing=$O(FoodVec(Food,"I",Ing)) Q:Ing=""
			S Allergan="" F  {
				S Allergan=$O(tmpAllergan(Allergan)) Q:Allergan=""
				D ..FindMatchAllerganIng(.FoodVec, .Idx, .Found)
				D ..ChkAllIng(.FoodVec, .Idx)
				}
			}
		}
	; count all ingredient left on FoodVec (since we delete all those that are Allergans)
	S Result=0
	F Food=1:1:FoodVec {
		S Ing="" F  {
			S Ing=$O(FoodVec(Food,"I",Ing)) Q:Ing=""  S Result=Result+1
			}
		}
	Quit Result
}

/// runs on all Ingredient-Allergan possibilities
/// if 1 ingredient CAN BE an Allergan if MUST apear on all FOODS with that Allergan listed.
/// if it is NOT in ANY of those FOODS, than that possibility is not true
ClassMethod ChkAllIng(ByRef FoodVec, ByRef Idx)
{
	S Ing="" F  {
		S Ing=$O(Idx("IngAllergan",Ing)) Q:Ing=""
		S Allergan="" F  {
			S Allergan=$O(Idx("IngAllergan",Ing,Allergan)) Q:Allergan=""
			S IngInAll=1
			S Food="" F {
				S Food=$O(Idx("Allergan",Allergan,Food)) Q:Food=""
				Q:'IngInAll
				I '$D(FoodVec(Food,"I",Ing)) S IngInAll=0
				}
			I 'IngInAll K Idx("IngAllergan",Ing,Allergan), Idx("AllerganIng",Allergan,Ing)	
			}
		}
}

/// run on AllerganIng to find only 1 option for any Allerga[ (e.g. AllerganIng("dairy","mxmxvkd")="" ]
ClassMethod FindMatchAllerganIng(ByRef FoodVec, ByRef Idx, ByRef Found)
{
	
	S Allergan="" F  {
		S Allergan=$O(Idx("AllerganIng",Allergan)) Q:Allergan=""
		S Ing=$O(Idx("AllerganIng",Allergan,""))
		I $O(Idx("AllerganIng",Allergan,Ing))="" {                         ; only 1 no next
			S Found("I",Ing)=Allergan, Found("A",Allergan)=Ing             ; this will hold the final results
			K Idx("AllerganIng",Allergan), Idx("IngAllergan",Ing)          ; delete from Index
			S Food="" F  S Food=$O(Idx("Allergan",Allergan,Food)) Q:Food=""  K FoodVec(Food,"A",Allergan) S FoodVec(Food,"A")=FoodVec(Food,"A")-1
			K Idx("Allergan",Allergan)
			S Food="" F  S Food=$O(Idx("Ing",Ing,Food)) Q:Food=""  K FoodVec(Food,"I",Ing) S FoodVec(Food,"I")=FoodVec(Food,"I")-1
			K Idx("Ing",Ing)
			S Allergan="" F  S Allergan=$O(Idx("AllerganIng",Allergan)) Q:Allergan=""  I $D(Idx("AllerganIng",Allergan,Ing)) K Idx("AllerganIng",Allergan,Ing)
			}
		}
}

/// Build Index on Allergan, Ingredient, & both
ClassMethod BuildIdx(ByRef FoodVec, ByRef Idx)
{
	K Idx
	F Food=1:1:FoodVec {
		S Allergan="" F  S Allergan=$O(FoodVec(Food,"A",Allergan)) Q:Allergan=""  S Idx("Allergan",Allergan,Food)=""
		S Ing="" F  S Ing=$O(FoodVec(Food,"I",Ing)) Q:Ing=""  S Idx("Ing",Ing,Food)=""
		}
	S Ing="" F  S Ing=$O(Idx("Ing",Ing)) Q:Ing=""  S Allergan="" F  S Allergan=$O(Idx("Allergan",Allergan)) Q:Allergan=""  S Idx("IngAllergan",Ing,Allergan)="", Idx("AllerganIng",Allergan,Ing)=""
}

ClassMethod Part2(ByRef FoodVec, ByRef Found)
{
	S Result=..Part1(.FoodVec, .Found)
	S Text="",Allergan="" F  S Allergan=$O(Found("A",Allergan)) Q:Allergan=""  S Text=Text_Found("A",Allergan)_","
	S Text=$ZSTRIP(Text,"<>",",")
	Quit Text
}

/// read the file into FoodVec(food,ingredian)=""  
ClassMethod Read(Example = 1, File = "", ByRef FoodVec)
{
	S sc=..GetVec($CLASSNAME(), Example, File, .Vec)
	F i=1:1:Vec {
		S rc=Vec(i)
		S Ingredients =$P(rc," (",1), Allergens=$P($P(rc," (contains ",2),")",1)
		S FoodVec=$I(FoodVec)
		F j=1:1:$L(Ingredients," ") S Ing=$P(Ingredients," ",j) S FoodVec(FoodVec,"I",Ing)=""
		S FoodVec(FoodVec,"I")=j
		F Count=1:1:$L(Allergens,",") S OneAllergan=$ZSTRIP($P(Allergens,",",Count),"<>w"), FoodVec(FoodVec,"A",OneAllergan)=""
		S FoodVec(FoodVec,"A")=Count
	}
}

}
