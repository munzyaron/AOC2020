Class AOC2020.day4 Extends (%RegisteredObject, AOC2020.Base)
{

ClassMethod Test1(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S Valid=..Part1(.Vec)
	W !,"Valid = ",Valid
}

ClassMethod Test2(Example = 0)
{
	S sc=..GetVec($CLASSNAME(), Example, "", .Vec)
	S Valid=..Part2(.Vec)
	W !,"Valid = ",Valid
}

ClassMethod Test2valid()
{
	S sc=..GetVec($CLASSNAME(),, "day4-2-valid.txt", .Vec)
	S sc=..Part2(.Vec)
	W !,"sc = ",sc
}

ClassMethod Test2invalid()
{
	S sc=..GetVec($CLASSNAME(),, "day4-2-invalid.txt", .Vec)
	S sc=..Part2(.Vec)
	W !,"sc = ",sc
}

/// Part one - check if all flds are present. ignore "cid"
ClassMethod Part1(ByRef Vec)
{
	S Vec($I(Vec))="" ; add extra line at the end
	S Valid=0, Person=1 D ..Fields(.Fld)
	F i=1:1:Vec {
		I Vec(i)="" S:..Check1(Person, .Fld) Valid=Valid+1 S Person=Person+1 D ..Fields(.Fld) Continue
		s rc=Vec(i)
		F j=1:1:$L(rc," ") { 
			S t=$P(rc," ",j), ff=$P(t,":") K Fld(ff)
			}
		}
	Quit Valid
}

/// Part two  - check if all flds are present. ignore "cid"
/// Also do validity checks on flds
ClassMethod Part2(ByRef Vec)
{
	S Vec($I(Vec))="" ; add extra line at the end
	S Valid=0, Person=1 D ..Fields(.Fld)
	F i=1:1:Vec {
		I Vec(i)="" S:..Check2(Person, .MyVal, .Fld) Valid=Valid+1 S Person=Person+1 D ..Fields(.Fld) K MyVal Continue
		s rc=Vec(i)
		F j=1:1:$L(rc," ") { 
			S t=$P(rc," ",j)
			S ff=$P(t,":",1), vv=$P(t,":",2) S MyVal(ff)=vv
			K Fld(ff)
			}
		}
	Quit Valid
}

ClassMethod Check1(Person, ByRef Fld)
{
	K Fld("cid")  ; optional
	Quit '$D(Fld)
}

ClassMethod Check2(Person, ByRef MyVal, ByRef Fld)
{
	I '..Check1(Person, .Fld) Quit 0
	S Ok=1 S vv="" F  Q:'Ok  S vv=$O(MyVal(vv)) Q:vv=""  S Ok=..CheckOneFld(vv,MyVal(vv))
	Quit Ok
}

/// Check spesific fld - part2
ClassMethod CheckOneFld(Fld, Val)
{
	I Fld="byr" { S Result=( (Val?4n) && (Val>=1920) && (Val<=2002) ) }
	ElseIf Fld="iyr" { S Result=( (Val?4n) && (Val>=2010) && (Val<=2020) ) }
	ElseIf Fld="eyr" { S Result=( (Val?4n) && (Val>=2020) && (Val<=2030) ) }
	ElseIf Fld="hgt" { 
		I $E(Val,*-1,*)="cm" { S n=$E(Val,1,*-2), Result= ( n?1.n && (n>=150) && (n<=193)  ) }
		ElseIf $E(Val,*-1,*)="in" { S n=$E(Val,1,*-2), Result = ( n?1.n && (n>=59) && (n<=76) )}
		Else { S Result=0 }
		}
	ElseIf Fld="hcl" { S Result=( $E(Val,1)="#" && ($match($E(Val,2,*),"([0-9]|[a-f]){6}")) ) }
	ElseIf Fld="ecl" { S Result=( Val="amb" || (Val="blu") || (Val="brn") || (Val="gry") || (Val="grn") || (Val="hzl") || (Val="oth") ) }
	ElseIf Fld="pid" { S Result=($L(Val)=9) }
	ElseIf Fld="cid" { S Result=1 }  ;always ok
	Quit Result
}

/// required feilds
ClassMethod Fields(ByRef Fld)
{
	K Fld
	S Fld("byr")="(Birth Year)"
	S Fld("iyr")="(Issue Year)"
	S Fld("eyr")="(Expiration Year)"
	S Fld("hgt")="(Height)"
	S Fld("hcl")="(Hair Color)"
	S Fld("ecl")="(Eye Color)"
	S Fld("pid")="(Passport ID)"
	S Fld("cid")="(Country ID)"
}

}
