!classDefinition: #Distance category: #'Distance-Solution'!
Magnitude subclass: #Distance
	instanceVariableNames: 'unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'accessing' stamp: 'E P 5/31/2017 19:17:40'!
amount

	^amount.! !

!Distance methodsFor: 'accessing' stamp: 'E P 6/1/2017 19:46:08'!
amountInBaseUnit 

	^amount * unit ratio.! !

!Distance methodsFor: 'accessing' stamp: 'E P 5/24/2017 20:02:27'!
unit

	^unit.! !


!Distance methodsFor: 'arithmetic operations' stamp: 'E P 5/31/2017 19:38:15'!
* aNumber

	^Distance withAmount: amount * aNumber andUnit: unit.
	
	! !

!Distance methodsFor: 'arithmetic operations' stamp: 'E P 6/1/2017 19:46:21'!
+ aDistance 
	
	| addingResultInBaseUnit |
	
	addingResultInBaseUnit _ self amountInBaseUnit + aDistance amountInBaseUnit.
	^Distance withAmount: (addingResultInBaseUnit / unit ratio) andUnit: unit.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'E P 6/1/2017 19:46:26'!
- aDistance 

	| substractionResultInBaseUnit |
	
	substractionResultInBaseUnit  _ self amountInBaseUnit - aDistance amountInBaseUnit.
	^Distance withAmount: (substractionResultInBaseUnit / unit ratio) andUnit: unit.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'E P 5/31/2017 19:37:04'!
/ aNumber 

	^Distance withAmount: (amount / aNumber) andUnit: unit. ! !

!Distance methodsFor: 'arithmetic operations' stamp: 'E P 5/31/2017 19:42:48'!
negated
	
	^Distance withAmount: amount negated andUnit: unit.! !


!Distance methodsFor: 'comparing' stamp: 'E P 6/1/2017 19:46:31'!
< aDistance 

	^self amountInBaseUnit < aDistance amountInBaseUnit.! !

!Distance methodsFor: 'comparing' stamp: 'E P 6/1/2017 19:46:35'!
= anObject

	^(anObject isKindOf: Distance) and: [ self amountInBaseUnit = anObject amountInBaseUnit ].
	
	! !

!Distance methodsFor: 'comparing' stamp: 'E P 6/1/2017 19:46:44'!
hash

	^self amountInBaseUnit hash.! !


!Distance methodsFor: 'converting' stamp: 'E P 5/24/2017 20:02:16'!
adaptToNumber: aNumber andSend: aSymbol 

	^self * aNumber.! !

!Distance methodsFor: 'converting' stamp: 'E P 6/1/2017 19:46:41'!
convertTo: anUnit
	
	^Distance withAmount: (self amountInBaseUnit / anUnit ratio) andUnit: anUnit.! !


!Distance methodsFor: 'initialization' stamp: 'E P 5/31/2017 19:35:02'!
initializeWithAmount: anAmount andUnit: anUnit

	amount _ anAmount.
	unit _ anUnit.
	! !


!Distance methodsFor: 'intervals' stamp: 'E P 5/31/2017 19:33:38'!
to: aDistance

	| distanceIncrement |
	
	distanceIncrement _ Distance withAmount: 1 andUnit: unit.
	^self to: aDistance by: distanceIncrement.! !

!Distance methodsFor: 'intervals' stamp: 'E P 5/30/2017 18:18:14'!
to: aDistance by: aDistanceIncrement 
	
	^DistanceInterval withStart: self stop: aDistance andStep: aDistanceIncrement.! !

!Distance methodsFor: 'intervals' stamp: 'E P 5/30/2017 14:06:24'!
to: aDistance by: aDistanceIncrement do: aBlockClosure 

	(self to: aDistance by: aDistanceIncrement) do: aBlockClosure.! !


!Distance methodsFor: 'printing' stamp: 'E P 5/31/2017 20:15:47'!
printString

	| distanceAsString |
	distanceAsString _ amount printString, ' ', unit printString.
	(amount > 1) 
		ifTrue: [ ^distanceAsString, 's' ]
		ifFalse: [ ^distanceAsString] .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'instance creation' stamp: 'E P 5/31/2017 19:32:14'!
withAmount: anAmount andUnit: anUnit
	
	^self new initializeWithAmount: anAmount andUnit: anUnit.! !


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
Collection subclass: #DistanceInterval
	instanceVariableNames: 'from to by'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'accessing' stamp: 'E P 6/1/2017 19:32:16'!
by

	^by.! !

!DistanceInterval methodsFor: 'accessing' stamp: 'E P 6/1/2017 19:32:11'!
from 

	^from.! !

!DistanceInterval methodsFor: 'accessing' stamp: 'E P 6/1/2017 19:32:24'!
to

	^to.! !


!DistanceInterval methodsFor: 'adding' stamp: 'E P 5/30/2017 18:10:37'!
add: newObject 
	"Adding to a DistanceInterval is not allowed."

	self shouldNotImplement! !


