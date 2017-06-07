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


!Measure class methodsFor: 'error descriptions' stamp: 'E P 6/6/2017 19:42:35'!
convertToUnitOfDifferentTypeErrorDescription

 	^'Cannot convert measure to unit of different type'.! !


!classDefinition: #ConcreteMeasure category: #'Measure-Solution'!
Measure subclass: #ConcreteMeasure
	instanceVariableNames: 'unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!ConcreteMeasure methodsFor: 'converting' stamp: 'F C 6/4/2017 16:49:16'!
amountInBaseUnit

	^(self convertTo: unit class baseUnit) amount.! !

!ConcreteMeasure methodsFor: 'converting' stamp: 'E P 6/6/2017 19:45:34'!
convertTo: anUnit
	
	(anUnit isKindOf: self unit class) ifFalse: [ self error: Measure convertToUnitOfDifferentTypeErrorDescription ].
	^self class withAmount: ((amount * unit ratio) / anUnit ratio) andUnit: anUnit.! !

!ConcreteMeasure methodsFor: 'converting' stamp: 'E P 6/6/2017 20:27:40'!
convertToBaseUnit 

	^self convertTo: self unit class baseUnit.! !


!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 15:55:22'!
* aNumber

	^self class withAmount: amount * aNumber andUnit: unit.
	
	! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/5/2017 20:57:24'!
+ aMeasure
	
	^aMeasure addConcreteMeasure: self.
	
! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/5/2017 22:37:56'!
- aMeasure 

	^self + aMeasure negated.! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 16:06:53'!
/ aNumber 

	^self class withAmount: (amount / aNumber) andUnit: unit. ! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/5/2017 21:48:57'!
addCompoundMeasure: aCompoundMeasure 
	
	^aCompoundMeasure addConcreteMeasure: self.! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/5/2017 20:56:30'!
addConcreteMeasure: aConcreteMeasure 
		
	 | addingResultInBaseUnit |	
	
	(aConcreteMeasure unit isKindOf: self unit class) ifTrue: [
		addingResultInBaseUnit _ self amountInBaseUnit + aConcreteMeasure amountInBaseUnit.
		^self class withAmount: (addingResultInBaseUnit / unit ratio) andUnit: unit.
	] ifFalse: [
		^CompoundMeasure with: self with: aConcreteMeasure.
	]! !

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


!NullMeasure methodsFor: 'arithmetic operation' stamp: 'E P 6/6/2017 21:18:16'!
+ aMeasure 
	
     ^aMeasure.! !

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

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/5/2017 22:22:01'!
atest04
	
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
	7. no puede haber kelvins negativos ( 2 K - 3K)	"! !

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/5/2017 20:36:35'!
test01

	| aMeter aPeso |
	
	aMeter _ ConcreteMeasure withAmount: 1 andUnit: DistanceUnit meter.
	aPeso _ ConcreteMeasure withAmount: 1 andUnit: ArgentinianCurrencyUnit peso.
	
	self deny: aMeter = aPeso.! !

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/5/2017 20:36:29'!
test02

	|  absoluteZero zeroCelsius zeroKelvin zeroMeters zeroPesos |
	
	zeroMeters _ Measure withAmount: 0 andUnit: DistanceUnit centimeter.
	zeroPesos _ Measure withAmount: 0 andUnit: USCurrencyUnit dollar.
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

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/6/2017 21:13:13'!
test04

	| peso dollar aDollar aPeso aCompoundMeasure euro zeroEuros |
	
	peso _ ArgentinianCurrencyUnit peso.
	dollar _ USCurrencyUnit dollar.
	euro _ EuropeanCurrencyUnit euro.
	aDollar _ Measure withAmount: 1 andUnit: dollar.
	aPeso _ Measure withAmount: 1 andUnit: peso.
	zeroEuros _ Measure withAmount: 0 andUnit: euro.
	aCompoundMeasure _ aPeso + aDollar.
	
	self assert: (aCompoundMeasure measureFor: peso) = aPeso.
	self assert: (aCompoundMeasure measureFor: dollar) = aDollar .
	self assert: (aCompoundMeasure measureFor: euro) = zeroEuros.
	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/6/2017 21:19:03'!
