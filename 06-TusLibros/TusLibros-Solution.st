!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/10/2017 23:33:07'!
test01ACartIsEmptyWhenCreated

	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/10/2017 23:41:05'!
test02ACartContainsElementWhenItIsAdded

	| isbn |
	
	isbn _ '1234567890'.
	cart add: isbn. 

	self assert: ((cart quantityFor: isbn) = 1).	
	self assert: cart numberOfBooks = 1.
! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/10/2017 23:59:03'!
test03WhenANegativeQuantityOfBooksAreAddedAnErrorIsRaisedAndTheProductIsNotAdded

	| isbn |
	
	isbn _ '1234567890'.

	{-2. 0 } do: [ :aQuantity |
				self should: [ cart add: isbn withQuantity: aQuantity ] 
				 raise: Error - MessageNotUnderstood  
				 withExceptionDo: [ :anError | 
					self assert: anError messageText = Cart negativeQuantityOfBooksErrorDescription.
					self assert: (cart quantityFor: isbn) = 0.
				]	
			]
	

	! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/10/2017 23:55:49'!
test04CartAddsABookWithMoreThanOneCopyCorreclty

	| isbn |
	
	isbn _ '1234567890'.
	cart add: isbn withQuantity: 4.
	
	self assert: (cart quantityFor: isbn) = 4. 
		! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/11/2017 00:03:01'!
test05AddingBookThatsNotOnTheCatalogueRaisesError

	"hay que pensar si es parte del cart o parte de la interfaz esto"! !


!TusLibrosTest methodsFor: 'setup' stamp: 'F C 6/10/2017 23:33:02'!
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

!Cart methodsFor: 'testing' stamp: 'F C 6/10/2017 23:39:03'!
numberOfBooks

	^container size.! !


!Cart methodsFor: 'adding' stamp: 'F C 6/10/2017 23:24:35'!
add: aBook 
	
	self add: aBook withQuantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'F C 6/11/2017 00:03:39'!
add: aBook withQuantity: anInteger
	
	anInteger strictlyPositive ifFalse: [ self error: self class negativeQuantityOfBooksErrorDescription ].
	container add: aBook withOccurrences: anInteger.
	
	
	! !


!Cart methodsFor: 'initialization' stamp: 'E P 6/9/2017 19:48:45'!
initialize

	container _ Bag new.! !


!Cart methodsFor: 'accessing' stamp: 'F C 6/10/2017 23:26:38'!
quantityFor: aBook 
	
	^container occurrencesOf: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: 'container'!

!Cart class methodsFor: 'error description' stamp: 'F C 6/10/2017 23:47:32'!
negativeQuantityOfBooksErrorDescription
	
	^'Must add one or more books to the cart.'! !
