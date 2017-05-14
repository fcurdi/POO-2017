!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:44:19'!
assert: aCell isAliveAfterOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withSize: aSize
	
	| aGameOfLife |
	
	aGameOfLife  _ self simulateOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withSize: aSize.
	self assert: (aGameOfLife isAliveAt: aCell ).! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:44:24'!
assert: aCell isDeadAfterOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withSize: aSize

	| aGameOfLife |
	
	aGameOfLife  _ self simulateOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withSize: aSize.
	self assert: (aGameOfLife isDeadAt: aCell ).
	! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:44:28'!
simulateOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withSize: aSize

	| aGameOfLife |
	
	aGameOfLife _ GameOfLife withLiveCells: aCollectionOfLiveCells withSize: aSize.
	aGameOfLife nextGeneration.
	^aGameOfLife.
	! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:28:07'!
test01AliveCellWithLessThanTwoAliveNeighboursDies

"
	| gameOfLife |
	
	gameOfLife _ GameOfLife withLiveCells: { 1@1 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1).
"	
	self assert: 1@1 isDeadAfterOneGenerationOfAGameOfLifeWithLiveCells: {1@1}  withSize: 3@3.! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:28:52'!
test02AliveCellWithTwoAliveNeighboursStaysAlive
"
	| gameOfLife |
	
	gameOfLife _ GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isAliveAt: 1@1).
"

	self assert: 1@1 isAliveAfterOneGenerationOfAGameOfLifeWithLiveCells: { 1@1. 2@0. 1@0. } withSize: 3@3.! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:30:14'!
test03AliveCellWithThreeAliveNeighboursStaysAlive
"
	| gameOfLife |
	
	gameOfLife _ GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isAliveAt: 1@1).
"

	self assert: 1@1 isAliveAfterOneGenerationOfAGameOfLifeWithLiveCells: { 1@1. 2@0. 1@0. 1@2. } withSize: 3@3.! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:30:09'!
test04AliveCellWithMoreThanThreeAliveNeighboursDies
"
	| gameOfLife |
	
	gameOfLife _ GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) 
"
	self assert: 1@1 isDeadAfterOneGenerationOfAGameOfLifeWithLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:31:05'!
test05DeadCellWithThreeAliveNeighboursResurects
"
	| gameOfLife |
	
	gameOfLife _ GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isAliveAt: 1@1).
"
	self assert: 1@1 isAliveAfterOneGenerationOfAGameOfLifeWithLiveCells: { 2@0. 1@0. 0@0 }  withSize: 3@3.! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 18:57:55'!
test06CreateAGameOfLifeWithACellOutsideBounds

	self should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withSize: 3@3 ]
   		  raise: Error - MessageNotUnderstood 
		  withExceptionDo: [ :anError | self assert: anError messageText equals: GameOfLife cellOutsideBoundsErrorDescription ].! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:48:28'!
deadCells
	
	| deadCells aCell |
	
	"se puede hacer mejor"
	
	deadCells _ OrderedCollection new.
	0 to: size x do: [ :x |
		0 to: size y do: [ :y |
			aCell _ x@y.				
			(self isDeadAt: aCell) ifTrue: [ 
				deadCells add: aCell.
				]
			]
		].
	^deadCells.! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 18:45:51'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3.! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 18:22:41'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours |
	
	numberOfAliveNeighbours _ self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3].! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 19:48:43'!
nextGeneration
	
	"se puede hacer mejor"
	
	aliveCells _ (aliveCells select: [ :aCell | self hasToSurvive: aCell ]) union: (self deadCells select: [ :aDeadCell | self hasToResurrect: aDeadCell ]).! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'F C 5/14/2017 18:58:39'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size.! !


!GameOfLife methodsFor: 'initialization' stamp: 'F C 5/14/2017 19:39:15'!
initializeWith: aCollectionOfLiveCells withSize: aSize

	size := aSize.
	aliveCells := aCollectionOfLiveCells.! !


!GameOfLife methodsFor: 'testing' stamp: 'F C 5/14/2017 19:01:57'!
isAliveAt: aCell

	^aliveCells includes: aCell.! !

!GameOfLife methodsFor: 'testing' stamp: 'F C 5/14/2017 19:02:22'!
isDeadAt: aCell

	^(self isAliveAt: aCell) not.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'instance creation' stamp: 'F C 5/14/2017 19:38:58'!
withLiveCells: aCollectionOfLiveCells withSize: aPoint 
	
	
	(aCollectionOfLiveCells allSatisfy: [ :aCell | aCell between: 0@0 and: aPoint ] ) ifFalse: [ self error: self cellOutsideBoundsErrorDescription].
	
	^self new initializeWith: aCollectionOfLiveCells withSize: aPoint.! !


!GameOfLife class methodsFor: 'error descriptions' stamp: 'F C 5/14/2017 18:58:22'!
cellOutsideBoundsErrorDescription

	^'Celda fuera de rango'.! !
