!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'cart aCatalog anIsbnInCatalog anIsbnNotInCatalog aCashier emptyCart priceList'
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


!TusLibrosTest methodsFor: 'setup' stamp: 'F C 6/14/2017 23:27:37'!
setUp

	anIsbnInCatalog _ '123456'.
	anIsbnNotInCatalog _ '654321'.
	
	aCatalog _ {anIsbnInCatalog} asSet. 
	cart _ Cart withCatalog: aCatalog.
	emptyCart _ Cart withCatalog: Bag new.
	
	aCashier _ Cashier new.
	! !

!TusLibrosTest methodsFor: 'setup' stamp: 'F C 6/15/2017 00:13:04'!
todo

"
Cashier conoce una lista de precios (dicc(prod -> precio)).
La lista de precios podría ser el catalogo (te evita el problema de sincronizar el catalogo con la lista)	
Tenés que poder hacer aCashier checkout: aCart payWith: aCreditCard

El test no debería chequear si se debito plata de la tarjeta porque la tarjeta es solo un id que representa una cuenta.
Chequear que no se pueda hacer un checkout con tarjeta vencida. Tiene que poder correr en cualquier fecha. (sin importar que día es hoy.)
No se va a implementar la parte de comunicacion con el merchant processor. Cashier sabe responder debit: anAmount from: aCreditCard y este mensaje que no haga nada.

Testear lo de credit cart.
"! !


!TusLibrosTest methodsFor: 'cashier tests' stamp: 'F C 6/14/2017 23:29:27'!
test07CannotCheckoutAnEmptyCart


	self should: [ aCashier checkout: emptyCart ]  
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | self assert: anError messageText = 'Cannot checkout an empty cart.'].
! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'F C 6/15/2017 00:12:16'!
test08CashierCalculatesTotalPriceOfCartCorrectly

	| book1 book2 book3 priceForBook1 priceForBook2 priceForBook3 totalPrice |
	priceList _ Dictionary new.
	book1 _ '1'.
	book2 _ '2'.
	book3 _ '3'.
	priceForBook1 _ 2.
	priceForBook2 _ 5.8.
	priceForBook3 _ 3/8.
	priceList at: book1 put: priceForBook1.
	priceList at: book2 put: priceForBook2.
	priceList at: book3 put: priceForBook3.
	cart _ Cart withCatalog: priceList keys asSet.
	cart add: book1 withQuantity: 1.
	cart add: book2 withQuantity: 2.
	cart add: book3 withQuantity: 3.
	
	totalPrice _ priceForBook1 + (2*priceForBook2) + (3*priceForBook3).
	
	self assert: (aCashier totalPriceOf: cart) = totalPrice.! !


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


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'checkout' stamp: 'F C 6/14/2017 23:29:23'!
checkout: aCart 


	aCart isEmpty ifTrue: [ self error: 'Cannot checkout an empty cart.' ].! !


!Cashier methodsFor: 'macpal' stamp: 'F C 6/15/2017 00:09:24'!
initialize

	priceList _ Dictionary new.
	priceList at: '1' put: 2.
	priceList at: '2' put: 5.8.
	priceList at: '3' put: 3/8.! !

!Cashier methodsFor: 'macpal' stamp: 'F C 6/15/2017 00:10:42'!
totalPriceOf: aCart 

	| totalPrice |
	totalPrice _ 0.
	aCart contents do: [ :aProduct | 
		totalPrice _ totalPrice + (priceList at: aProduct).	
	].
	^totalPrice.! !
