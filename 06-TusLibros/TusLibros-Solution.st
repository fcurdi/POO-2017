!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'cart aCatalog anIsbnNotInCatalog emptyCart priceList isbn1InCatalog isbn2InCatalog isbn3InCatalog aCreditCard aSalesBook anExpiredCreditCard aLongNamedCreditCard currentMonthOfYear previousMonthOfYear aMerchantProcessor today clientId password userPasswords restInterface invalidClientId invalidCartId anOwner aCreditCardNumber cartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/10/2017 23:33:07'!
test01ACartIsEmptyWhenCreated

	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/15/2017 19:28:57'!
test02ACartContainsElementWhenItIsAdded
	
	cart add: isbn1InCatalog . 

	self assert: ((cart quantityFor: isbn1InCatalog ) = 1).	
	self assert: cart size = 1.
! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/15/2017 20:03:53'!
test03WhenAnInvalidQuantityOfBooksAreAddedAnErrorIsRaisedAndTheProductIsNotAdded

	{ -2. 0. 5.6. 4/5. } do: [ :aQuantity |
				self should: [ cart add: isbn1InCatalog withQuantity: aQuantity ] 
				 raise: Error - MessageNotUnderstood  
				 withExceptionDo: [ :anError | 
					self assert: anError messageText = Cart invalidQuantityErrorMessage.
					self assert: cart isEmpty.
				]	
			]! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/15/2017 19:29:14'!
test04CartAddsABookWithMoreThanOneCopyCorreclty

	cart add: isbn1InCatalog  withQuantity: 4.
	
	self assert: (cart quantityFor: isbn1InCatalog ) = 4. 
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

!TusLibrosTest methodsFor: 'cart tests' stamp: 'F C 6/15/2017 19:29:25'!
test06WhenAskedForContentsACartShouldReturnACollectionWithItsContents

	| aCollection |
	
	cart add: isbn1InCatalog  withQuantity: 4.
	aCollection _ cart contents.
	
	self assert: aCollection size = 4.
	self assert: (aCollection select: [ :aBook |  aBook = isbn1InCatalog  ]) size = 4.
	
	
	
		! !


!TusLibrosTest methodsFor: 'setup' stamp: 'E P 6/26/2017 00:23:14'!
setUp

	anIsbnNotInCatalog _ '654321'.
	
	priceList _ Dictionary new.
	isbn1InCatalog _ '123'.
	isbn2InCatalog _ '456'.
	isbn3InCatalog _ '789'.
	priceList at: isbn1InCatalog put: 100.
	priceList at: isbn2InCatalog put: 250.
	priceList at: isbn3InCatalog put: 199.
	
	currentMonthOfYear _ GregorianMonthOfYear current.
	previousMonthOfYear _ GregorianMonthOfYear year: GregorianYear current month: currentMonthOfYear month previous.
	today _ FixedGregorianDate today.
	
	anOwner _ 'pepe'.
	aCreditCardNumber _ '4563728938456372'.
	
	aCreditCard  _ CreditCard withOwner: anOwner number: aCreditCardNumber andExpiration: currentMonthOfYear.
	anExpiredCreditCard _ CreditCard withOwner: 'pepe' number: '4563728938456372' andExpiration: previousMonthOfYear.
	aLongNamedCreditCard _ CreditCard withOwner: 'abcde fghijkl mnopqrstu vwxy z1234.,:+' number: 4213498692346896234 andExpiration: currentMonthOfYear.
	
	aSalesBook _ Set new.
	
	cart _ Cart withCatalog: priceList.
	
	aMerchantProcessor _ MerchantProcessorSimulator withBehaviour: [].
	
	clientId _ 1.
	invalidClientId _ -1.
	password _ '123456'.
	
	
	userPasswords _ Dictionary new.
	userPasswords at: clientId put: password.
	
	restInterface _ TusLibrosInterface withUserPasswords: userPasswords priceList: priceList
		andMerchantProcessor: aMerchantProcessor.
		
	cartId _ restInterface createCartWithClientId: clientId andPassword: password.
	invalidCartId _ cartId - 1.

	! !

