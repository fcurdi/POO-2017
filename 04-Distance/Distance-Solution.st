!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:01:17'!
test01ADistanceAddsWithAnotherDistanceCorrectly

	| dosMetros unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
	dosMetros _ Distance withQuantity: 2 andUnit: DistanceUnit meter.
	
	self assert: unMetro + unMetro = dosMetros.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:01:38'!
test02

	| dosMetros unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
	dosMetros _ Distance withQuantity: 2 andUnit: DistanceUnit meter.
	
	self assert: dosMetros - unMetro = unMetro.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:01:48'!
test03AScalarMultipliesWithADistanceCorrectly

	| dosMetros cuatroMetros |
	dosMetros _ Distance withQuantity: 2 andUnit: DistanceUnit meter.
	cuatroMetros _ Distance withQuantity: 4 andUnit: DistanceUnit meter.
	
	self assert: dosMetros * 2 = cuatroMetros.
	self assert: 2* dosMetros = cuatroMetros.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:01:59'!
test04ADistanceDividesWithAScalarCorrectly

	| medioMetro unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
	medioMetro _ Distance withQuantity: 0.5 andUnit: DistanceUnit meter.
	
	self assert: unMetro / 2 = medioMetro.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:02:05'!
test05CannotCreateDistanceWithNegativeQuantity

	self should: [Distance withQuantity: -6 andUnit: DistanceUnit meter]
	 	raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: anError messageText equals: Distance createDistanceWithNegativeQuantityErrorMessage].! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:02:20'!
test06CannotSubstractADistanceWithOneGreaterThanItself

	| dosMetros tresMetros |
	dosMetros _ Distance withQuantity: 2 andUnit: DistanceUnit meter.
	tresMetros _ Distance withQuantity: 3 andUnit: DistanceUnit meter.
	
	self should: [dosMetros - tresMetros ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance subtractingResultIsNegativeErrorMessage].

	
! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:02:28'!
test07CannotMultiplyADistanceWithANegativeScalar

	| unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
	
	self should: [ unMetro * -6 ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance multiplyByNegativeScalarErrorDescription].
			
	self should: [ -6 * unMetro ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance multiplyByNegativeScalarErrorDescription].

	! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:02:36'!
test08CannotDivideADistanceByANegativeScalar

	| unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
	
	self should: [ unMetro / -6 ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance divideByNegativeScalarErrorMessage ].

	
! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:03:00'!
test10DistancesCompareCorrectly

	| dosMetros unMetro |
	unMetro _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
	dosMetros _ Distance withQuantity: 2 andUnit: DistanceUnit meter.
	
	self assert: unMetro < dosMetros.
	self deny: unMetro > dosMetros.
	self assert: unMetro <= unMetro.
	self assert: dosMetros >= dosMetros.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:52:44'!
test11

	|   cienCentimetros unMetro milMilimetros unKilometro |
	
	unMetro _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
	cienCentimetros _ Distance withQuantity: 100 andUnit: DistanceUnit centimeter.
	milMilimetros _ Distance withQuantity: 1000 andUnit: DistanceUnit millimeter .
	unKilometro _ Distance withQuantity: 1 andUnit: DistanceUnit kilometer.
	
	self assert: unMetro = unMetro.
	self assert: unMetro = cienCentimetros.
	self assert: unMetro = milMilimetros .
	self assert: (1000 * unMetro) = unKilometro.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:53:10'!
test12

	| unMetro dosMetros tresMetros aDistanceInterval |
	
	unMetro _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
	dosMetros _ Distance withQuantity: 2 andUnit: DistanceUnit meter.
	tresMetros _ Distance withQuantity: 3 andUnit: DistanceUnit meter.
	aDistanceInterval _ unMetro to: tresMetros.
	
	self assert: (aDistanceInterval at:1) = unMetro.
	self assert: (aDistanceInterval at:2) = dosMetros .
	self assert: (aDistanceInterval at:3) = tresMetros .
	self assert: aDistanceInterval size = 3.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:53:38'!
