!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:32:35'!
test01

	| dosMetros unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	
	self assert: unMetro + unMetro = dosMetros.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:33:03'!
test02

	| dosMetros unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	
	self assert: dosMetros - unMetro = unMetro.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:33:19'!
test03

	| dosMetros cuatroMetros |
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	cuatroMetros _ Distance withQuantity: 4 andUnit: (Meter withRatio: 1).
	
	self assert: dosMetros * 2 = cuatroMetros.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:33:28'!
test04

	| dosMetros cuatroMetros |
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	cuatroMetros _ Distance withQuantity: 4 andUnit: (Meter withRatio: 1).
	
	self assert: 2 * dosMetros  = cuatroMetros.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:33:45'!
test05

	| medioMetro unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	medioMetro _ Distance withQuantity: 0.5 andUnit: (Meter withRatio: 1).
	
	self assert: unMetro / 2 = medioMetro.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:33:55'!
test06

	| medioMetro unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	medioMetro _ Distance withQuantity: 0.5 andUnit: (Meter withRatio: 1).
	
	self assert: unMetro / 2 = medioMetro.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:04:03'!
test07

	self should: [Distance withQuantity: -6 andUnit: (Meter withRatio: 1).]
	 	raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: anError messageText equals: Distance createDistanceWithNegativeQuantityErrorMessage].! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:35:08'!
test08

	| dosMetros tresMetros |
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	tresMetros _ Distance withQuantity: 3 andUnit: (Meter withRatio: 1).
	
	self should: [dosMetros - tresMetros ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance subtractingResultIsNegativeErrorMessage].

	
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:35:13'!
test09

	| unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	
	self should: [ unMetro * -6 ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance multiplyByNegativeScalarErrorDescription].

	
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:04:27'!
test10

	| unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	
	self should: [ unMetro / -6 ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance divideByNegativeScalarErrorMessage ].

	
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:35:41'!
test11

	| unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	
	self should: [ -6 * unMetro ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance multiplyByNegativeScalarErrorDescription].

	
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:35:49'!
test12

	| dosMetros unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1)..
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	
	self assert: unMetro < dosMetros.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:35:58'!
test13

	| dosMetros unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	
	self deny: unMetro > dosMetros.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:36:07'!
test14

	| dosMetros unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	
	self deny: unMetro >= dosMetros.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:36:16'!
test15

	| dosMetros unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	
	self assert: unMetro <= dosMetros.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:15:04'!
test16

	| unMetro dosMetros |
	
	unMetro _ Distance withQuantity: 1 andUnit: (Meter withRatio: 1).
	dosMetros _ Distance withQuantity: 2 andUnit: (Meter withRatio: 1).
	
	self deny: unMetro = dosMetros.
	
		! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:14:04'!
test17

	|   aCentimetro aMetro cienCentimetros unMetro |
	
	aMetro _ Meter withRatio: 1.
	aCentimetro _ Meter withRatio: 0.01.
	unMetro _ Distance withQuantity: 1 andUnit: aMetro.
	cienCentimetros _ Distance withQuantity: 100 andUnit: aCentimetro.
	
	self assert: unMetro = cienCentimetros.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'F C 5/27/2017 18:39:47'!
test18

	| aMetro unMetro dosMetros tresMetros aDistanceInterval |
	
	aMetro _ Meter withRatio: 1.
	unMetro _ Distance withQuantity: 1 andUnit: aMetro.
	dosMetros _ Distance withQuantity: 2 andUnit: aMetro.
	tresMetros _ Distance withQuantity: 3 andUnit: aMetro.
	aDistanceInterval _ unMetro to: tresMetros.
	
	self assert: (aDistanceInterval at:1) = unMetro.
	self assert: (aDistanceInterval at:2) = dosMetros .
	self assert: (aDistanceInterval at:3) = tresMetros .
	self assert: aDistanceInterval size = 3.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'F C 5/27/2017 19:24:37'!
test19

	| aMetro aKilometer novecientosNoventiOchoMetros novecientosNoventiNueveMetros unKilometro aDistanceInterval unMetro|
	
	aMetro _ Meter withRatio: 1.
	aKilometer _ Meter withRatio: 1000.
	unMetro _ Distance withQuantity: 1 andUnit: aMetro.
	novecientosNoventiOchoMetros _ Distance withQuantity: 998 andUnit: aMetro.
	novecientosNoventiNueveMetros _ Distance withQuantity: 999 andUnit: aMetro.
	unKilometro _ Distance withQuantity: 1 andUnit: aKilometer.	
	aDistanceInterval _ novecientosNoventiOchoMetros to: unKilometro by: unMetro.
	
	self assert: (aDistanceInterval at:1) = novecientosNoventiOchoMetros.
	self assert: (aDistanceInterval at:2) = novecientosNoventiNueveMetros.
	self assert: (aDistanceInterval at:3) = unKilometro.
	self assert: aDistanceInterval size = 3.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'F C 5/27/2017 20:16:12'!
test20

	| aMetro aKilometer unKilometro unMetro totalDistance |
	
	aMetro _ Meter withRatio: 1.
	aKilometer _ Meter withRatio: 1000.
	unMetro _ Distance withQuantity: 1 andUnit: aMetro.
	unKilometro _ Distance withQuantity: 1 andUnit: aKilometer.
	totalDistance _ Distance withQuantity: 0 andUnit: aMetro.
	unMetro to: unKilometro by: unMetro do: [ :aDistance | 
		totalDistance _ totalDistance + aDistance.
	].
	
	self assert: totalDistance = (Distance withQuantity: (1000*1001/2) andUnit: aMetro).! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'unit quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:08:08'!
