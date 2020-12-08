Class AOC2020.Base Extends %RegisteredObject
{

Parameter Folder = "D:\aoc2020\";

/// if not passing File will get it as standard format: dayX.txt or dayX-example.txt
ClassMethod GetVec(ClassName, Example, File = "", ByRef Vec)
{
	I '$L(File) S File=..GetFileName(ClassName, Example)
	S Stream=..GetInput(File)
	W !,"Reading file: ",File
	I $IsObject(Stream)&&Stream.Size {
		K Vec While 'Stream.AtEnd { S line=Stream.ReadLine(), Vec($I(Vec))=line }
		S Result=1
		}
	Else { S Result=0 }
	Quit Result
}

/// read a file output as stream
ClassMethod GetInput(File) As %Stream
{
    S fn=..#Folder_File, stream = ##class(%Stream.FileCharacter).%New()
    S sc=stream.LinkToFile(fn)
    return stream
}

/// get file based on classname, example
ClassMethod GetFileName(ClassName, Example = 0)
{
	S File=$P(ClassName,".",*)_$S(Example:"-example",1:"")_".txt"
	Quit File
}

/// check if we are at last line of Vec
ClassMethod LastLn(ByRef Vec, CurrentLine) [ CodeMode = expression ]
{
'$D(Vec(CurrentLine+1))
}

/// convert a vec(ln) to grip(x,y)
/// pos 1,1 = 1st line, left pos
ClassMethod VecToGrid(ByRef Vec, ByRef Grid)
{
	F Line=1:1:Vec {
		S rc=Vec(Line) F Row=1:1:$L(rc) S t=$E(rc,Row), Grid(Line,Row)=t
		}
}

}
