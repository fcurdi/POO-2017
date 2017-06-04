!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'instance creation' stamp: 'F C 6/4/2017 19:16:26'!
withAmount: anAmount andUnit: anUnit
	
	^(anUnit nullValue = anAmount) 
		ifTrue: [ NullMeasure withUnit: anUnit ]
		ifFalse: [ ConcreteMeasure withAmount: anAmount andUnit: anUnit ].
	! !


!classDefinition: #ConcreteMeasure category: #'Measure-Solution'!
Measure subclass: #ConcreteMeasure
	instanceVariableNames: 'unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!ConcreteMeasure methodsFor: 'converting' stamp: 'F C 6/4/2017 16:49:16'!
amountInBaseUnit

	^(self convertTo: unit class baseUnit) amount.! !

!ConcreteMeasure methodsFor: 'converting' stamp: 'F C 6/4/2017 16:20:33'!
convertTo: anUnit
	
	^self class withAmount: ((amount * unit ratio) / anUnit ratio) andUnit: anUnit.! !


!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 15:55:22'!
* aNumber

	^self class withAmount: amount * aNumber andUnit: unit.
	
	! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 15:59:47'!
+ aMeasure
	
	| addingResultInBaseUnit |
	
	addingResultInBaseUnit _ self amountInBaseUnit + aMeasure amountInBaseUnit.
	^self class withAmount: (addingResultInBaseUnit / unit ratio) andUnit: unit.! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 16:06:23'!
- aMeasure 

	| substractionResultInBaseUnit |
	
	substractionResultInBaseUnit  _ self amountInBaseUnit - aMeasure amountInBaseUnit.
	^self class withAmount: (substractionResultInBaseUnit / unit ratio) andUnit: unit.! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 16:06:53'!
/ aNumber 

	^self class withAmount: (amount / aNumber) andUnit: unit. ! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 16:19:41'!
hash

	^self amountInBaseUnit hash.! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 16:22:55'!
initializeWithAmount: anAmount andUnit: anUnit

	amount _ anAmount.
	unit _ anUnit.! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 16:09:04'!
negated
	
	^self class withAmount: amount negated andUnit: unit.! !


!ConcreteMeasure methodsFor: 'comparing' stamp: 'F C 6/4/2017 16:12:28'!
< aMeasure 

	^self amountInBaseUnit < aMeasure amountInBaseUnit.! !

!ConcreteMeasure methodsFor: 'comparing' stamp: 'E P 6/4/2017 18:52:43'!
= anObject

	^ (anObject isKindOf: ConcreteMeasure) and:[
			(anObject unit isKindOf: self unit class) and: [ 
				self amountInBaseUnit = anObject amountInBaseUnit
				].
		]
	
	
	! !

!ConcreteMeasure methodsFor: 'comparing' stamp: 'F C 6/4/2017 16:25:44'!
adaptToNumber: aNumber andSend: aSymbol 

	^self * aNumber.! !


!ConcreteMeasure methodsFor: 'accessing' stamp: 'F C 6/4/2017 16:11:42'!
amount

	^amount.! !

!ConcreteMeasure methodsFor: 'accessing' stamp: 'F C 6/4/2017 16:11:31'!
unit

	^unit.! !


!ConcreteMeasure methodsFor: 'printing' stamp: 'F C 6/4/2017 16:28:38'!
printString

	| measureAsString |
	measureAsString _ amount printString, ' ', unit printString.
	(amount > 1) 
		ifTrue: [ ^measureAsString, 's' ]
		ifFalse: [ ^measureAsString] .! !


!ConcreteMeasure methodsFor: 'intervals' stamp: 'F C 6/4/2017 16:31:07'!
to: aMeasure

	| measureIncrement |
	
	measureIncrement _ self class withAmount: 1 andUnit: unit.
	^self to: aMeasure by: measureIncrement.! !

!ConcreteMeasure methodsFor: 'intervals' stamp: 'F C 6/4/2017 16:40:43'!
to: aMeasure by: aMeasureIncrement 
	
	^MeasureInterval withStart: self stop: aMeasure andStep: aMeasureIncrement.! !