!DistanceInterval methodsFor: 'enumerating' stamp: 'E P 6/1/2017 20:58:38'!
do: aBlock 

	0 to: (self size - 1) do: [ :i |
		aBlock value: (from + (by * i))].! !


!DistanceInterval methodsFor: 'initializing' stamp: 'E P 6/1/2017 19:30:46'!
initializeWithStart: startDistance stop: stopDistance andStep: aStepDistance

	| smallerUnit |
	
	smallerUnit _ startDistance unit min: (stopDistance unit).
	
	from _ startDistance convertTo: smallerUnit.
	to _ stopDistance convertTo: smallerUnit.
	by _ aStepDistance convertTo: smallerUnit.
	
	! !


!DistanceInterval methodsFor: 'testing' stamp: 'E P 6/1/2017 20:40:59'!
size

	^(((to - from) amount abs + 1) / (by amount abs)) ceiling.
	
! !


!DistanceInterval methodsFor: 'printing' stamp: 'E P 6/1/2017 21:11:44'!
printString

	^'Interval (', from printString , ' to: ', to printString, ') by: ', by printString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'instance creation' stamp: 'E P 6/1/2017 19:33:24'!
withStart: startDistance stop: stopDistance andStep: aStepDistance

	^self new initializeWithStart: startDistance stop: stopDistance andStep: aStepDistance.


	! !



!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'oneMeter twoMeters threeMeters oneKilometer fourMeters halfMeter aHundredCentimeters aThousandMilimeters nineHundredNinetyEightMeters nineHundredNinetyNineMeters minusOneMeter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'testing' stamp: 'E P 6/1/2017 20:49:30'!
assertThatInterval: anInterval onlyContains: anOrderedCollection

	| index |
	index _ 1.
	anInterval do: [ :aDistance |  
		self assert: (anOrderedCollection at: index) = aDistance.
		index _ index + 1.
	].

	self assert: anInterval size = anOrderedCollection size.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/29/2017 23:36:58'!
test01ADistanceAddsWithAnotherDistanceCorrectly
	
	self assert: oneMeter + oneMeter = twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'F C 5/30/2017 00:10:57'!
test02ADistanceSubstractsWithAnotherDistanceCorrectly

	self assert: twoMeters - oneMeter = oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/30/2017 00:44:40'!
test03AScalarMultipliesWithADistanceCorrectly
	
	self assert: twoMeters * 2 = fourMeters.
	self assert: 2* twoMeters = fourMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/30/2017 00:45:13'!
test04ADistanceDividesWithAScalarCorrectly
	
	self assert: oneMeter / 2 = halfMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/30/2017 01:11:20'!
test09DistancesCompareCorrectlyTheirLength
	
	self assert: oneMeter < twoMeters.
	self deny: oneMeter  > twoMeters.
	self assert: oneMeter  <= oneMeter.
	self assert: twoMeters >= twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/30/2017 01:09:48'!
test10DistancesWithDifferentUnitCompareCorrectly
	
	self assert: oneMeter = oneMeter.
	self assert: oneMeter = aHundredCentimeters.
	self assert: oneMeter = aThousandMilimeters .
	self assert: (1000 * oneMeter) = oneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/30/2017 01:12:08'!
test11AnIntervalIsCreatedCorrectlyAndWithAllItsElementsInOrder

	| aDistanceInterval |

	aDistanceInterval _ oneMeter to: threeMeters.
	
	self assertThatInterval: aDistanceInterval onlyContains: {oneMeter . twoMeters . threeMeters .}.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/30/2017 13:57:04'!
test12CanPassADistanceAsStepAndTheStartAndStopOfTheIntervalCanHaveDifferentUnitsWhenCreated

	| aDistanceInterval |
	
	aDistanceInterval _ nineHundredNinetyEightMeters to: oneKilometer by: oneMeter.
	
	self assertThatInterval: aDistanceInterval onlyContains: { nineHundredNinetyEightMeters . nineHundredNinetyNineMeters . oneKilometer . }.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/31/2017 19:34:24'!
test13AnIntervalCanBeCreatedWithAClosureAsCollaboratorAndTheClosureReceivesTheValuesOfTheInterval

	| totalDistance gaussSumDistance |
	
	totalDistance _ Distance withAmount: 0 andUnit: DistanceUnit meter.
	oneMeter to: oneKilometer by: oneMeter do: [ :aDistance | 
		totalDistance _ totalDistance + aDistance.
	].
	gaussSumDistance _ (Distance withAmount: (1000*1001/2) andUnit: DistanceUnit meter).
	
	self assert: totalDistance = gaussSumDistance.! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/30/2017 01:32:16'!