!TusLibrosTest methodsFor: 'setup' stamp: 'E P 6/22/2017 21:17:18'!
todo

"
Test07:

	-Falta tambien un assert de  que no se llamo al merchant procesor (esto todavia no vimos como hacerlo) 


Checkout:

		- DUDA: fijarse si es necesario que cada cashier conozca su propio libro de ventas o que haya uno sólo y se le pase como colaborador al crear el cashier.

		-Necesito el carrito, la tarjeta, la fecha de hoy, el libro de ventas:
	
			-opcion1: checkout: aCart payWith: card onDate: aDate -> esto modela el cajero como persona, osea que atiende varias ventas.
				-Puede traer problemas de implementacion (por ejemplo que se acarrean resultados entre una y otra venta)
		
			-opcion2 (conviene): El cashier lo creo con el carrito, fecha, y tarjeta (y el mensaje es solo checkout) -> esto modela que el cashier es para un carrito. Como que tengo uno distinto para cada venta
				-Es mas practico para tener las ventas separadas.
				-Hay que hacer las validaciones en la creacion del cashier (por ejemplo que la tarjeta no puede estar vencida, que el carrito no este vacio, etc) en vez de hacerlas al hacer la operacion checkout.
			
		-Puede devolver por ahora el total y despues vemos si necesita mas info.
		-Para la plata basta con numeros. No hace falta usar Measures

	
Unica clase de test vs clase de test por clase:
		-SI las hacemos separadas el problema es que comparten cosas del setup. 
		Para esto hay que hacer un factory que sirva para proveer los objetos para todas la clases (y no hacer lo mismo en todos los setups).

	
Merchant processor(MP):

		
		-Necesito una interfaz (un traductor) para comunicar al cajero con el MP.
		
		cashier ------------------- | A | B | ------------- MP
								 (interfaz)
		
		
		-La interfaz tiene dos caras (para un lado habla un idioma y para el otro lado el otro idioma). Estas caras (A y B) las podemos pensar como dos objetos.
		La cara interna (A) seria la que habla con el cashier (mundo objetos). La externa (B) es la que habla con el MP (rest, http).

		-Usar el MP para los tests tiene muchos problemas (no solo por el costo). Por ende hay que simularlo (mock)

		-Hay que decidir como simular la cara interna para los tests. No hay que implementar todavia ninguna de las dos caras.
		
		-Para testear el cajero  conviene mockear la cara interna, dado que es lo mas rapido y logico para testear cashier. El test tiene que hacer el steup del simulador (ej: cuando te pidan hacer la operacion con una tarjeta devolve que esta vencida). La respuesta de la cara interna es OK o excepcion. No es el 0|OK, o 1|.... ya que esto lo traduce la cara interna (hacia el mundo de objetos)
		
		-El cajero va a necesitar el MP al crearse		
		
		-Cuando implemente realmente la cara interna, ahi hacemos los tests y simulamos la cara externa.
		
		-Tests. checkout con tarjeta vencida, checkout con tarjeta sin credito, checkout con tarjeta que esta todo bien, 
		
"
	

	
	
	
"

Para el simulador:
	
	Tiene que haber una clase padre que defina como se comportan el merchant procesor de verdad y el simulador.
	Que define que se debe implementar el mensaje     debit: from:
	La excepcion la tiene que levantar el simulador, no el cajero. 
	Se puede setear el comportamiento del simulador con closures que levanten excepciones con diferentes mensajes. (pluggable merchant processor simulator).
		(clase que se crea con un closure que es el comportamiento y que sabe responder debit: from: que lo que hace es llamar al closure).
	Para saber si se llamó o no al MP, se puede usar un contador de transacciones. (se chequea que siga en 0 el contador).
	Los mensajes de error deben estar definidas en la clase abstracta del MP.
	
"


"
Queda hacer la interfaz de entrada. Responde a los request del mundo externo.
El test tiene que hablar con la cara interna de la de la interfaz --> estas hablando el mismo lenguaje. La cara externa tiene otro protocolo.