!ConcreteMeasure methodsFor: 'intervals' stamp: 'F C 6/4/2017 16:32:52'!
to: aMeasure by: aMeasureIncrement do: aBlockClosure 

	(self to: aMeasure by: aMeasureIncrement) do: aBlockClosure.! !


!ConcreteMeasure methodsFor: 'testing' stamp: 'E P 6/4/2017 19:37:48'!
isNullMeasure
	
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ConcreteMeasure class' category: #'Measure-Solution'!
ConcreteMeasure class
	instanceVariableNames: ''!

!ConcreteMeasure class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:49:11'!
withAmount: anAmount andUnit: anUnit
	
	^(anUnit nullValue = anAmount) 
		ifTrue: [ NullMeasure withUnit: anUnit ]
		ifFalse: [ self new initializeWithAmount: anAmount andUnit: anUnit ].
	! !


!classDefinition: #NullMeasure category: #'Measure-Solution'!
Measure subclass: #NullMeasure
	instanceVariableNames: 'unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!NullMeasure methodsFor: 'instance creation' stamp: 'E P 6/4/2017 19:24:58'!
initializeWithUnit: anUnit

	unit _ anUnit.! !


!NullMeasure methodsFor: 'comparing' stamp: 'E P 6/4/2017 18:05:49'!
= anObject

	^ (anObject isKindOf: self class). 
	
	
	! !


!NullMeasure methodsFor: 'converting' stamp: 'E P 6/4/2017 19:26:15'!
amountInBaseUnit
	
	^self unit nullValue.! !


!NullMeasure methodsFor: 'accessing' stamp: 'E P 6/4/2017 19:25:46'!
unit

	^unit.! !


!NullMeasure methodsFor: 'arithmetic operation' stamp: 'E P 6/4/2017 19:37:05'!
+ aMeasure 
	
	aMeasure isNullMeasure ifTrue: [ ^self ]
		ifFalse: [ ^aMeasure + self ].! !

!NullMeasure methodsFor: 'arithmetic operation' stamp: 'E P 6/4/2017 19:38:50'!
- aMeasure 
	
	aMeasure isNullMeasure ifTrue: [ ^self ]
		ifFalse: [ ^aMeasure - self ].! !


!NullMeasure methodsFor: 'testing' stamp: 'E P 6/4/2017 19:38:22'!
isNullMeasure

	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NullMeasure class' category: #'Measure-Solution'!
NullMeasure class
	instanceVariableNames: ''!

!NullMeasure class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:08:06'!
withUnit: anUnit

	^self new initializeWithUnit: anUnit.

	! !


!classDefinition: #MeasureInterval category: #'Measure-Solution'!
Collection subclass: #MeasureInterval
	instanceVariableNames: 'from to by'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureInterval methodsFor: 'accessing' stamp: 'E P 6/1/2017 19:32:16'!
by

	^by.! !

!MeasureInterval methodsFor: 'accessing' stamp: 'E P 6/1/2017 19:32:11'!
from 

	^from.! !

!MeasureInterval methodsFor: 'accessing' stamp: 'E P 6/1/2017 19:32:24'!
to

	^to.! !


!MeasureInterval methodsFor: 'adding' stamp: 'F C 6/4/2017 16:34:04'!
add: newObject 
	"Adding to a MeasureInterval is not allowed."

	self shouldNotImplement! !


!MeasureInterval methodsFor: 'enumerating' stamp: 'E P 6/1/2017 20:58:38'!
do: aBlock 

	0 to: (self size - 1) do: [ :i |
		aBlock value: (from + (by * i))].! !


!MeasureInterval methodsFor: 'initializing' stamp: 'F C 6/4/2017 16:34:56'!
initializeWithStart: start stop: stop andStep: step

	| smallerUnit |
	
	smallerUnit _ start unit min: (stop unit).
	
	from _ start convertTo: smallerUnit.
	to _ stop convertTo: smallerUnit.
	by _ step convertTo: smallerUnit.
	
	! !


!MeasureInterval methodsFor: 'testing' stamp: 'E P 6/1/2017 20:40:59'!
size

	^(((to - from) amount abs + 1) / (by amount abs)) ceiling.
	
! !


