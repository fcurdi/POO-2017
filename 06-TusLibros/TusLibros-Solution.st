!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/9/2017 21:09:46'!
test01ACartIsEmptyWhenCreated

	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/9/2017 21:09:39'!
test02ACartContainsElementWhenItIsAdded

	| isbn |
	
	isbn _ '1234567890'.
	cart add: isbn. 
	
	self deny: cart isEmpty.! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/9/2017 21:06:46'!
test03WhenANegativeAmountOfBooksAreAddedAnErrorIsRaisedAndTheProductIsNotAdded

	| isbn |
	
	isbn _ '1234567890'.
	
	self should: [ cart add: isbn withAmount: -2. ] 
		 raise: Error - MessageNotUnderstood  
		 withExceptionDo: [ :anError | 
			self assert: anError messageText = 'Must add one or more products to the cart.'.
			self assert: (cart amountFor: isbn) = 0.
		]
	
	! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/10/2017 19:20:41'!
test04WhenAskedForAmountOfBookACartReturnsTheAmountAddedPreviously

	| isbn |
	
	isbn _ '1234567890'.
	cart add: isbn withAmount: 4.
	
	self assert: (cart amountFor: isbn) = 4. 
		! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/10/2017 22:02:22'!
test05AddingBookThatsNotOnTheCatalogueRaisesError

		! !


!TusLibrosTest methodsFor: 'setup' stamp: 'E P 6/9/2017 19:33:55'!
setUp

	cart _ Cart new.! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'testing' stamp: 'E P 6/9/2017 19:23:27'!
isEmpty

	^container isEmpty.! !


!Cart methodsFor: 'adding' stamp: 'E P 6/9/2017 20:13:08'!
add: aBook 
	
	self add: aBook withAmount: 1.! !

!Cart methodsFor: 'adding' stamp: 'E P 6/9/2017 20:13:13'!
add: aBook withAmount: anInteger
	
	anInteger strictlyPositive not ifTrue: [ self error: 'Must add one or more products to the cart.' ].
	container add: aBook withOccurrences: anInteger.
	
	
	! !


!Cart methodsFor: 'initialization' stamp: 'E P 6/9/2017 19:48:45'!
initialize

	container _ Bag new.! !


!Cart methodsFor: 'accessing' stamp: 'E P 6/9/2017 19:49:29'!
amountFor: aProduct 
	
	^container occurrencesOf: aProduct.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: 'container'!
