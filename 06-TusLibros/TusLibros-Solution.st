!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'cart aCatalog anIsbnNotInCatalog aCashier emptyCart priceList isbn1InCatalog isbn2InCatalog isbn3InCatalog aCreditCard aSalesBook anExpiredCreditCard'
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


!TusLibrosTest methodsFor: 'setup' stamp: 'E P 6/18/2017 18:35:55'!
done

"
Lista de precios (no va la que hicimos nosotros):

		-Opcion1: el carrito tiene un catalogo que en realidad es la lista de precios y  tanto el cashier como el carrito conocen la lista de precios.
		.Opcion2: el carrito solo conoce el catalogo/lista de precios y el cashier le pide al carrito que calcule su precio.
		
		
		
		
		
		
		
		
		
		
		
		
		
"! !

!TusLibrosTest methodsFor: 'setup' stamp: 'E P 6/18/2017 20:45:14'!
setUp

	anIsbnNotInCatalog _ '654321'.
	
	priceList _ Dictionary new.
	isbn1InCatalog _ '123'.
	isbn2InCatalog _ '456'.
	isbn3InCatalog _ '789'.
	priceList at: isbn1InCatalog put: 100.
	priceList at: isbn2InCatalog put: 250.
	priceList at: isbn3InCatalog put: 199.
	
	"cambiar por mes de año, hay que crear la clase"
	aCreditCard  _ CreditCard withOwner: 'pepe' number: '4563728938456372' andExpiration: (Date tomorrow).
	anExpiredCreditCard _ CreditCard withOwner: 'pepe' number: '4563728938456372' andExpiration: (Date year: 2016 month: 12  day: 1).
	
	aSalesBook _ Set new.
	
	cart _ Cart withCatalog: priceList.
	! !

!TusLibrosTest methodsFor: 'setup' stamp: 'E P 6/18/2017 21:17:18'!
todo

"



No se va a implementar la parte de comunicacion con el merchant processor. Cashier sabe responder debit: anAmount from: aCreditCard y este mensaje que no haga nada.

Test07:


	-Falta tambien un assert de  que no se llamo al merchant procesor (esto todavia no vimos como hacerlo) 

		
Tarjeta:
		
		-La tarjeta conoce owner, numero y fecha de expiracion (que no es un date sino un mes de año).
		
		-Testear que no se puede hacer checkout con tarjeta vencida (tiene que correr en cualquier fecha):
			-Para saber si la tarjeta esta vencida:
				-opcion1: el cashier le pide la fecha de expiracion a la tarjeta y lo verifica comparandola con today. Esto no esta bueno (el cashier se acopla con Date today)
				-opcion2: La tarjeta responde el mensaje  isExpiredOn: aDate. (asi no acoplo la tarjeta con Date today).
			Hernan dijo que conviene  crear el cashier con una fecha (diciendole que dia es)  De esta forma no acoplo con Date today para nada. Y en el test entonces controlo la fecha del cashier.

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
	! !


!TusLibrosTest methodsFor: 'cashier tests' stamp: 'E P 6/18/2017 20:09:00'!
test07CannotCreateCashierWithAnEmptyCart


	self should: [ Cashier withSalesBook: aSalesBook Cart: cart creditCard: aCreditCard  andPriceList: priceList ]  
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText = Cashier cannotCreateCashierWithAnEmptyCartErrorDescription.	  
		self assert: aSalesBook isEmpty.
	].

! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'E P 6/18/2017 20:01:31'!
test08WhenCheckoutIsMadeTheSaleIsRegisteredInTheSalesBook

	| priceForBook1 priceForBook2 priceForBook3 totalPrice checkoutResult |
	
	cart add: isbn1InCatalog withQuantity: 1.
	cart add: isbn2InCatalog withQuantity: 2.
	cart add: isbn3InCatalog withQuantity: 3.
	
	priceForBook1 _ priceList at: isbn1InCatalog.
	priceForBook2 _ priceList at: isbn2InCatalog.
	priceForBook3 _ priceList at: isbn3InCatalog.
	
	totalPrice _ priceForBook1 + (2*priceForBook2) + (3*priceForBook3).
	
	aCashier _ Cashier withSalesBook: aSalesBook Cart: cart creditCard: aCreditCard andPriceList: priceList. 
	checkoutResult _ aCashier checkout.
	
	self assert: (aCashier salesBook includes: totalPrice).
	self assert: aCashier salesBook size = 1.
	self assert: totalPrice = checkoutResult.
	
! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'E P 6/18/2017 20:47:34'!
test09CannotCreateCashierWithAnExpiredCreditCard

	cart add: isbn1InCatalog.
	self should: [ Cashier withSalesBook: aSalesBook Cart: cart creditCard: anExpiredCreditCard  andPriceList: priceList ]  
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText = Cashier cannotCreateCashierWithAnExpiredCreditCardErrorDescription.	  
		self assert: aSalesBook isEmpty.
	].

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

!Cart methodsFor: 'adding' stamp: 'E P 6/18/2017 18:34:09'!
add: aBook withQuantity: aNumber
	
	((aNumber isKindOf: Integer) and: [aNumber strictlyPositive]) ifFalse: [ self error: self class invalidQuantityErrorMessage ].
	(catalog includesKey: aBook) ifFalse: [ self error: 'Cannot add a product that is not part of the catalog'. ].
	container add: aBook withOccurrences: aNumber.

Dictionary! !


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

!Cart class methodsFor: 'instance creation' stamp: 'E P 6/13/2017 21:32:09'!
withCatalog: aCatalog

	^self new initializeWithCatalog: aCatalog.! !


!Cart class methodsFor: 'error description' stamp: 'E P 6/13/2017 21:43:29'!
invalidQuantityErrorMessage
	
	^'Must specify a valid amount of products to add to the Cart'.! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList salesBook cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'checkout' stamp: 'E P 6/18/2017 21:23:19'!
checkout

	| total |
	
	total _ cart totalPrice.
	self debit: total from: creditCard.
	salesBook add: total.
	^total.! !


!Cashier methodsFor: 'accessing' stamp: 'E P 6/18/2017 18:54:47'!
salesBook
	
	^salesBook.! !


!Cashier methodsFor: 'initialization' stamp: 'E P 6/18/2017 20:01:06'!
initializeWithSalesBook: aSalesBook Cart: aCart creditCart: aCreditCard andPriceList: aPriceList 

	salesBook _ aSalesBook.
	cart _ aCart.
	creditCard _ aCreditCard.
	priceList _ aPriceList.
	! !


!Cashier methodsFor: 'macpal' stamp: 'E P 6/18/2017 21:24:35'!
debit: anAmount from: aCreditCard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'E P 6/18/2017 20:28:27'!
withSalesBook: aSalesBook Cart: aCart creditCard: aCreditCard andPriceList: aPriceList

	aCart isEmpty ifTrue: [ self error: self cannotCreateCashierWithAnEmptyCartErrorDescription ].
	(aCreditCard isExpiredOn: Date today) ifTrue: [ self error: self cannotCreateCashierWithAnExpiredCreditCardErrorDescription ]."deberia ser mes de año?"
	^self new initializeWithSalesBook: aSalesBook Cart: aCart creditCart: aCreditCard andPriceList: aPriceList.! !


!Cashier class methodsFor: 'error descriptions' stamp: 'E P 6/18/2017 19:40:15'!
cannotCreateCashierWithAnEmptyCartErrorDescription

	^'Cannot create cashier with an empty cart.'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'E P 6/18/2017 20:25:46'!
cannotCreateCashierWithAnExpiredCreditCardErrorDescription

	^'Cannot create cashier with an expired credit card.'.! !


!classDefinition: #CreditCard category: #'TusLibros-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number dateOfExpiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCard methodsFor: 'initialization' stamp: 'E P 6/18/2017 20:35:05'!
initializeWithOwner: anOwner number: aString andExpiration: aDate 

	owner _ anOwner.
	number _ aString.
	dateOfExpiration _ aDate.! !

!CreditCard methodsFor: 'initialization' stamp: 'E P 6/18/2017 20:38:44'!
isExpiredOn: aDate

	^dateOfExpiration < aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'E P 6/18/2017 20:35:19'!
withOwner: anOwner number: aString andExpiration: aDate 

	^self new initializeWithOwner: anOwner number: aString andExpiration: aDate.

	

	! !