!MeasureInterval methodsFor: 'printing' stamp: 'E P 6/1/2017 21:11:44'!
printString

	^'Interval (', from printString , ' to: ', to printString, ') by: ', by printString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureInterval class' category: #'Measure-Solution'!
MeasureInterval class
	instanceVariableNames: ''!

!MeasureInterval class methodsFor: 'instance creation' stamp: 'E P 6/1/2017 19:33:24'!
withStart: startDistance stop: stopDistance andStep: aStepDistance

	^self new initializeWithStart: startDistance stop: stopDistance andStep: aStepDistance.


	! !


!classDefinition: #DistanceTest category: #'Measure-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'oneMeter twoMeters threeMeters oneKilometer fourMeters halfMeter aHundredCentimeters aThousandMilimeters nineHundredNinetyEightMeters nineHundredNinetyNineMeters minusOneMeter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

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

!DistanceTest methodsFor: 'testing' stamp: 'F C 6/4/2017 19:18:10'!
test13AnIntervalCanBeCreatedWithAClosureAsCollaboratorAndTheClosureReceivesTheValuesOfTheInterval

	| totalDistance gaussSumDistance |
	
	totalDistance _ Measure withAmount: 0 andUnit: DistanceUnit meter.
	oneMeter to: oneKilometer by: oneMeter do: [ :aDistance | 
		totalDistance _ totalDistance + aDistance.
	].
	gaussSumDistance _ (Measure withAmount: (1000*1001/2) andUnit: DistanceUnit meter).
	
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


!DistanceTest methodsFor: 'setup' stamp: 'F C 6/4/2017 19:17:48'!
setUp

	| aDistanceFactory |
	
	aDistanceFactory _ DistanceFactory new.
	minusOneMeter _ aDistanceFactory minusOneMeter.
	oneMeter _ aDistanceFactory oneMeter.
	twoMeters _ aDistanceFactory twoMeters.
	threeMeters _ Measure withAmount: 3 andUnit: DistanceUnit meter.
	fourMeters _ Measure withAmount: 4 andUnit: DistanceUnit meter.
	halfMeter _ Measure withAmount: 0.5 andUnit: DistanceUnit meter.
	oneKilometer _ Measure withAmount: 1 andUnit: DistanceUnit kilometer.
	aHundredCentimeters _ Measure withAmount: 100 andUnit: DistanceUnit centimeter.
	aThousandMilimeters _ Measure withAmount: 1000 andUnit: DistanceUnit millimeter .
	nineHundredNinetyEightMeters _ Measure withAmount: 998 andUnit: DistanceUnit meter.
	nineHundredNinetyNineMeters _ Measure withAmount: 999 andUnit: DistanceUnit meter.! !


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/4/2017 18:53:38'!
test01

	| aMeter aPeso |
	
	aMeter _ ConcreteMeasure withAmount: 1 andUnit: DistanceUnit meter.
	aPeso _ ConcreteMeasure withAmount: 1 andUnit: CurrencyUnit peso.
	
	self deny: aMeter = aPeso.! !

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/4/2017 19:14:03'!
test02

	|  absoluteZero zeroCelsius zeroKelvin zeroMeters zeroPesos |
	
	zeroMeters _ Measure withAmount: 0 andUnit: DistanceUnit centimeter.
	zeroPesos _ Measure withAmount: 0 andUnit: CurrencyUnit dollar.
	zeroCelsius _ Measure withAmount: 0 andUnit: TemperatureUnit celsius. 
	absoluteZero _ Measure withAmount: -273 andUnit: TemperatureUnit celsius. 
	zeroKelvin _ Measure withAmount: 0 andUnit: TemperatureUnit kelvin. 
	
	self assert: zeroMeters = zeroPesos.
	self deny:   zeroMeters = zeroCelsius.
	
	self assert: absoluteZero = zeroKelvin.
	self deny:  zeroCelsius = zeroKelvin.
	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/4/2017 19:54:29'!
test03
	
	| tenMeters aMeter |
	
	aMeter _ DistanceUnit meter.
	
	tenMeters _ Measure withAmount: 10 andUnit: aMeter.
	
	self assert: tenMeters = (10 * aMeter).
	self assert: tenMeters = (aMeter * 10).
	
	
	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/4/2017 20:53:45'!