Nuestra cara intera define mensajes como:
	-createCartFor: anId withPassword: ...
	-addToCart:
	-checkout 
	(todos los mensajes que estan definidos en el protocolo del enunciado y sólo esos, ninguno más). Lo que tenés que testear es la interfaz, no el 'modelo'. Nuestro 'modelo' es la interfaz.
	
	
	test de createCart --> creo un carrito nuevo y hago un /listCart. Assertas que devuelve una coleccion vacia. Ahi chequeas que el carrito no es invalido, porque el listCart no devuelve un error.
	No se puede romper el encapsulamiento de la interfaz.
	
	test01 --> invalid id.
	test02 --> invalid password
	test03 --> isbn externo a la editorial
	test04 --> isbn de la editorial
	test fundamental 05--> carrito no puede ser usado despues de 30 minutos.
	
	Hay que 'engañar' al objeto para hacerle creer que pasaron 30 minutos.
	Tienen que haber minimamente 5 tests.
	
	Pares de id y password se guardan en un diccionario.

"	
	! !


!TusLibrosTest methodsFor: 'cashier tests' stamp: 'E P 6/25/2017 16:05:15'!
test07CannotCreateCashierWithAnEmptyCart


	self should: [ Cashier withCurrentDay: Date today salesBook: aSalesBook cart: cart 
		creditCard: aCreditCard andMerchantProcessor: aMerchantProcessor ]  
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText = Cashier cannotCreateCashierWithAnEmptyCartErrorDescription.	  
		self assert: aSalesBook isEmpty.
		self assert: aMerchantProcessor transactionsCompleted = 0.
	].

! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'E P 6/25/2017 21:37:11'!
test08WhenCheckoutIsMadeTheSaleIsRegisteredInTheSalesBook

	| priceForBook1 priceForBook2 priceForBook3 totalPrice receipt aCashier |
	
	cart add: isbn1InCatalog withQuantity: 1.
	cart add: isbn2InCatalog withQuantity: 2.
	cart add: isbn3InCatalog withQuantity: 3.
	
	priceForBook1 _ priceList at: isbn1InCatalog.
	priceForBook2 _ priceList at: isbn2InCatalog.
	priceForBook3 _ priceList at: isbn3InCatalog.
	
	totalPrice _ priceForBook1 + (2*priceForBook2) + (3*priceForBook3).
	
	aCashier _ Cashier withCurrentDay: FixedGregorianDate today salesBook: aSalesBook cart: cart 
		creditCard: aCreditCard andMerchantProcessor: aMerchantProcessor. 
	receipt _ aCashier checkout.
	
	self assert: (aCashier salesBook includes: receipt).
	self assert: aCashier salesBook size = 1.
	self assert: totalPrice = receipt totalAmount.
	self assert: (receipt quantityForPurchase: isbn1InCatalog) = 1.
	self assert: (receipt quantityForPurchase: isbn2InCatalog) = 2.
	self assert: (receipt quantityForPurchase: isbn3InCatalog) = 3.
	self assert: aMerchantProcessor transactionsCompleted = 1.
	
! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'E P 6/25/2017 16:06:23'!
test09CannotCreateCashierWithAnExpiredCreditCard

	cart add: isbn1InCatalog.
	
	self should: [ Cashier withCurrentDay:  today salesBook: aSalesBook cart: cart 
		creditCard: anExpiredCreditCard  andMerchantProcessor: aMerchantProcessor ]  
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText = Cashier cannotCreateCashierWithAnExpiredCreditCardErrorDescription.	
		self assert: aSalesBook isEmpty.
		self assert: aMerchantProcessor transactionsCompleted = 0.
	].

! !


!TusLibrosTest methodsFor: 'merchant processor tests' stamp: 'E P 6/25/2017 15:09:21'!
test10WhenCheckingOutWithCreditCardThatHasNoFundsAnErrorIsRaised
	
	self assertThatWhenDoingCheckoutMerchantProcessorRaises: MerchantProcessor insufficientFundsErrorDescription.! !

!TusLibrosTest methodsFor: 'merchant processor tests' stamp: 'E P 6/25/2017 15:09:25'!
test11WhenCheckingOutWithCreditCardWasStolenAnErrorIsRaised
	
	self assertThatWhenDoingCheckoutMerchantProcessorRaises: MerchantProcessor stolenCardErrorDescription.! !