* aNumber

	aNumber negative ifTrue: [ self error: 'Cannot multiply by a negative scalar.'].
	^Distance withQuantity: quantity * aNumber andUnit: unit.
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:05:18'!
+ aDistance 
	
	| addingResultInBaseUnit |
	
	addingResultInBaseUnit _ self quantityInBaseUnit + aDistance quantityInBaseUnit.
	^Distance withQuantity: (addingResultInBaseUnit / unit ratio) andUnit: unit.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:05:23'!
- aDistance 

	| substractionResultInBaseUnit |
	
	substractionResultInBaseUnit  _ self quantityInBaseUnit - aDistance quantityInBaseUnit.
	substractionResultInBaseUnit negative ifTrue: [self error: 'Result of substraction must be positive.'].
	^Distance withQuantity: (substractionResultInBaseUnit / unit ratio) andUnit: unit.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:08:11'!
/ aNumber 

	aNumber negative ifTrue: [self error: 'Cannot divide by a negative scalar.'].
	^Distance withQuantity: (quantity / aNumber) andUnit: unit. ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:05:31'!
< aDistance 

	^self quantityInBaseUnit < aDistance quantityInBaseUnit.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:05:35'!
<= aDistance 

	^self quantityInBaseUnit <= aDistance quantityInBaseUnit.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:05:41'!
= aDistance

	^self quantityInBaseUnit = aDistance quantityInBaseUnit.
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:05:46'!
> aDistance 

	^self quantityInBaseUnit > aDistance quantityInBaseUnit.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:05:51'!
>= aDistance 

	^self quantityInBaseUnit >= aDistance quantityInBaseUnit.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:02:16'!
adaptToNumber: aNumber andSend: aSymbol 

	^self * aNumber.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:07:29'!
initializeWithQuantity: aScalar andUnit: anUnit

	quantity _ aScalar .
	unit _ anUnit.
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:06:45'!
quantity

	^quantity.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:05:04'!
quantityInBaseUnit 

	^quantity * unit ratio.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'F C 5/27/2017 20:19:51'!
to: aDistance

	| distanceIncrement |
	
	distanceIncrement _ Distance withQuantity: 1 andUnit: self unit.
	^self to: aDistance by: distanceIncrement.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'F C 5/27/2017 20:19:43'!
to: aDistance by: aDistanceIncrement 

	| aDistanceCollection |
	
	aDistanceCollection _ OrderedCollection new.
	self to: aDistance by: aDistanceIncrement do: [ :distance |
		aDistanceCollection add: distance.
	].
	^aDistanceCollection ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'F C 5/27/2017 20:21:21'!
to: aDistance by: aDistanceIncrement do: aBlockClosure 
	
	^self quantityInBaseUnit to: aDistance quantityInBaseUnit by: aDistanceIncrement quantityInBaseUnit do: [ :aNumber |
		aBlockClosure value: (Distance withQuantity: aNumber andUnit: self unit).
	].! !

!Distance methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:02:27'!
unit

	^unit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:03:41'!
createDistanceWithNegativeQuantityErrorMessage
	^'Cannot create distances with negative quantities.'.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:04:19'!
divideByNegativeScalarErrorMessage
	^'Cannot divide by a negative scalar.'! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'E P 5/23/2017 20:21:56'!
multiplyByNegativeScalarErrorDescription
	^'Cannot multiply by a negative scalar.'! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'E P 5/23/2017 20:24:52'!
subtractingResultIsNegativeErrorMessage
	^'Result of substraction must be positive.'.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:03:53'!
withQuantity: aScalar andUnit: anUnit
	
	aScalar negative ifTrue: [self error: self createDistanceWithNegativeQuantityErrorMessage.].
	^self new initializeWithQuantity: aScalar andUnit: anUnit.! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:35:03'!
minusOneMeter

	^Distance withQuantity: -1 andUnit: (Meter withRatio: 1).! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:28:22'!
oneCentimeter

	^Distance withQuantity: 1 andUnit: (Meter withRatio: 0.01). ! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:28:42'!
oneHundredCentimeters

	^Distance withQuantity: 100 andUnit: (Meter withRatio: 0.01).! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:30:28'!
oneMeter

	^Distance withQuantity: 1 andUnit: (Meter withRatio: 1).! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:28:49'!
twoHundredCentimeters

	^Distance withQuantity: 200 andUnit: (Meter withRatio: 0.01).! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:29:27'!
twoMeters

	^Distance withQuantity: 2 andUnit: (Meter withRatio: 1).! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 20:29:37'!
zeroMeters

	^Distance withQuantity: 0 andUnit: (Meter withRatio: 1).! !


!classDefinition: #Meter category: #'Distance-Solution'!
Object subclass: #Meter
	instanceVariableNames: 'ratio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Meter methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 18:57:20'!
initializeWithRatio: aRatio 
	ratio _ aRatio.! !

!Meter methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:03:31'!
ratio
	^ ratio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Meter class' category: #'Distance-Solution'!
Meter class
	instanceVariableNames: ''!

!Meter class methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:29:26'!
withRatio: aRatio 
	
	^self new initializeWithRatio: aRatio.! !
