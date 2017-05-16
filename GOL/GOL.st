!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 22:55:38'!
assert: aCell isAliveAfterOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withCorner: aPoint
	
	| aGameOfLife |
	
	aGameOfLife  _ self simulateOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withCorner: aPoint.
	self assert: (aGameOfLife isAliveAt: aCell ).! !

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 22:55:20'!
assert: aCell isDeadAfterOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withCorner: aPoint

	| aGameOfLife |
	
	aGameOfLife  _ self simulateOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withCorner: aPoint.
	self assert: (aGameOfLife isDeadAt: aCell ).
	! !

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 22:54:57'!
simulateOneGenerationOfAGameOfLifeWithLiveCells: aCollectionOfLiveCells withCorner: aPoint

	| aGameOfLife |
	
	aGameOfLife _ GameOfLife withLiveCells: aCollectionOfLiveCells withCorner: aPoint.
	aGameOfLife nextGeneration.
	^aGameOfLife.
	! !

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 22:54:04'!
test01AliveCellWithLessThanTwoAliveNeighboursDies
	
	self assert: 1@1 isDeadAfterOneGenerationOfAGameOfLifeWithLiveCells: {1@1}  withCorner: 3@3.! !

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 22:53:59'!
test02AliveCellWithTwoAliveNeighboursStaysAlive

	self assert: 1@1 isAliveAfterOneGenerationOfAGameOfLifeWithLiveCells: { 1@1. 2@0. 1@0. } withCorner: 3@3.! !

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 22:53:51'!
test03AliveCellWithThreeAliveNeighboursStaysAlive

	self assert: 1@1 isAliveAfterOneGenerationOfAGameOfLifeWithLiveCells: { 1@1. 2@0. 1@0. 1@2. } withCorner: 3@3.! !

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 22:53:42'!
test04AliveCellWithMoreThanThreeAliveNeighboursDies

	self assert: 1@1 isDeadAfterOneGenerationOfAGameOfLifeWithLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withCorner: 3@3.! !

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 22:53:31'!
test05DeadCellWithThreeAliveNeighboursResurects

	self assert: 1@1 isAliveAfterOneGenerationOfAGameOfLifeWithLiveCells: { 2@0. 1@0. 0@0 }  withCorner: 3@3.! !

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 22:51:35'!
test06CannotCreateAGameOfLifeWithACellOutsideBounds

	self should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withCorner: 3@3 ]
   		  raise: Error - MessageNotUnderstood 
		  withExceptionDo: [ :anError | self assert: anError messageText equals: GameOfLife cellOutsideBoundsErrorDescription ].! !

!GOLTest methodsFor: 'Testing' stamp: 'E P 5/15/2017 20:55:46'!
test07CannotCreateAGameOfLifeWithCornerSmallerOrEqualThanZero

	self should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withCorner: -1@4 ]
   		  raise: Error - MessageNotUnderstood 
		  withExceptionDo: [ :anError | self assert: anError messageText equals: GameOfLife negativeOrZeroCornerErrorDescription ].
		
! !

!GOLTest methodsFor: 'Testing' stamp: 'F C 5/15/2017 23:09:50'!
test08CellWithThreeNeighboursButOutsideBoundsIsNotAliveAfterNextGeneration

	self assert: -1@1 isDeadAfterOneGenerationOfAGameOfLifeWithLiveCells: { 0@0. 0@1. 0@2 }  withCorner: 3@3.! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'E P 5/15/2017 23:47:15'!
nextGeneration
	
	| nextGenerationAliveCells aCell |
	
	nextGenerationAliveCells _ OrderedCollection new.
	0 to: board corner x do: [ :x |
		0 to: board corner y do: [ :y |
			aCell _ x@y.				
			((self hasToSurvive: aCell) or: [self hasToResurrect: aCell]) ifTrue: [ nextGenerationAliveCells add: aCell.]]
	].
	
	aliveCells _ nextGenerationAliveCells.
	
	"
	aliveCells := board allIntegerPoints select: [((self hasToSurvive: aCell) or: [self hasToResurrect: aCell])]"! !


!GameOfLife methodsFor: 'initialization' stamp: 'E P 5/15/2017 19:53:43'!
initializeWithLiveCells: aCollectionOfLiveCells andBoard: aBoard

	board _ aBoard.
	aliveCells _ aCollectionOfLiveCells.! !


!GameOfLife methodsFor: 'testing' stamp: 'F C 5/14/2017 18:45:51'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3.! !

!GameOfLife methodsFor: 'testing' stamp: 'F C 5/15/2017 22:43:29'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours |
	
	numberOfAliveNeighbours _ self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]. ! !

!GameOfLife methodsFor: 'testing' stamp: 'F C 5/14/2017 19:01:57'!
isAliveAt: aCell

	^aliveCells includes: aCell.! !

!GameOfLife methodsFor: 'testing' stamp: 'F C 5/14/2017 19:02:22'!
isDeadAt: aCell

	^(self isAliveAt: aCell) not.! !


!GameOfLife methodsFor: 'accessing --private' stamp: 'E P 5/15/2017 21:11:50'!
neighbours: aCell

	^aCell eightNeighbors select: [ :aNeighbour | board containsPoint: aNeighbour ].! !

!GameOfLife methodsFor: 'accessing --private' stamp: 'E P 5/15/2017 21:18:07'!
numberOfAliveNeighboursOf: aCell

	^((self neighbours: aCell) intersection: aliveCells) size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'instance creation' stamp: 'E P 5/15/2017 20:54:26'!
withLiveCells: aCollectionOfLiveCells withCorner: aPoint
	
	| board |
	
	board _ Rectangle origin: 0@0 corner: aPoint.
	
	((aPoint x > 0) and: [aPoint y > 0]) ifFalse: [ self error: self negativeOrZeroCornerErrorDescription].
	(aCollectionOfLiveCells allSatisfy: [ :aCell | board containsPoint: aCell ] ) ifFalse: [ self error: self cellOutsideBoundsErrorDescription].
	
	^self new initializeWithLiveCells: aCollectionOfLiveCells andBoard: board.! !


!GameOfLife class methodsFor: 'error descriptions' stamp: 'E P 5/15/2017 20:05:16'!
cellOutsideBoundsErrorDescription

	^'Cannot create gameOfLife instance with out of bound cells.'.! !

!GameOfLife class methodsFor: 'error descriptions' stamp: 'E P 5/15/2017 20:54:23'!
negativeOrZeroCornerErrorDescription

	^'Cannot create gameOfLife board with corner that has negative or zero coordinates.'.! !