!TusLibrosTest methodsFor: 'merchant processor tests' stamp: 'E P 6/25/2017 15:09:29'!
test12WhenCheckingOutWithExpiredCreditCardnAnErrorIsRaised
	
	self assertThatWhenDoingCheckoutMerchantProcessorRaises: MerchantProcessor expiredCreditCardErrorDescription.! !


!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:47:36'!
test14WhenPassedInvalidClientIdOrPasswordCartIsNotCreatedAndErrorIsRaised
	
	self assertThat:  [ restInterface createCartWithClientId: invalidClientId andPassword: password ]
		 raisesErrorMessage: TusLibrosInterface invalidClientIdErrorDescription.
		"	self assert: restInterface carts size = 0."
	
	self assertThat: [ restInterface createCartWithClientId: clientId andPassword: password, 'wrong' ] 
		 raisesErrorMessage: TusLibrosInterface invalidPasswordErrorDescription.
		"	self assert: restInterface carts size = 0."
! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:49:32'!
test15WhenValidUserAndPasswordAreProvidedAnEmptyCartIsCreated
	
	self assert: (restInterface listCartWithId: cartId) isEmpty.! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:49:44'!
test16WhenTryingToListACartWithInvalidCartIdAnErrorIsRaised
	
	self assertThat: [ restInterface listCartWithId: invalidCartId ]
		raisesErrorMessage: TusLibrosInterface invalidCartIdErrorDescription.

! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:40:08'!
test17WhenTryingToAddToInexistentCartAnExceptionIsRaised
	
	self assertThat: [ restInterface addToCart: invalidCartId bookISBN: isbn1InCatalog withQuantity: 1 ]
		raisesErrorMessage: TusLibrosInterface invalidCartIdErrorDescription.
	! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:45:01'!
test18WhenTryingToAddToCartABookNotInCatalogAnExceptionIsRaised
	
	self assertThat: [ restInterface addToCart: cartId bookISBN: anIsbnNotInCatalog withQuantity: 1 ]
		 doesNotAddBookToCartAndRaisesError: Cart isbnNotInCatalogErrorDescription.

! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:44:31'!
test19WhenTryingToAddToCartABookWithInvalidQuantityAnExceptionIsRaised
	
	{0 . 3.5.  1/2. -5} do: [ :aQuantity |
		
		self assertThat: [ restInterface addToCart: cartId bookISBN: isbn1InCatalog withQuantity: aQuantity ]
			 doesNotAddBookToCartAndRaisesError: Cart invalidQuantityErrorMessage.
			
	].


! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:18:54'!
test20ValidProductsAddedPreviouslyAppearWhenCartContentsAreListed
	
	| cartContents |

	restInterface addToCart: cartId  bookISBN: isbn1InCatalog withQuantity: 2.
	restInterface addToCart: cartId  bookISBN: isbn2InCatalog withQuantity: 3.
	restInterface addToCart: cartId  bookISBN: isbn3InCatalog withQuantity: 10.
	
	cartContents _ restInterface listCartWithId: cartId.
	
	self assert: (cartContents occurrencesOf: isbn1InCatalog) = 2.
	self assert: (cartContents occurrencesOf: isbn2InCatalog) = 3.
	self assert: (cartContents occurrencesOf: isbn3InCatalog) = 10.
	self assert: cartContents size = 15.
	
	


! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:49:59'!
test21WhenTryingToCheckoutAnInvalidCartAnErrorIsRaised
	
	self assertThat: [ restInterface checkout: invalidCartId withCreditCardNumber: aCreditCardNumber owner: anOwner andExpirationDate: currentMonthOfYear .]  		doesNotCompletePurchaseAndRaisesError: TusLibrosInterface invalidCartIdErrorDescription.
	
	


! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:50:09'!
test22WhenTryingToCheckoutWithAnEmptyCartAnErrorIsRaised
	
	self assertThat: [ restInterface checkout: cartId withCreditCardNumber: aCreditCardNumber owner: anOwner andExpirationDate: currentMonthOfYear .] 
		doesNotCompletePurchaseAndRaisesError: Cashier cannotCreateCashierWithAnEmptyCartErrorDescription.
	
	


! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:31:23'!
test23WhenTryingToCheckoutWithAnExpiredCreditCardAnErrorIsRaised

	restInterface addToCart: cartId  bookISBN: isbn1InCatalog withQuantity: 1.

	self assertThat: [ restInterface checkout: cartId withCreditCardNumber: aCreditCardNumber owner: anOwner andExpirationDate: previousMonthOfYear .] 		    		doesNotCompletePurchaseAndRaisesError: Cashier cannotCreateCashierWithAnExpiredCreditCardErrorDescription .
	


! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:37:47'!
test24WhenPassedInvalidClientIdOrPasswordWhenListingPurchasesAnErrorIsRaised
	
	self assertThat:  [ restInterface listPurchasesFor: invalidClientId withPassword: password. ] 
		 raisesErrorMessage: TusLibrosInterface invalidClientIdErrorDescription.
	
	self assertThat:  [ restInterface listPurchasesFor: clientId withPassword: password, 'wrong' ]  
		raisesErrorMessage: TusLibrosInterface invalidPasswordErrorDescription.
! !

!TusLibrosTest methodsFor: 'rest Interface tests' stamp: 'E P 6/26/2017 00:35:23'!
test25WhenValidUserAndPasswordAreProvidedPurchasesAreCorrectlyListed
	
	| cartId purchases receipt1 receipt2 |
	
	cartId _ restInterface createCartWithClientId: clientId andPassword: password.
	restInterface addToCart: cartId  bookISBN: isbn1InCatalog withQuantity: 2.
	receipt1 _ restInterface checkout: cartId withCreditCardNumber: aCreditCardNumber  owner: anOwner  andExpirationDate: currentMonthOfYear.
	
	cartId _ restInterface createCartWithClientId: clientId andPassword: password.
	restInterface addToCart: cartId  bookISBN: isbn1InCatalog withQuantity: 3.
	restInterface addToCart: cartId  bookISBN: isbn2InCatalog withQuantity: 10.
	receipt2 _ restInterface checkout: cartId withCreditCardNumber: aCreditCardNumber  owner: anOwner  andExpirationDate: currentMonthOfYear.
	
	purchases _ restInterface listPurchasesFor: clientId withPassword: password.
	
	self assert: purchases size = 2.
	self assert: (purchases includes: receipt1).
	self assert: (purchases includes: receipt2).

	

! !


!TusLibrosTest methodsFor: 'asserts' stamp: 'E P 6/26/2017 00:43:29'!
assertThat: aBlockClosure doesNotAddBookToCartAndRaisesError: anErrorMessage
	
	self assertThat: aBlockClosure raisesErrorMessage: anErrorMessage.
	self assert: (restInterface listCartWithId: cartId) isEmpty.

! !

!TusLibrosTest methodsFor: 'asserts' stamp: 'E P 6/26/2017 00:41:24'!
assertThat: aBlockClosure doesNotCompletePurchaseAndRaisesError: anErrorMessage 
	
	self assertThat: aBlockClosure raisesErrorMessage: anErrorMessage.
	self assert: (restInterface listPurchasesFor: clientId withPassword: password) isEmpty.
	
	


! !

!TusLibrosTest methodsFor: 'asserts' stamp: 'E P 6/26/2017 00:36:56'!
assertThat: aBlockClosure raisesErrorMessage: anErrorMessage
	
	self should: aBlockClosure
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText = anErrorMessage.
	] .
! !

!TusLibrosTest methodsFor: 'asserts' stamp: 'E P 6/25/2017 16:06:42'!
assertThatWhenDoingCheckoutMerchantProcessorRaises: anErrorMessage
	
	| aCashier | 
	
	aMerchantProcessor _ MerchantProcessorSimulator withBehaviour: [ self error: anErrorMessage].
	
	cart add: isbn1InCatalog.
	aCashier _ Cashier withCurrentDay: today salesBook: aSalesBook cart: cart creditCard: aCreditCard  
		andMerchantProcessor: aMerchantProcessor.
	
	self should:[ aCashier checkout ]  
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: anError messageText = anErrorMessage].
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

