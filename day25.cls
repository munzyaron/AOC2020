Include AOC2020.common

Class AOC2020.day25 Extends (%RegisteredObject, AOC2020.Base)
{

ClassMethod Test1(Example = 0, Debug = 0)
{
	S DoorPublic=335121, CardPublic=363891
	I Example S DoorPublic=17807724, CardPublic=5764801
	$$$sTime S Result = ..Part1(DoorPublic, CardPublic, Example) $$$eTime
	W !,"Encryption = ",Result
	$$$totTime
}

/// run PART I
ClassMethod Part1(DoorPublic, CardPublic, Example = 0)
{
	S Subject=7
	S doorLoop=..LoopSizeCalc(DoorPublic, Subject)   ; calculate the door loop size
	W !,"door Loop = ",doorLoop	
	S cardLoop=..LoopSizeCalc(CardPublic,Subject)    ; calculate the card loop size
	W !,"card Loop = ",cardLoop
	; calculate the encryption key - we use doorLoop + card public key & cardLoop + door public key. They shoudl be IDENTICAL
	S doorEnc=..EncryptionCalc(CardPublic, doorLoop)
	S cardEnc=..EncryptionCalc(DoorPublic, cardLoop)
	I doorEnc=cardEnc { S Result=doorEnc }  ; both encryptions MATCH !!!
	Else { S Result = "" }                  ; encryptions does not match
	Quit Result
}

ClassMethod LoopSizeCalc(PublicKey, Subject)
{
	S Val=1
	F Loop=0:1 {
		Q:Val=PublicKey
		S Val=Val*Subject#20201227
		}
	Quit Loop
}

/// calculate encription based on the loop size & public key
ClassMethod EncryptionCalc(Subject, LoopSize)
{
	W !,"calc: ",Subject," with loop = ",LoopSize
	S Val=1
	F i=1:1:LoopSize {
		S Val=Val*Subject#20201227	
		}
	Quit Val
}

}