test13

	| aMetro aKilometro novecientosNoventiOchoMetros novecientosNoventiNueveMetros unKilometro aDistanceInterval unMetro|
	
	aMetro _ DistanceUnit meter.
	aKilometro _ DistanceUnit kilometer .
	unMetro _ Distance withQuantity: 1 andUnit: aMetro.
	novecientosNoventiOchoMetros _ Distance withQuantity: 998 andUnit: aMetro.
	novecientosNoventiNueveMetros _ Distance withQuantity: 999 andUnit: aMetro.
	unKilometro _ Distance withQuantity: 1 andUnit: aKilometro.	
	aDistanceInterval _ novecientosNoventiOchoMetros to: unKilometro by: unMetro.
	
	self assert: (aDistanceInterval at:1) = novecientosNoventiOchoMetros.
	self assert: (aDistanceInterval at:2) = novecientosNoventiNueveMetros.
	self assert: (aDistanceInterval at:3) = unKilometro.
	self assert: aDistanceInterval size = 3.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:05:53'!
test14

	| aMetro aKilometro unKilometro unMetro totalDistance gaussSumDistance |
	
	aMetro _ DistanceUnit meter.
	aKilometro _ DistanceUnit kilometer.
	unMetro _ Distance withQuantity: 1 andUnit: aMetro.
	unKilometro _ Distance withQuantity: 1 andUnit: aKilometro.
	totalDistance _ Distance withQuantity: 0 andUnit: aMetro.
	unMetro to: unKilometro by: unMetro do: [ :aDistance | 
		totalDistance _ totalDistance + aDistance.
	].
	gaussSumDistance _ (Distance withQuantity: (1000*1001/2) andUnit: aMetro).
	
	self assert: totalDistance = gaussSumDistance.! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'unit quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'accessing' stamp: 'E P 5/24/2017 20:06:45'!
quantity

	^quantity.! !

!Distance methodsFor: 'accessing' stamp: 'E P 5/24/2017 20:05:04'!
quantityInBaseUnit 

	^quantity * unit ratio.! !

!Distance methodsFor: 'accessing' stamp: 'E P 5/24/2017 20:02:27'!
unit

	^unit.! !


!Distance methodsFor: 'arithmetic operations' stamp: 'E P 5/24/2017 20:08:08'!
* aNumber

	aNumber negative ifTrue: [ self error: 'Cannot multiply by a negative scalar.'].
	^Distance withQuantity: quantity * aNumber andUnit: unit.
	! !

!Distance methodsFor: 'arithmetic operations' stamp: 'E P 5/24/2017 20:05:18'!
+ aDistance 
	
	| addingResultInBaseUnit |
	
	addingResultInBaseUnit _ self quantityInBaseUnit + aDistance quantityInBaseUnit.
	^Distance withQuantity: (addingResultInBaseUnit / unit ratio) andUnit: unit.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'E P 5/24/2017 20:05:23'!
- aDistance 

	| substractionResultInBaseUnit |
	
	substractionResultInBaseUnit  _ self quantityInBaseUnit - aDistance quantityInBaseUnit.
	substractionResultInBaseUnit negative ifTrue: [self error: 'Result of substraction must be positive.'].
	^Distance withQuantity: (substractionResultInBaseUnit / unit ratio) andUnit: unit.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'E P 5/24/2017 20:08:11'!
/ aNumber 

	aNumber negative ifTrue: [self error: 'Cannot divide by a negative scalar.'].
	^Distance withQuantity: (quantity / aNumber) andUnit: unit. ! !


!Distance methodsFor: 'comparing' stamp: 'E P 5/24/2017 20:05:31'!
< aDistance 

	^self quantityInBaseUnit < aDistance quantityInBaseUnit.! !

!Distance methodsFor: 'comparing' stamp: 'E P 5/24/2017 20:05:35'!
<= aDistance 

	^self quantityInBaseUnit <= aDistance quantityInBaseUnit.! !

!Distance methodsFor: 'comparing' stamp: 'E P 5/24/2017 20:05:41'!
= aDistance

	^self quantityInBaseUnit = aDistance quantityInBaseUnit.
	! !

!Distance methodsFor: 'comparing' stamp: 'E P 5/24/2017 20:05:46'!
> aDistance 

	^self quantityInBaseUnit > aDistance quantityInBaseUnit.! !

!Distance methodsFor: 'comparing' stamp: 'E P 5/24/2017 20:05:51'!
>= aDistance 

	^self quantityInBaseUnit >= aDistance quantityInBaseUnit.! !


!Distance methodsFor: 'converting' stamp: 'E P 5/24/2017 20:02:16'!
adaptToNumber: aNumber andSend: aSymbol 

	^self * aNumber.! !