!Cart methodsFor: 'adding' stamp: 'E P 6/25/2017 19:24:26'!
add: aBook withQuantity: aNumber
	
	((aNumber isKindOf: Integer) and: [aNumber strictlyPositive]) ifFalse: [ self error: self class invalidQuantityErrorMessage ].
	(catalog includesKey: aBook) ifFalse: [ self error: self class isbnNotInCatalogErrorDescription.].
	container add: aBook withOccurrences: aNumber.! !


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

!Cart methodsFor: 'accessing' stamp: 'E P 6/18/2017 19:30:13'!
totalPrice 
	
	| totalPrice |
	
	totalPrice _ 0.
	container do: [ :aProduct | 
		totalPrice _ totalPrice + (catalog at: aProduct).	
	].
	^totalPrice.! !


!Cart methodsFor: 'listing' stamp: 'E P 6/13/2017 21:54:36'!
contents
	
	^container copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: 'container'!

!Cart class methodsFor: 'instance creation' stamp: 'E P 6/25/2017 19:18:06'!
withCatalog: aCatalog

	(aCatalog isKindOf: Dictionary) ifFalse: [self error: Cart invalidCatalogErrorDescription].
	^self new initializeWithCatalog: aCatalog.! !


!Cart class methodsFor: 'error description' stamp: 'E P 6/25/2017 19:18:43'!
invalidCatalogErrorDescription
	
	^'The catalog must be a dictionary'.! !

!Cart class methodsFor: 'error description' stamp: 'E P 6/13/2017 21:43:29'!
invalidQuantityErrorMessage
	
	^'Must specify a valid amount of products to add to the Cart'.! !

!Cart class methodsFor: 'error description' stamp: 'E P 6/25/2017 19:24:54'!
isbnNotInCatalogErrorDescription
	
	^'Cannot add a product that is not part of the catalog'.! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook cart creditCard currentDay merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'checkout' stamp: 'E P 6/25/2017 22:13:52'!
checkout

	| total receipt|
	
	total _ cart totalPrice.
	merchantProcessor debit: total from: creditCard.
	receipt _ Receipt withTotal: total andPurchases: cart contents asOrderedCollection.
	salesBook add: receipt.
	^receipt.
! !


!Cashier methodsFor: 'accessing' stamp: 'E P 6/18/2017 18:54:47'!
salesBook
	
	^salesBook.! !


!Cashier methodsFor: 'initialization' stamp: 'E P 6/25/2017 16:04:30'!
initializeWithCurrentDay: aDay salesBook: aSalesBook cart: aCart creditCard: aCreditCard andMerchantProcessor: aMerchantProcessor

	currentDay _ aDay. 
	salesBook _ aSalesBook.
	cart _ aCart.
	creditCard _ aCreditCard.
	merchantProcessor _ aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'E P 6/25/2017 16:04:06'!
withCurrentDay: aDate salesBook: aSalesBook cart: aCart creditCard: aCreditCard andMerchantProcessor: aMerchantProcessor

	aCart isEmpty ifTrue: [ self error: self cannotCreateCashierWithAnEmptyCartErrorDescription ].
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self cannotCreateCashierWithAnExpiredCreditCardErrorDescription ].
	
	^self new initializeWithCurrentDay: aDate 
								salesBook: aSalesBook 
								cart: aCart 
								creditCard: aCreditCard 
								andMerchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'error descriptions' stamp: 'E P 6/18/2017 19:40:15'!
cannotCreateCashierWithAnEmptyCartErrorDescription

	^'Cannot create cashier with an empty cart.'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'E P 6/18/2017 20:25:46'!
cannotCreateCashierWithAnExpiredCreditCardErrorDescription

	^'Cannot create cashier with an expired credit card.'.! !


!classDefinition: #CreditCard category: #'TusLibros-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number dateOfExpiration monthOfExpiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCard methodsFor: 'accessing' stamp: 'E P 6/24/2017 18:29:13'!
number

	^number.! !