test05

	| peso dollar aDollar aPeso  anEuro euro |
	
	peso _ ArgentinianCurrencyUnit peso.
	dollar _ USCurrencyUnit dollar.
	euro _ EuropeanCurrencyUnit euro.
	aDollar _ Measure withAmount: 1 andUnit: dollar.
	aPeso _ Measure withAmount: 1 andUnit: peso.
	anEuro _ Measure withAmount: 1 andUnit: euro.
	
	self assert: ((aPeso + aDollar) + anEuro isKindOf: CompoundMeasure).
	self assert: ((aPeso + aDollar) + anEuro measureFor: euro) = anEuro.
	self assert: ((anEuro + (aPeso + aDollar)) = ((aPeso + aDollar) + anEuro)).

	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/6/2017 21:19:55'!
test06

	| peso dollar aDollar aPeso  anEuro euro minusOnePeso zeroPeso |
	
	peso _ ArgentinianCurrencyUnit peso.
	dollar _ USCurrencyUnit dollar.
	euro _ EuropeanCurrencyUnit euro.
	aDollar _ Measure withAmount: 1 andUnit: dollar.
	aPeso _ Measure withAmount: 1 andUnit: peso.
	zeroPeso _ Measure withAmount: 0 andUnit: peso.
	minusOnePeso _ aPeso negated.
	anEuro _ Measure withAmount: 1 andUnit: euro.
	
	self assert: ((aPeso + aDollar) + (minusOnePeso + anEuro) isKindOf: CompoundMeasure).
	self assert: ((aPeso + aDollar) + (minusOnePeso + anEuro) measureFor: euro) = anEuro.	
	self assert: ((aPeso + aDollar) + (minusOnePeso + anEuro) measureFor: peso) = zeroPeso.		
	self assert: ((aPeso + aDollar) + (minusOnePeso + anEuro) measureFor: dollar) = aDollar.	! !

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/5/2017 22:44:49'!
test07

	| peso dollar aDollar aPeso  |
	
	peso _ ArgentinianCurrencyUnit peso.
	dollar _ USCurrencyUnit dollar.
	aDollar _ Measure withAmount: 1 andUnit: dollar.
	aPeso _ Measure withAmount: 1 andUnit: peso.

	self assert: ((aPeso + aDollar) negated isKindOf: CompoundMeasure).
	self assert: ((aPeso + aDollar) negated amountFor: peso) = -1.	
	self assert: ((aPeso + aDollar) negated amountFor: dollar) = -1.! !

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/5/2017 22:55:59'!
test08

	| peso dollar aDollar aPeso  anEuro euro |
	
	peso _ ArgentinianCurrencyUnit peso.
	dollar _ USCurrencyUnit dollar.
	euro _ EuropeanCurrencyUnit euro.
	aDollar _ Measure withAmount: 1 andUnit: dollar.
	aPeso _ Measure withAmount: 1 andUnit: peso.
	anEuro _ Measure withAmount: 1 andUnit: euro.

	self assert: ((aPeso - aDollar) isKindOf: CompoundMeasure).
	self assert: ((aPeso - aDollar) amountFor: peso) = 1.	
	self assert: ((aPeso - aDollar) amountFor: dollar) = -1.
	
	self assert: (((aPeso - aDollar) - anEuro) isKindOf: CompoundMeasure).
	self assert: (((aPeso - aDollar) - anEuro) amountFor: peso) = 1.
	self assert: (((aPeso - aDollar) - anEuro) amountFor: aDollar) = -1.
	self assert: (((aPeso - aDollar) - anEuro) amountFor: anEuro) = -1.
	
	self assert: ((aPeso - aDollar) - anEuro) = (anEuro negated + (aPeso - aDollar)).
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/6/2017 19:34:54'!
test09

	| aMeter kelvin |
	aMeter _ Measure withAmount: 1 andUnit: DistanceUnit meter.
	kelvin _ TemperatureUnit kelvin.
	
	self should: [ aMeter convertTo: kelvin ] 
		 raise:  Error - MessageNotUnderstood 
	      withExceptionDo: [ :anError | self assert: anError messageText equals: Measure convertToUnitOfDifferentTypeErrorDescription ].
	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/6/2017 21:10:24'!
