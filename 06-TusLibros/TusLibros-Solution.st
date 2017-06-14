!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'cart aCatalog anIsbnInCatalog anIsbnNotInCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/10/2017 23:33:07'!
test01ACartIsEmptyWhenCreated

	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/13/2017 21:36:03'!
test02ACartContainsElementWhenItIsAdded
	
	cart add: anIsbnInCatalog. 

	self assert: ((cart quantityFor: anIsbnInCatalog) = 1).	
	self assert: cart size = 1.
! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/13/2017 21:40:16'!
test03WhenANegativeQuantityOfBooksAreAddedAnErrorIsRaisedAndTheProductIsNotAdded

	{ -2. 0. 5.6. 4/5. } do: [ :aQuantity |
				self should: [ cart add: anIsbnInCatalog withQuantity: aQuantity ] 
				 raise: Error - MessageNotUnderstood  
				 withExceptionDo: [ :anError | 
					self assert: anError messageText = Cart invalidQuantityErrorMessage.
					self assert: cart isEmpty.
				]	
			]! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/13/2017 21:36:56'!
test04CartAddsABookWithMoreThanOneCopyCorreclty

	cart add: anIsbnInCatalog withQuantity: 4.
	
	self assert: (cart quantityFor: anIsbnInCatalog) = 4. 
		! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/13/2017 21:37:17'!
test05AddingBookThatsNotOnTheCatalogueRaisesError
	
	self should: [ cart add: anIsbnNotInCatalog. ]
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [ :anError | 
			self assert: anError messageText = 'Cannot add a product that is not part of the catalog'. 
			self assert: cart isEmpty.
		].
		! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'E P 6/13/2017 21:52:59'!
test06WhenAskedForContentsACartShouldReturnACollectionWithItsContents

	| aCollection |
	
	cart add: anIsbnInCatalog withQuantity: 4.
	aCollection _ cart contents.
	
	self assert: aCollection size = 4.
	self assert: (aCollection select: [ :aBook |  aBook = anIsbnInCatalog ]) size = 4.
	
	
	
		! !


!TusLibrosTest methodsFor: 'setup' stamp: 'E P 6/13/2017 21:34:50'!
setUp

	anIsbnInCatalog _ '123456'.
	anIsbnNotInCatalog _ '654321'.
	
	aCatalog _ {anIsbnInCatalog} asSet. 
	cart _ Cart withCatalog: aCatalog.
	! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'container catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'testing' stamp: 'E P 6/9/2017 19:23:27'!
isEmpty

	^container isEmpty.! !


!Cart methodsFor: 'adding' stamp: 'F C 6/10/2017 23:24:35'!
add: aBook 
	
	self add: aBook withQuantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'E P 6/13/2017 21:45:50'!
add: aBook withQuantity: aNumber
	
	((aNumber isKindOf: Integer) and: [aNumber strictlyPositive]) ifFalse: [ self error: self class invalidQuantityErrorMessage ].
	(catalog includes: aBook) ifFalse: [ self error: 'Cannot add a product that is not part of the catalog'. ].
	container add: aBook withOccurrences: aNumber.
	
	
	! !


!Cart methodsFor: 'initialization' stamp: 'E P 6/13/2017 21:32:47'!
initializeWithCatalog: aCatalog.

	container _ Bag new.
	catalog _ aCatalog.! !


!Cart methodsFor: 'accessing' stamp: 'F C 6/10/2017 23:26:38'!
quantityFor: aBook 
	
	^container occurrencesOf: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'E P 6/13/2017 19:43:17'!
size

	^container size.! !


!Cart methodsFor: 'listing' stamp: 'E P 6/13/2017 21:54:36'!
contents
	
	^container copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: 'container'!

!Cart class methodsFor: 'instance creation' stamp: 'E P 6/13/2017 21:32:09'!
withCatalog: aCatalog

	^self new initializeWithCatalog: aCatalog.! !


!Cart class methodsFor: 'error description' stamp: 'E P 6/13/2017 21:43:29'!
invalidQuantityErrorMessage
	
	^'Must specify a valid amount of products to add to the Cart'.! !


!classDefinition: #TusLibros category: #'TusLibros-Solution'!
Object subclass: #TusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!
