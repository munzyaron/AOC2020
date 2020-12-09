#define sTime		S sTime=$now()
#define eTime		S eTime=$now() 
#define totTime		W !,"total time: ",$P(eTime,",",2)-$P(sTime,",",2)