!CreditCard methodsFor: 'accessing' stamp: 'E P 6/23/2017 22:51:22'!
owner

	^owner.! !


!CreditCard methodsFor: 'initialization' stamp: 'E P 6/23/2017 22:14:16'!
initializeWithOwner: anOwner number: aString andExpiration: aGregorianMonthOfYear 

	owner _ anOwner.
	number _ aString.
	monthOfExpiration _ aGregorianMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'E P 6/23/2017 22:56:48'!
isExpiredOn: aGregorianDate

	^monthOfExpiration < (aGregorianDate monthOfYear).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'E P 6/23/2017 22:13:47'!
withOwner: anOwner number: aString andExpiration: aGregorianMonthOfYear

	^self new initializeWithOwner: anOwner number: aString andExpiration: aGregorianMonthOfYear.

	

	! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Solution'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessor methodsFor: 'debit' stamp: 'E P 6/25/2017 15:06:45'!
debit: anAmount from: aCreditCard

	 self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #'TusLibros-Solution'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'E P 6/25/2017 15:07:48'!
expiredCreditCardErrorDescription
	
	^'Credit card is expired'.! !

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'E P 6/25/2017 15:08:02'!
insufficientFundsErrorDescription

	^'Credit card has insufficient funds.'.! !

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'E P 6/25/2017 15:08:26'!
stolenCardErrorDescription
	
	^'Credit card was stolen'.! !


!classDefinition: #MerchantProcessorSimulator category: #'TusLibros-Solution'!
MerchantProcessor subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'transactionsCompleted behaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessorSimulator methodsFor: 'accessing' stamp: 'E P 6/24/2017 19:00:32'!
transactionsCompleted
	
	^transactionsCompleted.
	! !


!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'E P 6/24/2017 19:56:54'!
debit: aNumber from: aCreditCard 
	
	transactionsCompleted _ transactionsCompleted + 1.
	behaviour value.! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'E P 6/24/2017 20:00:32'!
initializeWithBehaviour: aClosure

	transactionsCompleted _ 0.
	behaviour _ aClosure.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #'TusLibros-Solution'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'E P 6/24/2017 19:58:40'!
withBehaviour: aClosure

	^self new initializeWithBehaviour: aClosure.! !


!classDefinition: #Receipt category: #'TusLibros-Solution'!
Object subclass: #Receipt
	instanceVariableNames: 'totalAmount purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Receipt methodsFor: 'initialization' stamp: 'E P 6/25/2017 21:30:49'!
initializeWithTotal: aNumber andPurchases: aCollection

	totalAmount  _ aNumber.
	purchases  _ aCollection.

	! !


!Receipt methodsFor: 'accessing' stamp: 'E P 6/26/2017 00:06:47'!
purchases
	
	^purchases copy.! !

!Receipt methodsFor: 'accessing' stamp: 'E P 6/25/2017 22:17:48'!
quantityForPurchase: aProduct

	^purchases occurrencesOf: aProduct.! !

!Receipt methodsFor: 'accessing' stamp: 'E P 6/25/2017 21:34:47'!
totalAmount
	
	^totalAmount.! !


!Receipt methodsFor: 'comparing' stamp: 'E P 6/25/2017 22:33:44'!
= anObject

	^(anObject isKindOf: Receipt) and: [ totalAmount = anObject totalAmount] and: [purchases = anObject purchases].! !

!Receipt methodsFor: 'comparing' stamp: 'E P 6/25/2017 22:31:57'!
hash

	^totalAmount hash + purchases hash.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Receipt class' category: #'TusLibros-Solution'!
Receipt class
	instanceVariableNames: ''!

!Receipt class methodsFor: 'instance creation' stamp: 'E P 6/25/2017 21:32:16'!
withTotal: aNumber andPurchases: aCollection

	^self new initializeWithTotal: aNumber andPurchases: aCollection.! !


