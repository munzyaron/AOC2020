Include AOC2020.common

Class AOC2020.day16 Extends (%RegisteredObject, AOC2020.Base)
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
	; builad all data
	D ..Build(.Vec, .RuleVec, .NearVec, .YourTicket)
	; run on all tickets sum the invalid
	S Total=0 F i=1:1:NearVec {
		S Ticket=NearVec(i)
		S Total=Total+..SumTicketInvalid(Ticket, .RuleVec)
		}
	Quit Total
}

ClassMethod Part2(ByRef Vec) [ ProcedureBlock = 0 ]
{
	; builad all data
	D ..Build(.Vec, .RuleVec, .NearVec, .YourTicket)
	F i=1:1:NearVec {
		S Ticket=NearVec(i), Valid=(..SumTicketInvalid(Ticket, .RuleVec)=0)
		I Valid S ValidVec($I(ValidVec))=Ticket   ; if ticket is valid we put it om ValidVec
		}
	;; add your ticket to valid tickets list
	S ValidVec($I(ValidVec))=YourTicket
	;
	S Flds=$L(YourTicket,",")
	; run on all flds on all VALID Tickets, delete all rules that are not valid in ALL of them
	F Pos=1:1:Flds {
		M ValidRules(Pos)=RuleVec
		F Valid=1:1:ValidVec {
			S n=$P(ValidVec(Valid),",",Pos)
			D ..FindRuls(Pos, n, .RuleVec, .ValidRules)
			}
		}
		; build Valid on position
		F Pos=1:1:Flds S Rule="" F  S Rule=$O(ValidRules(Pos,Rule)) Q:Rule=""  S ValidPos(Rule,Pos)=""
		; run on ValidPos find entry with 1, then kill all other with this. do it until find all matches
		F Counter=1:1:Flds {
			S Rule="",Found=0 F  {
				S Rule=$O(ValidPos(Rule)) Q:Rule=""
				S First=$O(ValidPos(Rule,""))
				I $O(ValidPos(Rule,First))="" S Found=1
				Q:Found
				}
			I Found {
				S ResultVec(First)=Rule                                    ; save this rule+position
				S r="" F  S r=$O(ValidPos(r)) Q:r=""  K ValidPos(r,First)  ; kill all for this pos
				}
			}
		; multiple all fields that start with departure
		S Mul=1
		F i=1:1:Flds {
			S rc=$G(ResultVec(i))
			I rc?1"departure".e S n=$P(YourTicket,",",i) S Mul=Mul*n
			}
	Quit Mul
}

/// eliminate all rules that num is invalid for
ClassMethod FindRuls(Pos, Num, RuleVec, ByRef ValidRules)
{
	S Rule="" F  {
		S Rule=$O(RuleVec(Rule)) Q:Rule=""
		S t=RuleVec(Rule)
		S p1=$P(t," or ",1),p2=$P(t," or ",2)
		S n1=$P(p1,"-",1),n2=$P(p1,"-",2), n3=$P(p2,"-",1),n4=$P(p2,"-",2)
		I ( ((Num>=n1) && (Num<=n2)) || ( (Num>=n3 && (Num<=n4))) )=0 K ValidRules(Pos,Rule)  ; not in range 1 or 2
		}
}

ClassMethod ValidTicket(Ticket, RuleVec)
{
}

/// Sum all invalid number on a ticket
ClassMethod SumTicketInvalid(Ticket, RuleVec)
{
	S Total=0
	F i=1:1:$L(Ticket,",") {
		S n=$P(Ticket,",",i)
		I '..CheckNum(n, .RuleVec) S Total=Total+n
		}
	Quit Total
}

/// check number agains all rules if valid in ANY rule OK=1
ClassMethod CheckNum(Num, RuleVec)
{
	S OK=0
	S Rule="" F  {
		S Rule=$O(RuleVec(Rule)) Q:Rule=""
		S t=RuleVec(Rule)
		S p1=$P(t," or ",1),p2=$P(t," or ",2)
		S n1=$P(p1,"-",1),n2=$P(p1,"-",2), n3=$P(p2,"-",1),n4=$P(p2,"-",2)
		I ((Num>=n1) && (Num<=n2)) || ( (Num>=n3 && (Num<=n4))) S OK=1
		Q:OK
		}
	Quit OK
}

/// build all 
ClassMethod Build(ByRef Vec, ByRef RuleVec, ByRef NearVec, ByRef YourTicket)
{
	F i=1:1:Vec {
		S rc=Vec(i)
		I rc?.e1": ".e {
			S Numbers=$P(rc,": ",2)
			S RuleVec($P(rc,": ",1))=Numbers
			}
		ElseIf rc["your ticket:" {
			S YourTicket=Vec(i+1),i=i+1
			}
		ElseIf rc["nearby tickets:" { S Nearby=i }
		ElseIf $D(Nearby) && (i>Nearby) {
			S NearVec($I(NearVec))=rc
			}
		
		}
}

}