test10

	| oneMeter zeroKelvin |
	oneMeter _ Measure withAmount: 1 andUnit: DistanceUnit meter.
	zeroKelvin _ Measure withAmount: 0 andUnit: TemperatureUnit kelvin.
	
	self assert: (oneMeter + zeroKelvin) = oneMeter. ! !


!classDefinition: #CompoundMeasure category: #'Measure-Solution'!
Object subclass: #CompoundMeasure
	instanceVariableNames: 'container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundMeasure methodsFor: 'initialization' stamp: 'E P 6/6/2017 20:48:58'!
initializeWith: aConcreteMeasure with: anotherConcreteMeasure
	
	container _ Dictionary new.
	container at: aConcreteMeasure unit put: aConcreteMeasure.
	container at: anotherConcreteMeasure unit put: anotherConcreteMeasure.
	! !


!CompoundMeasure methodsFor: 'accessing' stamp: 'E P 6/6/2017 20:52:31'!
measureFor: anUnit
	
	| aMeasure |
	aMeasure _ container at: anUnit class baseUnit 
		ifAbsent: [ ^NullMeasure withUnit: anUnit ].
	^aMeasure convertTo: anUnit.
	! !


!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/5/2017 21:44:08'!
+ anObject

	^anObject addCompoundMeasure: self.

	! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'E P 6/6/2017 20:08:45'!
= anObject

	(anObject isKindOf: CompoundMeasure) and: [
			(container allSatisfy: [ :anAssociation |
					 (self amount = (anObject amountFor: self unit))])
				 
				and: [ self numberOfDifferentMeasures = anObject numberOfDifferentMeasures.]
		]

	! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/5/2017 22:29:09'!
addCompoundMeasure: aCompoundMeasure 

	aCompoundMeasure do: [ :aMeasure |
		self + aMeasure.
	].! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'E P 6/6/2017 21:14:55'!
addConcreteMeasure: aConcreteMeasure 
	
	| newMeasure |
	
	newMeasure _ (self measureFor: aConcreteMeasure unit) + aConcreteMeasure.
	
	(newMeasure isNullMeasure ) ifFalse: [
		container at: aConcreteMeasure convertToBaseUnit unit put: newMeasure
	].! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'E P 6/6/2017 20:53:17'!
negated

	self do: [ :aMeasure |
		container at: aMeasure unit put: aMeasure negated.
	].! !


!CompoundMeasure methodsFor: 'enumeration' stamp: 'E P 6/6/2017 20:54:48'!
do: aBlockClosure 

	container valuesDo: [ :value | aBlockClosure value: value ].! !


!CompoundMeasure methodsFor: 'testing' stamp: 'F C 6/5/2017 23:04:18'!
numberOfDifferentMeasures

	^container size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundMeasure class' category: #'Measure-Solution'!
CompoundMeasure class
	instanceVariableNames: ''!

!CompoundMeasure class methodsFor: 'instance creation' stamp: 'E P 6/6/2017 20:18:17'!
with: aConcreteMeasure with: anotherConcreteMeasure 
	
	^self new initializeWith: aConcreteMeasure convertToBaseUnit 
						with: anotherConcreteMeasure convertToBaseUnit 
	
	! !


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


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'ratio name nullValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'comparing' stamp: 'F C 6/4/2017 16:53:19'!
= anUnit

	^self ratio = anUnit ratio.! !