!classDefinition: #TusLibrosInterface category: #'TusLibros-Solution'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'carts userPasswords lastCartId priceList purchases cartOwners merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosInterface methodsFor: 'cart creation' stamp: 'E P 6/26/2017 00:04:25'!
createCartWithClientId: aClientId andPassword: aPassword 
	
	self authenticateWith: aClientId andPassword: aPassword.
	
	lastCartId _ lastCartId + 1.
	carts at: lastCartId put: (Cart withCatalog: priceList).
	cartOwners at: lastCartId put: aClientId.
	
	^lastCartId. 
	
	
	
	! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'E P 6/26/2017 00:02:09'!
initializeWithUserPasswords: aDictionary priceList: aPriceList andMerchantProcessor: aMerchantProcessor

	merchantProcessor _ aMerchantProcessor.
	userPasswords _ aDictionary.
	carts _ Dictionary new.
	cartOwners _ Dictionary new.
	lastCartId _ 0.
	priceList _ aPriceList.
	purchases _ Dictionary new.
	salesBook _ OrderedCollection new.
	
	userPasswords keysDo: [ :aClientId |
		purchases at: aClientId put: OrderedCollection new.			
	]! !


!TusLibrosInterface methodsFor: 'listing cart' stamp: 'E P 6/26/2017 00:07:54'!
listCartWithId: aCartId
	
	^(carts at: aCartId ifAbsent: [ self error: self class invalidCartIdErrorDescription ] ) contents.! !


!TusLibrosInterface methodsFor: 'adding to cart' stamp: 'E P 6/26/2017 00:03:04'!
addToCart: aCartId bookISBN: anIsbn withQuantity: anInteger

	| cart |
	
	cart _ carts at: aCartId ifAbsent: [self error: TusLibrosInterface invalidCartIdErrorDescription.].
	cart add: anIsbn withQuantity: anInteger. 
	
	! !


!TusLibrosInterface methodsFor: 'checkout' stamp: 'E P 6/26/2017 00:07:21'!
checkout: aCartId withCreditCardNumber: aCreditCardNumber owner: anOwner andExpirationDate: anExpirationDate 
	
	| cart creditCard cashier receipt clientId |
	
	cart _ carts at: aCartId ifAbsent: [self error: self class invalidCartIdErrorDescription.].
	clientId _ cartOwners at: aCartId.
	creditCard _ CreditCard withOwner: anOwner number: aCreditCardNumber andExpiration: anExpirationDate.
	
	cashier _ Cashier withCurrentDay:  FixedGregorianDate today
					salesBook:  salesBook
					cart: cart 
					creditCard: creditCard 
					andMerchantProcessor: merchantProcessor.
					
	receipt _ cashier checkout.
	(purchases at: clientId) add: receipt.
	carts removeKey: aCartId.
	^receipt.! !


!TusLibrosInterface methodsFor: 'listing purchases' stamp: 'E P 6/26/2017 00:05:47'!
listPurchasesFor: aClientId withPassword: aPassword 
	
	self authenticateWith: aClientId andPassword: aPassword. 
	^(purchases at: aClientId) veryDeepCopy.! !


!TusLibrosInterface methodsFor: 'authentication - private' stamp: 'E P 6/26/2017 00:05:14'!
authenticateWith: aClientId andPassword: aPassword	
	
	| savedPassword |
	
	savedPassword _ userPasswords at: aClientId ifAbsent: [ self error: self class invalidClientIdErrorDescription . ].
	savedPassword = aPassword ifFalse: [ self error: self class invalidPasswordErrorDescription. ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #'TusLibros-Solution'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'E P 6/25/2017 23:57:10'!
withUserPasswords: aDictionary priceList: aPriceList andMerchantProcessor: aMerchantProcessor

	^self new initializeWithUserPasswords: aDictionary priceList: aPriceList andMerchantProcessor: aMerchantProcessor.! !


!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'E P 6/25/2017 19:11:36'!
addingBookNotInCatalogErrorDescription
	
	^'Trying to add book that not present in the catalog.'.! !

!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'E P 6/25/2017 19:44:56'!
invalidCartIdErrorDescription

	^'Invalid cart id.'.! !

!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'E P 6/25/2017 20:23:35'!
invalidClientIdErrorDescription

	^'Invalid clientId'.! !

!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'E P 6/25/2017 20:30:03'!
invalidPasswordErrorDescription

	^'Invalid password'.! !
