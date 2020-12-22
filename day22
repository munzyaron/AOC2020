Include AOC2020.common

Class AOC2020.day22 Extends (%RegisteredObject, AOC2020.Base)
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
	D ..Read(Example, "",	 .P1vec, .P2vec)
	$$$sTime S Result = ..Part1(.P1vec, .P2vec, Debug) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

ClassMethod Test2(Example = 0, Debug = 0)
{
	D ..Read(Example, "",	 .P1vec, .P2vec)
	; for test infinate loop
	I Example=2 {  ; to test exit on duplicates to prevent infinate loop
		K P1vec F a=43,19 S P1vec($I(P1vec))=a  ;Player 1:
		K P2vec F a=2,29,14 S P2vec($I(P2vec))=a
		}
	$$$sTime S Result=..Part2(.P1vec, .P2vec, Debug) $$$eTime
	W !,"Result = ",Result
	$$$totTime
}

/// order the tiles
ClassMethod Part1(ByRef P1vec, ByRef P2vec, Debug)
{
	While $D(P1vec) && $D(P2vec) {
		S Round=$I(Round)
		D ..PlayRound(Round, .P1vec, .P2vec, Debug)
		}
	I $D(P1vec) { M DeckVec=P1vec } Else { M DeckVec=P2vec}
	Quit ..CalcTotal(.DeckVec)
}

/// PART I = Play 1 round
ClassMethod PlayRound(Round, ByRef P1vec, ByRef P2vec, Debug)
{
	I Debug {
		W !,"-- Round ",Round," --"
		W !,"Player 1's deck: " F i=1:1:P1vec W P1vec(i) W:i<P1vec ", "
		W !,"Player 2's deck: " F i=1:1:P2vec W P2vec(i) W:i<P2vec ", "
		}
	S P1card=P1vec(1), P2card=P2vec(1) K P1vec(1),P2vec(1)  ; top deck - card to play
	S Winner=$S(P1card>P2card:1,1:2)
	I Debug {
		W !,"Player 1 plays: ",P1card,!,"Player 2 plays: ",P2card
		W !,"Player ",Winner," wins the round!"
		}
	S Card1=$Case(Winner,1:P1card,:P2card)
	S Card2=$Case(Winner,1:P2card,:P1card)	
	D ..ShiftDeck(.P1vec, $S(Winner=1:Card1,1:""), $S(Winner=1:Card2,1:""))
	D ..ShiftDeck(.P2vec, $S(Winner=2:Card1,1:""), $S(Winner=2:Card2,1:"") )
}

/// to organize the deck so 2->1 3->2 and so on.
/// optional (for winner) to have the 2 cards win at last round at the botom (highet on top)
/// optional for PART II = TakeNumber - build new deck ONLY with the # of cards (TakeNumber)
ClassMethod ShiftDeck(ByRef DeckVec, WinCard1 = "", WinCard2 = "", TakeNumber = 0)
{
	F Count=1:1:$S(TakeNumber>0:TakeNumber,1:DeckVec-1) S DeckVec(Count)=DeckVec(Count+1)  ; move all 1 up
	F Count=$S(TakeNumber>0:TakeNumber+1,1:DeckVec):1:DeckVec K DeckVec(Count)             ; kill the rest
	S DeckVec=$S(TakeNumber>0:TakeNumber,1:DeckVec-1) I DeckVec=0 K DeckVec                ; update root if empty kill so '$D() will work
	I $L(WinCard1) {                                                                       ; if win 1 then also WinCard2 '= "" add winning cards to the deck
		S DeckVec($I(DeckVec))=WinCard1
		S DeckVec($I(DeckVec))=WinCard2
		}
}

ClassMethod Part2(ByRef P1vec, ByRef P2vec, Debug)
{
	S Round=0, %GLobalGameCount=0
	D ..PlayGame(Round, .P1vec, .P2vec, Debug)
	I $D(P1vec) { M DeckVec=P1vec } Else { M DeckVec=P2vec}
	Quit ..CalcTotal(.DeckVec)
}

/// Play recursive game
ClassMethod PlayGame(Round, ByRef P1vec, ByRef P2vec, Debug)
{
	S %GLobalGameCount=$I(%GLobalGameCount)
	I Debug W !,"=== Game ",%GLobalGameCount," ==="
	K DupIdx  ; for each game we need new one
	While $D(P1vec) && $D(P2vec) {
		S Winner =..PlayRound2(.Round, .P1vec, .P2vec, .DupIdx, Debug)
		}
	Quit Winner
}