test04
	
	| aMeter aSecond aMeterBySecond aVelocity |
	
	aMeter _ DistanceUnit meter.
	aSecond _ TimeUnit second.
	
	aMeterBySecond _ aMeter / aSecond.
	
	aVelocity _ Measure withAmount: 10 andUnit: aMeterBySecond.
	
	self assert: aVelocity amount = 10.
	self assert: aVelocity unit = aMeterBySecond.
	
	"
	TODO LIST:
	0. Tests
	1 .Ver que hacer con Unit(compound/simple vs unit solo), Evaluar la posiblidad de hacerlo desde Measure (mas simple, sin jerarquias de unit).
	2 .nullValues en msj de creacion de instancia de unit (revisar nombre tmb)
	3 .revisar que metodos son genericos y pasarlos a Measure	
	4. hacer la factory
	5. tirar error al intentar convertir a unidades de otro tipo
	6. 10 pesos + 5 litros
	"! !


!classDefinition: #DistanceFactory category: #'Measure-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:54:25'!
minusOneMeter

	^ConcreteMeasure withAmount: -1 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:54:30'!
oneCentimeter

	^ConcreteMeasure withAmount: 1 andUnit: DistanceUnit centimeter . ! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:54:22'!
oneHundredCentimeters

	^ConcreteMeasure withAmount: 100 andUnit: DistanceUnit centimeter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:54:37'!
oneMeter

	^ConcreteMeasure withAmount: 1 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:54:15'!
twoHundredCentimeters

	^ConcreteMeasure withAmount: 200 andUnit: DistanceUnit centimeter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:54:40'!
twoMeters

	^ConcreteMeasure withAmount: 2 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:54:07'!
zeroMeters

	^ConcreteMeasure withAmount: 0 andUnit: DistanceUnit meter.! !


!classDefinition: #SimpleUnit category: #'Measure-Solution'!
Object subclass: #SimpleUnit
	instanceVariableNames: 'ratio name nullValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!SimpleUnit methodsFor: 'comparing' stamp: 'F C 6/4/2017 16:53:19'!
= anUnit

	^self ratio = anUnit ratio.! !

!SimpleUnit methodsFor: 'comparing' stamp: 'F C 6/4/2017 16:53:39'!
hash

	^ratio hash.! !

!SimpleUnit methodsFor: 'comparing' stamp: 'F C 6/4/2017 16:55:02'!
min: anUnit

	"Returns the unit with the smaller ratio".
	
	(self ratio < anUnit ratio) ifTrue: [^self] 
								ifFalse: [^anUnit].! !


!SimpleUnit methodsFor: 'initialization' stamp: 'E P 6/4/2017 18:43:21'!
initializeWithRatio: aRatio name: aName andNullValue: aNullValue

	ratio _ aRatio.
	name _ aName.
	nullValue _ aNullValue.! !


!SimpleUnit methodsFor: 'printing' stamp: 'E P 6/4/2017 18:16:44'!
nullValue

	^nullValue.! !

!SimpleUnit methodsFor: 'printing' stamp: 'F C 6/4/2017 16:55:21'!
printString

	^name.! !


!SimpleUnit methodsFor: 'accessing' stamp: 'F C 6/4/2017 16:55:49'!
ratio

	^ ratio.! !


!SimpleUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/4/2017 19:43:46'!
* aNumber

	^Measure withAmount: aNumber andUnit: self.! !

!SimpleUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/4/2017 19:45:54'!
adaptToNumber: aNumber andSend: aSymbol 

	^self * aNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimpleUnit class' category: #'Measure-Solution'!
SimpleUnit class
	instanceVariableNames: ''!

!SimpleUnit class methodsFor: 'instance creation' stamp: 'F C 6/4/2017 16:57:33'!
baseUnit

	self subclassResponsibility.! !


!classDefinition: #CurrencyUnit category: #'Measure-Solution'!
SimpleUnit subclass: #CurrencyUnit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CurrencyUnit methodsFor: 'initialization' stamp: 'E P 6/4/2017 18:21:17'!
initializeWithRatio: aRatio andName: aName

	nullValue _ 0.
	ratio _ aRatio.
	name _ aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CurrencyUnit class' category: #'Measure-Solution'!