!Distance methodsFor: 'initialization' stamp: 'F C 5/28/2017 20:45:05'!
initializeWithQuantity: aScalar andUnit: anUnit

	quantity _ aScalar.
	unit _ anUnit.
	! !


!Distance methodsFor: 'intervals' stamp: 'E P 5/29/2017 21:55:27'!
to: aDistance

	| distanceIncrement |
	
	distanceIncrement _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
	^self to: aDistance by: distanceIncrement.! !

!Distance methodsFor: 'intervals' stamp: 'F C 5/28/2017 20:59:02'!
to: aDistance by: aDistanceIncrement 

	| aDistanceCollection |
	
	aDistanceCollection _ OrderedCollection new.
	self to: aDistance by: aDistanceIncrement do: [ :distance |
		aDistanceCollection add: distance.
	].
	^aDistanceCollection.! !

!Distance methodsFor: 'intervals' stamp: 'F C 5/27/2017 20:21:21'!
to: aDistance by: aDistanceIncrement do: aBlockClosure 
	
	^self quantityInBaseUnit to: aDistance quantityInBaseUnit by: aDistanceIncrement quantityInBaseUnit do: [ :aNumber |
		aBlockClosure value: (Distance withQuantity: aNumber andUnit: self unit).
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'error descriptions' stamp: 'E P 5/24/2017 20:03:41'!
createDistanceWithNegativeQuantityErrorMessage
	^'Cannot create distances with negative quantities.'.! !

!Distance class methodsFor: 'error descriptions' stamp: 'E P 5/24/2017 20:04:19'!
divideByNegativeScalarErrorMessage
	^'Cannot divide by a negative scalar.'! !

!Distance class methodsFor: 'error descriptions' stamp: 'E P 5/23/2017 20:21:56'!
multiplyByNegativeScalarErrorDescription
	^'Cannot multiply by a negative scalar.'! !

!Distance class methodsFor: 'error descriptions' stamp: 'E P 5/23/2017 20:24:52'!
subtractingResultIsNegativeErrorMessage
	^'Result of substraction must be positive.'.! !


!Distance class methodsFor: 'instance creation' stamp: 'E P 5/24/2017 20:03:53'!
withQuantity: aScalar andUnit: anUnit
	
	aScalar negative ifTrue: [self error: self createDistanceWithNegativeQuantityErrorMessage.].
	^self new initializeWithQuantity: aScalar andUnit: anUnit.! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/29/2017 21:00:03'!
minusOneMeter

	^Distance withQuantity: -1 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/29/2017 21:00:15'!
oneCentimeter

	^Distance withQuantity: 1 andUnit: DistanceUnit centimeter . ! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/29/2017 21:00:27'!
oneHundredCentimeters

	^Distance withQuantity: 100 andUnit: DistanceUnit centimeter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/29/2017 21:00:35'!
oneMeter

	^Distance withQuantity: 1 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/29/2017 21:00:49'!
twoHundredCentimeters

	^Distance withQuantity: 200 andUnit: DistanceUnit centimeter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/29/2017 21:00:59'!
twoMeters

	^Distance withQuantity: 2 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/29/2017 21:01:04'!
zeroMeters

	^Distance withQuantity: 0 andUnit: DistanceUnit meter.! !


!classDefinition: #DistanceUnit category: #'Distance-Solution'!
Object subclass: #DistanceUnit
	instanceVariableNames: 'ratio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 18:57:20'!
initializeWithRatio: aRatio 
	ratio _ aRatio.! !

!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'E P 5/24/2017 19:03:31'!
ratio
	^ ratio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceUnit class' category: #'Distance-Solution'!
DistanceUnit class
	instanceVariableNames: ''!

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'E P 5/29/2017 20:57:27'!
centimeter
	
	^self new initializeWithRatio: 0.01.! !

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'E P 5/29/2017 20:58:48'!
decameter
	
	^self new initializeWithRatio: 10.! !

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'E P 5/29/2017 20:57:21'!
decimeter
	
	^self new initializeWithRatio: 0.1.! !

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'E P 5/29/2017 20:58:55'!
hectometer
	
	^self new initializeWithRatio: 100.! !

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'E P 5/29/2017 21:10:09'!
kilometer
	
	^self new initializeWithRatio: 1000.! !

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'E P 5/29/2017 20:57:09'!
meter
	
	^self new initializeWithRatio: 1.! !

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'E P 5/29/2017 20:58:30'!
millimeter
	
	^self new initializeWithRatio: 0.001.! !
