!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'E P 4/20/2017 21:57:00'!
assertThat: aBlockClosure takesLessMillisecondsThan: anAmountOfMilliseconds 
     | millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlockClosure value.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning) < anAmountOfMilliseconds .! !

!IdiomTest methodsFor: 'testing' stamp: 'E P 4/20/2017 21:35:39'!
should: aBlockClosure failOn: anError do: otherBlockClosure 
	
	[aBlockClosure value.
		self fail.] on: anError do: otherBlockClosure.! !

!IdiomTest methodsFor: 'testing' stamp: 'E P 4/20/2017 21:56:51'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.

	self assertThat: [customerBook addCustomerNamed: 'John Lennon'] takesLessMillisecondsThan: 50.
! !

!IdiomTest methodsFor: 'testing' stamp: 'E P 4/20/2017 21:56:56'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney aClosure |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	
	aClosure _ [customerBook removeCustomerNamed: paulMcCartney].
	
	
	self assertThat: aClosure takesLessMillisecondsThan: 100.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'E P 4/20/2017 21:37:42'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self should: [ customerBook addCustomerNamed: ''.]
		  failOn:  Error 
		  do: [ :anError | 
				self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
				self assert: customerBook isEmpty]
		
		! !

!IdiomTest methodsFor: 'testing' stamp: 'E P 4/20/2017 21:43:14'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
		  failOn: NotFound 
		  do: [ :anError | 
					self assert: customerBook numberOfCustomers = 1.
					self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
