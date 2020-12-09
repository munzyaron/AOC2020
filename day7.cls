Class AOC2020.day7 Extends (%RegisteredObject, AOC2020.Base)
{

ClassMethod Test1(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S sc=..Part1(.Vec)
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S sc=..Part2(.Vec)
}

ClassMethod Part1(ByRef Vec)
{
	D ..ColVec(.Vec, .ColVec)
	S Color="shiny gold" D ..Calc(.ColVec,Color,.Output)
	S can="" F Total=0:1 S can=$O(Output(can)) Q:can=""   ; count how many can
	W !,"total can carry = ",Total
	Quit 1
}

ClassMethod Part2(ByRef Vec)
{
	D ..ColVec(.Vec, .ColVec)
	S Color="shiny gold",Output=0
	D ..Calc2(.ColVec, Color, .Output)
	S Output=Output-1  ; need to remove the shiny gold bag itself !
	W !,"Total needed = ",Output
	Quit 1
}

ClassMethod Calc2(ByRef ColVec, Color, ByRef Output)
{
	I $D(ColVec(Color))=1 { S Under=0 }
	Else {
		S Under=0
		S hold="" F  S hold=$O(ColVec(Color,hold)) Q:hold=""  S num=ColVec(Color,hold) D
		. S Under=Under+(num*..Calc2(.ColVec,hold, .Output))
		}
	S Result=1+Under
	S Output=Result  ; to accumalted the results within recursion
	Quit Result
}

ClassMethod Calc(ByRef ColVec, Color, ByRef Output)
{
	S Counter=..GetDepend(.ColVec, Color, .canCarryVec)
	S can="" F  S can=$O(canCarryVec(can)) Q:can=""  S Output(can)="" D ..Calc(.ColVec, can,.Output)
}

/// count how many colors can carry a specific "Color"
/// This is search "Color" as 2nd key in ColVec array
ClassMethod GetDepend(ByRef ColVec, Color, ByRef CanCarryVec)
{
	K CanCarryVec
	S Counter=0
	S Col1="" F  S Col1=$O(ColVec(Col1)) Q:Col1=""  I $D(ColVec(Col1,Color)) S CanCarryVec(Col1)=ColVec(Col1,Color),Counter=Counter+1
	Quit Counter
}

/// build relation between colors according to input text
/// text WITH depedecies: "[color name] bags contain [number] [color name] bags, [number] [color name] bags .... "
/// text for no dependencies: "[color name] contain no other bags."
ClassMethod ColVec(ByRef Vec, ByRef ColVec)
{
	K ColVec
	F i=1:1:Vec {
		S rc=Vec(i), Color=$P(rc," bags contain ",1),Other=$P(rc," bags contain ",2,*)
		I Other?1.n1" ".e1" bag".e {   ; search for: "[number] bag"
			F j=1:1:$L(Other,",") {
				S t=$ZSTRIP($P(Other,",",j),"<>w"),oColor=$P($P(t," bag",1)," ",2,*),tQuan=$P($P(t," bag",1)," ",1)
				S ColVec(Color,oColor)=tQuan
				}
			}
		Else {  ; text for no dependencies "[color name] contain no other bags."
			S ColVec(Color)=""
			}
		}
}

}