test15PassingAStepGreaterThanTheDifferenceBetweenTheStartAndStopReturnsAnIntervalWithOnlyTheFirstElement
	| aDistanceInterval |
	
	aDistanceInterval _ oneMeter to: twoMeters by: twoMeters .
	
	self assertThatInterval: aDistanceInterval onlyContains: { oneMeter. }! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/31/2017 19:42:02'!
test16NegatingADistanceShouldReturnTheSameDistanceButWithItsAmountNegated
	
	self assert: oneMeter negated = minusOneMeter .! !

!DistanceTest methodsFor: 'testing' stamp: 'E P 5/31/2017 19:43:27'!
test17NegatingADistanceShouldBeReflective
	
	self assert: minusOneMeter negated negated = minusOneMeter .! !


!DistanceTest methodsFor: 'setup' stamp: 'E P 5/31/2017 19:41:46'!
setUp

	| aDistanceFactory |
	
	aDistanceFactory _ DistanceFactory new.
	minusOneMeter _ aDistanceFactory minusOneMeter.
	oneMeter _ aDistanceFactory oneMeter.
	twoMeters _ aDistanceFactory twoMeters.
	threeMeters _ Distance withAmount: 3 andUnit: DistanceUnit meter.
	fourMeters _ Distance withAmount: 4 andUnit: DistanceUnit meter.
	halfMeter _ Distance withAmount: 0.5 andUnit: DistanceUnit meter.
	oneKilometer _ Distance withAmount: 1 andUnit: DistanceUnit kilometer.
	aHundredCentimeters _ Distance withAmount: 100 andUnit: DistanceUnit centimeter.
	aThousandMilimeters _ Distance withAmount: 1000 andUnit: DistanceUnit millimeter .
	nineHundredNinetyEightMeters _ Distance withAmount: 998 andUnit: DistanceUnit meter.
	nineHundredNinetyNineMeters _ Distance withAmount: 999 andUnit: DistanceUnit meter.! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/31/2017 19:33:44'!
minusOneMeter

	^Distance withAmount: -1 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/31/2017 19:33:48'!
oneCentimeter

	^Distance withAmount: 1 andUnit: DistanceUnit centimeter . ! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/31/2017 19:33:50'!
oneHundredCentimeters

	^Distance withAmount: 100 andUnit: DistanceUnit centimeter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/31/2017 19:33:53'!
oneMeter

	^Distance withAmount: 1 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/31/2017 19:33:57'!
twoHundredCentimeters

	^Distance withAmount: 200 andUnit: DistanceUnit centimeter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/31/2017 19:33:59'!
twoMeters

	^Distance withAmount: 2 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 5/31/2017 19:34:03'!
zeroMeters

	^Distance withAmount: 0 andUnit: DistanceUnit meter.! !


!classDefinition: #DistanceUnit category: #'Distance-Solution'!
Object subclass: #DistanceUnit
	instanceVariableNames: 'ratio name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceUnit methodsFor: 'initialization' stamp: 'E P 5/31/2017 20:05:41'!
initializeWithRatio: aRatio andName: aName

	ratio _ aRatio.
	name _ aName.! !


!DistanceUnit methodsFor: 'accessing' stamp: 'F C 5/30/2017 00:09:17'!
ratio

	^ ratio.! !


!DistanceUnit methodsFor: 'comparing' stamp: 'E P 5/31/2017 19:45:00'!
= anUnit

	^self ratio = anUnit ratio.! !

!DistanceUnit methodsFor: 'comparing' stamp: 'E P 6/1/2017 19:11:45'!
hash

	^ratio hash.! !

!DistanceUnit methodsFor: 'comparing' stamp: 'E P 5/30/2017 18:35:43'!
min: anUnit

	"Returns the unit with the smaller ratio".
	
	(self ratio < anUnit ratio) ifTrue: [^self] 
								ifFalse: [^anUnit].! !


!DistanceUnit methodsFor: 'printing' stamp: 'E P 5/31/2017 20:08:10'!
printString

	^name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceUnit class' category: #'Distance-Solution'!
DistanceUnit class
	instanceVariableNames: ''!

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 5/31/2017 20:10:11'!
centimeter
	
	^self new initializeWithRatio: (1/100) andName: 'centimeter'.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 5/31/2017 20:06:29'!
decameter
	
	^self new initializeWithRatio: 10 andName: 'decameter'.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 5/31/2017 20:10:18'!
decimeter
	
	^self new initializeWithRatio: (1/10) andName: 'decimeter'.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 5/31/2017 20:07:11'!
hectometer
	
	^self new initializeWithRatio: 100 andName: 'hectometer'.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 5/31/2017 20:07:19'!
kilometer
	
	^self new initializeWithRatio: 1000 andName: 'kilometer'.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 5/31/2017 20:07:35'!
meter
	
	^self new initializeWithRatio: 1 andName: 'meter'.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 5/31/2017 20:10:27'!
millimeter
	
	^self new initializeWithRatio: (1/1000) andName: 'millimeter'.! !