/// PART II = Play 1 round WITH recursion
/// Level = recursion level not sure where used 
ClassMethod PlayRound2(ByRef Round, ByRef P1vec, ByRef P2vec, ByRef DupIdx, Debug = 0)
{
	
	S Round=Round+1
	I Debug W !,"-- Round ",Round," (Game ",%GLobalGameCount,") --"
	I Debug W !,"Player 1's deck: (",P1vec,") " F i=1:1:P1vec W P1vec(i) W:i<P1vec ", "
	I Debug W !,"Player 2's deck: (",P2vec,") " F i=1:1:P2vec W P2vec(i) W:i<P2vec ", "
	I ..WasInThisGame(Round, .P1vec, .P2vec, .DupIdx) K P2vec Quit 1   ; winner is always player 1 /  to exit and end the game we assume P2 has no cards left
	S P1card=P1vec(1), P2card=P2vec(1) K P1vec(1),P2vec(1)  ; top deck - card to play
	I Debug W !,"Player 1 plays: ",P1card
	I Debug W !,"Player 2 plays: ",P2card
	S P1Left=P1vec-1, P2Letf=P2vec-1  ; how many left in each players deck
	I (P1card<=P1Left) && (P2card<=P2Letf) {
		I Debug W !,"Playing a sub-game to determine the winner..."
		M bck("P1")=P1vec, bck("P2")=P2vec, bck("Dup")=DupIdx   ; backup deck before recursion
		D ..ShiftDeck(.P1vec,"","",P1card)
		D ..ShiftDeck(.P2vec,"","",P2card)
		S Winner = ..PlayGame(0, .P1vec, .P2vec, Debug)
		I Debug W !,"The winner of game ",(%GLobalGameCount)," is player ",Winner_" !"
		K P1vec,P2vec,DupIdx M P1vec=bck("P1"), P2vec=bck("P2"), DupIdx=bck("Dup")   ; restore deck & duplicates after recursion
		}
	Else {
		S Winner=(1+(P2card>P1card))  ; 1 or 2 
		}
	S Card1=$Case(Winner,1:P1card,:P2card), Card2=$Case(Winner,1:P2card,:P1card)	; which card to add to deck of winner when rebuil the deck
	I Debug W !,"Player ",Winner," wins round ",Round," of game ",%GLobalGameCount
	D ..ShiftDeck(.P1vec, $S(Winner=1:Card1,1:""), $S(Winner=1:Card2,1:""))
	D ..ShiftDeck(.P2vec, $S(Winner=2:Card1,1:""), $S(Winner=2:Card2,1:"") )
	Q Winner
}

/// Check if there was a previous round in this game that had exactly the same cards in the same order in the same players decks
/// If yes Return 1, if no Return 0
ClassMethod WasInThisGame(Round, ByRef P1vec, ByRef P2vec, ByRef DupIdx)
{
	S t1="" F i=1:1:P1vec S t1=t1_P1vec(i)_","
	S t2="" F i=1:1:P2vec S t2=t2_P2vec(i)_","
	S t1=$ZSTRIP(t1,"<>",","), t2=$ZSTRIP(t2,"<>",",")
	; check if we have the t1 & t2 in history at the same round
	S Was=0
	I $D(DupIdx("P1",t1)) { ; check if P2 has same hand is same round
		S Rnd="" F  {
			Q:Was
			S Rnd=$O(DupIdx("P1",t1,Rnd)) Q:Rnd=""
			I $D(DupIdx("P2",t2,Rnd)) S Was=1
			}
		}
	I 'Was S DupIdx("P1",t1,Round)="", DupIdx("P2",t2,Round)=""
	;I Was W !,"*** WAS ***" r xxx
	Quit Was
}

ClassMethod CalcTotal(ByRef Deck)
{
	S Total=0 F i=Deck:-1:1 S Total=Total+(Deck(i)*(Deck-i+1))
	Quit Total
}

/// read the file into FoodVec(food,ingredian)=""  
ClassMethod Read(Example = 1, File = "", ByRef P1vec, ByRef P2vec)
{
	S sc=..GetVec($CLASSNAME(), Example, File, .Vec)
	F i=1:1:Vec {
		S rc=Vec(i) 
		I rc["Player" S Player=$P($P(rc," ",2),":",1) Continue
		I '$L(rc) Continue
		I Player=1 S P1vec($I(P1vec))=rc
		I Player=2 S P2vec($I(P2vec))=rc
	}
}

}