CurrencyUnit class
	instanceVariableNames: ''!

!CurrencyUnit class methodsFor: 'instance creation' stamp: 'F C 6/4/2017 17:11:00'!
baseUnit
	
	^self peso.! !

!CurrencyUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:36:08'!
dollar
	
	^self new initializeWithRatio: 16 name: 'dollar' andNullValue: 0.! !

!CurrencyUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:36:17'!
peso
	
	^self new initializeWithRatio: 1 name: 'peso argentino' andNullValue: 0.! !


!classDefinition: #DistanceUnit category: #'Measure-Solution'!
SimpleUnit subclass: #DistanceUnit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceUnit class' category: #'Measure-Solution'!
DistanceUnit class
	instanceVariableNames: ''!

!DistanceUnit class methodsFor: 'instance creation' stamp: 'F C 6/4/2017 16:46:58'!
baseUnit

	^self meter.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:36:25'!
centimeter
	
	^self new initializeWithRatio: (1/100) name: 'centimeter' andNullValue: 0.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:36:31'!
decameter
	
	^self new initializeWithRatio: 10 name: 'decameter' andNullValue: 0.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:36:37'!
decimeter
	
	^self new initializeWithRatio: (1/10) name: 'decimeter' andNullValue: 0.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:36:47'!
hectometer
	
	^self new initializeWithRatio: 100 name: 'hectometer' andNullValue: 0.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:36:55'!
kilometer
	
	^self new initializeWithRatio: 1000 name: 'kilometer' andNullValue: 0.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:37:00'!
meter
	
	^self new initializeWithRatio: 1 name: 'meter' andNullValue: 0.! !

!DistanceUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:37:09'!
millimeter
	
	^self new initializeWithRatio: (1/1000) name: 'millimeter' andNullValue: 0.! !


!classDefinition: #TemperatureUnit category: #'Measure-Solution'!
SimpleUnit subclass: #TemperatureUnit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TemperatureUnit class' category: #'Measure-Solution'!
TemperatureUnit class
	instanceVariableNames: ''!

!TemperatureUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 17:50:00'!
baseUnit

	^self celsius.! !

!TemperatureUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:37:22'!
celsius
	
	^self new initializeWithRatio: 1 name: 'celsius' andNullValue: -273.! !

!TemperatureUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 19:42:33'!
fahrenheit
	
	^self new initializeWithRatio: 32 name: 'kelvin' andNullValue: -460.! !

!TemperatureUnit class methodsFor: 'instance creation' stamp: 'E P 6/4/2017 18:37:33'!
kelvin
	
	^self new initializeWithRatio: 274 name: 'kelvin' andNullValue: 0.! !


!classDefinition: #TimeUnit category: #'Measure-Solution'!
SimpleUnit subclass: #TimeUnit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TimeUnit class' category: #'Measure-Solution'!
TimeUnit class
	instanceVariableNames: ''!

!TimeUnit class methodsFor: 'as yet unclassified' stamp: 'E P 6/4/2017 20:28:26'!
day

	^ self new initializeWithRatio: 86400 name: 'day' andNullValue: 0.! !

!TimeUnit class methodsFor: 'as yet unclassified' stamp: 'E P 6/4/2017 20:27:23'!
hour

	^ self new initializeWithRatio: 3600 name: 'hour' andNullValue: 0.! !

!TimeUnit class methodsFor: 'as yet unclassified' stamp: 'E P 6/4/2017 20:29:39'!
millisecond

	^ self new initializeWithRatio: (1 / 1000) name: 'millisecond' andNullValue: 0.! !

!TimeUnit class methodsFor: 'as yet unclassified' stamp: 'E P 6/4/2017 20:26:48'!
minute

	^ self new initializeWithRatio: 60 name: 'minute' andNullValue: 0.! !

!TimeUnit class methodsFor: 'as yet unclassified' stamp: 'E P 6/4/2017 20:26:21'!
second

	^ self new initializeWithRatio: 1 name: 'second' andNullValue: 0.! !