!Unit methodsFor: 'comparing' stamp: 'F C 6/5/2017 21:35:44'!
hash

	"Mejorar la forma de hashear"
	^ratio hash + self class name hash.! !

!Unit methodsFor: 'comparing' stamp: 'F C 6/4/2017 16:55:02'!
min: anUnit

	"Returns the unit with the smaller ratio".
	
	(self ratio < anUnit ratio) ifTrue: [^self] 
								ifFalse: [^anUnit].! !


!Unit methodsFor: 'initialization' stamp: 'E P 6/4/2017 18:43:21'!
initializeWithRatio: aRatio name: aName andNullValue: aNullValue

	ratio _ aRatio.
	name _ aName.
	nullValue _ aNullValue.! !


!Unit methodsFor: 'printing' stamp: 'E P 6/4/2017 18:16:44'!
nullValue

	^nullValue.! !

!Unit methodsFor: 'printing' stamp: 'F C 6/4/2017 16:55:21'!
printString

	^name.! !


!Unit methodsFor: 'accessing' stamp: 'F C 6/4/2017 16:55:49'!
ratio

	^ ratio.! !


!Unit methodsFor: 'arithmetic operations' stamp: 'E P 6/4/2017 19:43:46'!
* aNumber

	^Measure withAmount: aNumber andUnit: self.! !

!Unit methodsFor: 'arithmetic operations' stamp: 'E P 6/4/2017 19:45:54'!
adaptToNumber: aNumber andSend: aSymbol 

	^self * aNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'instance creation' stamp: 'F C 6/4/2017 16:57:33'!
baseUnit

	self subclassResponsibility.! !


!classDefinition: #ArgentinianCurrencyUnit category: #'Measure-Solution'!
Unit subclass: #ArgentinianCurrencyUnit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ArgentinianCurrencyUnit class' category: #'Measure-Solution'!
ArgentinianCurrencyUnit class
	instanceVariableNames: ''!

!ArgentinianCurrencyUnit class methodsFor: 'instance creation' stamp: 'F C 6/5/2017 20:35:01'!
baseUnit

	^self peso.! !

!ArgentinianCurrencyUnit class methodsFor: 'instance creation' stamp: 'F C 6/5/2017 20:28:46'!
peso
	
	^self new initializeWithRatio: 1 name: 'peso argentino' andNullValue: 0.! !


!classDefinition: #DistanceUnit category: #'Measure-Solution'!
Unit subclass: #DistanceUnit
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


!classDefinition: #EuropeanCurrencyUnit category: #'Measure-Solution'!
Unit subclass: #EuropeanCurrencyUnit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EuropeanCurrencyUnit class' category: #'Measure-Solution'!
EuropeanCurrencyUnit class
	instanceVariableNames: ''!

!EuropeanCurrencyUnit class methodsFor: 'instance creation' stamp: 'F C 6/5/2017 20:35:13'!
baseUnit

	^self euro.! !

!EuropeanCurrencyUnit class methodsFor: 'instance creation' stamp: 'F C 6/5/2017 20:33:21'!
euro

	^self new initializeWithRatio: 1 name: 'euro' andNullValue: 0.! !


!classDefinition: #TemperatureUnit category: #'Measure-Solution'!
Unit subclass: #TemperatureUnit
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
Unit subclass: #TimeUnit
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


!classDefinition: #USCurrencyUnit category: #'Measure-Solution'!
Unit subclass: #USCurrencyUnit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'USCurrencyUnit class' category: #'Measure-Solution'!
USCurrencyUnit class
	instanceVariableNames: ''!

!USCurrencyUnit class methodsFor: 'instance creation' stamp: 'F C 6/5/2017 20:35:21'!
baseUnit

	^self dollar.! !

!USCurrencyUnit class methodsFor: 'instance creation' stamp: 'F C 6/5/2017 20:29:41'!
dollar
	
	^self new initializeWithRatio: 16 name: 'dollar' andNullValue: 0.! !
