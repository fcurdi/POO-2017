!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'oneMeter twoMeters threeMeters oneKilometer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:02:08'!
assertThatInterval: anInterval onlyContains: aCollection

	1 to: aCollection size do: [ :index |
		self assert: (anInterval at: index) = (aCollection at: index)
	].

	self assert: anInterval size = aCollection size.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/29/2017 23:36:58'!
test01ADistanceAddsWithAnotherDistanceCorrectly
	
	self assert: oneMeter + oneMeter = twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:10:57'!
test02ADistanceSubstractsWithAnotherDistanceCorrectly

	self assert: twoMeters - oneMeter = oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/29/2017 23:38:01'!
test03AScalarMultipliesWithADistanceCorrectly

	| fourMeters |
	
	fourMeters _ Distance withQuantity: 4 andUnit: DistanceUnit meter.
	
	self assert: twoMeters * 2 = fourMeters.
	self assert: 2* twoMeters = fourMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/29/2017 23:39:14'!
test04ADistanceDividesWithAScalarCorrectly

	| halfMeter |

	halfMeter _ Distance withQuantity: 0.5 andUnit: DistanceUnit meter.
	
	self assert: oneMeter / 2 = halfMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/29/2017 21:02:05'!
test05CannotCreateDistanceWithNegativeQuantity

	self should: [Distance withQuantity: -6 andUnit: DistanceUnit meter]
	 	raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: anError messageText equals: Distance createDistanceWithNegativeQuantityErrorMessage].! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/29/2017 23:43:51'!
test06CannotSubstractADistanceWithOneGreaterThanItself
	
	self should: [twoMeters - threeMeters ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance subtractingResultIsNegativeErrorMessage].

	
! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:32:11'!
test07CannotMultiplyADistanceWithANegativeScalar
	
	self should: [ oneMeter * -6 ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance multiplyByNegativeScalarErrorMessage].
			
	self should: [ -6 * oneMeter ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance multiplyByNegativeScalarErrorMessage].

	! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/29/2017 23:39:48'!
test08CannotDivideADistanceByANegativeScalar

	self should: [ oneMeter / -6 ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance divideByNegativeScalarErrorMessage ].

	
! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:14:25'!
test09DistancesCompareCorrectly
	
	self assert: oneMeter < twoMeters.
	self deny: oneMeter  > twoMeters.
	self assert: oneMeter  <= oneMeter.
	self assert: twoMeters >= twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:14:36'!
test10

	| aHundredCentimeters aThousandMilimeters |
	
	aHundredCentimeters _ Distance withQuantity: 100 andUnit: DistanceUnit centimeter.
	aThousandMilimeters _ Distance withQuantity: 1000 andUnit: DistanceUnit millimeter .
	
	self assert: oneMeter = oneMeter.
	self assert: oneMeter = aHundredCentimeters.
	self assert: oneMeter = aThousandMilimeters .
	self assert: (1000 * oneMeter) = oneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:14:44'!
test11

	| aDistanceInterval |

	aDistanceInterval _ oneMeter to: threeMeters.
	
	self assertThatInterval: aDistanceInterval onlyContains: {oneMeter . twoMeters . threeMeters .}.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:14:51'!
test12

	| nineHundredNinetyEightMeters nineHundredNinetyNineMeters aDistanceInterval|
	
	nineHundredNinetyEightMeters _ Distance withQuantity: 998 andUnit: DistanceUnit meter.
	nineHundredNinetyNineMeters _ Distance withQuantity: 999 andUnit: DistanceUnit meter.
	aDistanceInterval _ nineHundredNinetyEightMeters to: oneKilometer by: oneMeter.
	
	self assertThatInterval: aDistanceInterval onlyContains: {nineHundredNinetyEightMeters . nineHundredNinetyNineMeters . oneKilometer .}.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:14:58'!
test13

	| totalDistance gaussSumDistance |
	
	totalDistance _ Distance withQuantity: 0 andUnit: DistanceUnit meter.
	oneMeter to: oneKilometer by: oneMeter do: [ :aDistance | 
		totalDistance _ totalDistance + aDistance.
	].
	gaussSumDistance _ (Distance withQuantity: (1000*1001/2) andUnit: DistanceUnit meter).
	
	self assert: totalDistance = gaussSumDistance.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:30:43'!
test14
 
	oneMeter _ Distance withQuantity: 1 andUnit: DistanceUnit meter.
 	threeMeters _ Distance withQuantity: 3 andUnit: DistanceUnit meter.
 	
 	self should: [threeMeters to: oneMeter ] 
 		 raise: Error - MessageNotUnderstood 
 		 withExceptionDo: [ :anError | self assert: anError messageText equals: Distance cannotCreateNegativeIntervalErrorMessage].
 ! !


!DistanceTest methodsFor: 'setup' stamp: 'F C 5/29/2017 23:44:54'!
setUp

	| aDistanceFactory |
	
	aDistanceFactory _ DistanceFactory new.
	oneMeter _ aDistanceFactory oneMeter.
	twoMeters _ aDistanceFactory twoMeters.
	threeMeters _ Distance withQuantity: 3 andUnit: DistanceUnit meter.
	oneKilometer _ Distance withQuantity: 1 andUnit: DistanceUnit kilometer.! !


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

!Distance methodsFor: 'intervals' stamp: 'F C 5/30/2017 00:29:55'!
to: aDistance by: aDistanceIncrement do: aBlockClosure 

	| start stop step |
 	
 	start _ self quantityInBaseUnit.
 	stop _  aDistance quantityInBaseUnit.
 	step _ aDistanceIncrement quantityInBaseUnit.
 	
 	stop < start ifTrue: [self error: Distance cannotCreateNegativeIntervalErrorMessage].
 	
 	^start to: stop by: step  do: [ :aNumber |
  		aBlockClosure value: (Distance withQuantity: aNumber andUnit: self unit).
  	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'error descriptions' stamp: 'F C 5/30/2017 00:26:22'!
cannotCreateNegativeIntervalErrorMessage

	^'Cannot create interval with a start distance greater than its stop distance'.! !

!Distance class methodsFor: 'error descriptions' stamp: 'F C 5/30/2017 00:26:26'!
createDistanceWithNegativeQuantityErrorMessage

	^'Cannot create distances with negative quantities.'.! !

!Distance class methodsFor: 'error descriptions' stamp: 'F C 5/30/2017 00:26:28'!
divideByNegativeScalarErrorMessage

	^'Cannot divide by a negative scalar.'! !

!Distance class methodsFor: 'error descriptions' stamp: 'F C 5/30/2017 00:30:58'!
multiplyByNegativeScalarErrorMessage

	^'Cannot multiply by a negative scalar.'! !

!Distance class methodsFor: 'error descriptions' stamp: 'F C 5/30/2017 00:26:33'!
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

!DistanceUnit methodsFor: 'initialization' stamp: 'F C 5/30/2017 00:09:14'!
initializeWithRatio: aRatio 

	ratio _ aRatio.! !


!DistanceUnit methodsFor: 'accessing' stamp: 'F C 5/30/2017 00:09:17'!
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
