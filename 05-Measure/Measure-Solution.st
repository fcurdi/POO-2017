!classDefinition: #CompoundUnit category: #'Measure-Solution'!
Unit subclass: #CompoundUnit
	instanceVariableNames: 'multiplyingUnits dividingUnits'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundUnit methodsFor: 'initialization' stamp: 'E P 6/7/2017 20:14:04'!
initializeWithMultiplyingUnits: multiplyingBag andDividingUnits: dividingBag

	multiplyingUnits _ multiplyingBag.
	dividingUnits _ dividingBag.

! !


!CompoundUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/7/2017 20:15:01'!
* anObject

	^anObject multiplyByCompoundUnit: self.


	! !

!CompoundUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/7/2017 23:58:56'!
/ anObject

	^anObject dividingCompoundUnit: self.


	! !

!CompoundUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 01:01:19'!
dividedBySimpleUnit: aSimpleUnit

	|  multiplying dividing |
	
	multiplying _ multiplyingUnits copy.
	dividing _ dividingUnits copy.
	dividing add: aSimpleUnit.
	
	^CompoundUnit withMultiplyingUnits: multiplying andDividingUnits: dividing.

	! !

!CompoundUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 00:51:22'!
dividingCompoundUnit: aCompoundUnit

	|  multiplying dividing |
	
	multiplying _ Bag new.
	dividing _ Bag new.
	
	multiplyingUnits contents keysAndValuesDo: [ :anUnit :timesOfRepetition |
		dividing add: anUnit withOccurrences: (timesOfRepetition + (aCompoundUnit exponentFor: anUnit)).
	].
	
	dividingUnits contents keysAndValuesDo: [ :anUnit :timesOfRepetition |
		multiplying add: anUnit withOccurrences: (timesOfRepetition + (aCompoundUnit exponentFor: anUnit)).
	].
	
	^CompoundUnit withMultiplyingUnits: multiplying andDividingUnits: dividing.

	! !

!CompoundUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 01:01:05'!
dividingSimpleUnit: aSimpleUnit

	|  multiplying dividing |
	
	multiplying _ dividingUnits copy.
	multiplying add: aSimpleUnit.
	
	dividing _ multiplyingUnits copy.
	
	^CompoundUnit withMultiplyingUnits: multiplying andDividingUnits: dividing.

	! !

!CompoundUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/7/2017 20:19:22'!
exponentFor: aSimpleUnit

	^ (multiplyingUnits occurrencesOf: aSimpleUnit) - (dividingUnits occurrencesOf: aSimpleUnit).



	! !

!CompoundUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 00:40:53'!
multiplyByCompoundUnit: aCompoundUnit

	|  multiplying dividing |
	
	multiplying _ Bag new.
	dividing _ Bag new.
	
	multiplyingUnits contents keysAndValuesDo: [ :anUnit :timesOfRepetition |
		multiplying add: anUnit withOccurrences: (timesOfRepetition + aCompoundUnit exponentFor: anUnit).
	].
	
	dividingUnits contents keysAndValuesDo: [ :anUnit :timesOfRepetition |
		multiplying add: anUnit withOccurrences: (timesOfRepetition + aCompoundUnit exponentFor: anUnit).
	].
	
	^CompoundUnit withMultiplyingUnits: multiplying andDividingUnits: dividing.

	! !

!CompoundUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 01:01:35'!
multiplyBySimpleUnit: aSimpleUnit 
	
	|  multiplying dividing |
	
	multiplying _ multiplyingUnits copy.
	multiplying add: aSimpleUnit.
	dividing _ dividingUnits copy.
	
	^CompoundUnit withMultiplyingUnits: multiplying andDividingUnits: dividing.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundUnit class' category: #'Measure-Solution'!
CompoundUnit class
	instanceVariableNames: ''!

!CompoundUnit class methodsFor: 'instance creation' stamp: 'E P 6/8/2017 00:13:08'!
withMultiplyingUnits: multiplyingUnits andDividingUnits: dividingUnits

	^self new initializeWithMultiplyingUnits: multiplyingUnits andDividingUnits: dividingUnits! !


!classDefinition: #SimpleUnit category: #'Measure-Solution'!
Unit subclass: #SimpleUnit
	instanceVariableNames: 'ratio name nullValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!SimpleUnit methodsFor: 'comparing' stamp: 'E P 6/7/2017 21:18:47'!
= anUnit

	^ ( anUnit isKindOf: self class ) and: [self ratio = anUnit ratio].! !

!SimpleUnit methodsFor: 'comparing' stamp: 'E P 6/7/2017 21:10:31'!
hash

	^ratio hash + self class name hash.! !

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


!SimpleUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 00:17:12'!
* anObject

	^anObject multiplyBySimpleUnit: self.
	! !

!SimpleUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 00:17:34'!
/ anObject 
	
	^anObject dividingSimpleUnit: self.! !

!SimpleUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/7/2017 19:16:53'!
adaptToNumber: aNumber andSend: aSymbol 

	^Measure withAmount: aNumber andUnit: self.! !

!SimpleUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 00:49:14'!
dividingCompoundUnit: aCompoundUnit

	^aCompoundUnit dividedBySimpleUnit: self.
	! !

!SimpleUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 00:17:23'!
dividingSimpleUnit: anUnit

	| dividingUnits multiplyingUnits |
	
	multiplyingUnits _ Bag new.
	multiplyingUnits add: anUnit.
	
	dividingUnits _ Bag new.
	dividingUnits add: self.
	
	^CompoundUnit withMultiplyingUnits: multiplyingUnits andDividingUnits: dividingUnits.
	! !

!SimpleUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 00:42:45'!
multiplyByCompoundUnit: aCompoundUnit
	
	^aCompoundUnit multiplyBySimpleUnit: self.! !

!SimpleUnit methodsFor: 'arithmetic operations' stamp: 'E P 6/8/2017 00:17:05'!
multiplyBySimpleUnit: anUnit

	| dividingUnits multiplyingUnits |
	
	multiplyingUnits _ Bag new.
	multiplyingUnits add: self.
	multiplyingUnits add: anUnit.
	
	dividingUnits _ Bag new.
	
	^CompoundUnit withMultiplyingUnits: multiplyingUnits andDividingUnits: dividingUnits.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimpleUnit class' category: #'Measure-Solution'!
SimpleUnit class
	instanceVariableNames: ''!

!SimpleUnit class methodsFor: 'instance creation' stamp: 'F C 6/4/2017 16:57:33'!
baseUnit

	self subclassResponsibility.! !


!classDefinition: #ArgentinianCurrencyUnit category: #'Measure-Solution'!
SimpleUnit subclass: #ArgentinianCurrencyUnit
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


!classDefinition: #EuropeanCurrencyUnit category: #'Measure-Solution'!
SimpleUnit subclass: #EuropeanCurrencyUnit
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

!TimeUnit class methodsFor: 'as yet unclassified' stamp: 'F C 6/7/2017 00:26:02'!
baseUnit

	^self second.! !

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
SimpleUnit subclass: #USCurrencyUnit
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


!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:35:59'!
* aNumber

	^Measure withAmount: amount * aNumber andUnit: unit.! !

!Measure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:31:07'!
+ aMeasure

	self subclassResponsibility.! !

!Measure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:36:49'!
- aMeasure 

	^self + aMeasure negated.! !

!Measure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:46:32'!
/ aNumber

	self subclassResponsibility.! !

!Measure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:19:45'!
adaptToNumber: aNumber andSend: aSymbol 

	^self * aNumber.! !

!Measure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:54:41'!
addCompoundMeasure: aCompoundMeasure 
	
	self subclassResponsibility.! !

!Measure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:39:58'!
addConcreteMeasure: aConcreteMeasure

	self subclassResponsibility.! !

!Measure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:21:09'!
negated

	self subclassResponsibility.! !

!Measure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:55:43'!
substractCompoundMeasure: aCompoundMeasure 

	self subclassResponsibility.! !


!Measure methodsFor: 'comparing' stamp: 'F C 6/8/2017 00:14:34'!
< aMeasure 

	^self amountInBaseUnit < aMeasure amountInBaseUnit.! !

!Measure methodsFor: 'comparing' stamp: 'F C 6/8/2017 00:24:11'!
= anObject

	self subclassResponsibility.! !

!Measure methodsFor: 'comparing' stamp: 'F C 6/8/2017 00:15:15'!
hash

	^self amountInBaseUnit hash.! !


!Measure methodsFor: 'accessing' stamp: 'F C 6/8/2017 00:18:26'!
amount

	^amount.! !

!Measure methodsFor: 'accessing' stamp: 'F C 6/8/2017 00:30:10'!
amountInBaseUnit

	^(self convertTo: unit class baseUnit) amount.! !

!Measure methodsFor: 'accessing' stamp: 'F C 6/8/2017 00:18:32'!
unit

	^unit.! !


!Measure methodsFor: 'intervals' stamp: 'F C 6/8/2017 00:22:38'!
to: aMeasure

	| measureIncrement |
	
	measureIncrement _ self class withAmount: 1 andUnit: unit.
	^self to: aMeasure by: measureIncrement.! !

!Measure methodsFor: 'intervals' stamp: 'F C 6/8/2017 00:22:49'!
to: aMeasure by: aMeasureIncrement 
	
	^MeasureInterval withStart: self stop: aMeasure andStep: aMeasureIncrement.! !

!Measure methodsFor: 'intervals' stamp: 'F C 6/8/2017 00:23:00'!
to: aMeasure by: aMeasureIncrement do: aBlockClosure 

	(self to: aMeasure by: aMeasureIncrement) do: aBlockClosure.! !


!Measure methodsFor: 'printing' stamp: 'F C 6/8/2017 00:21:50'!
printString

	| measureAsString |
	measureAsString _ amount printString, ' ', unit printString.
	(amount > 1) 
		ifTrue: [ ^measureAsString, 's' ]
		ifFalse: [ ^measureAsString] .! !


!Measure methodsFor: 'converting' stamp: 'F C 6/8/2017 00:24:52'!
convertTo: anUnit

	self subclassResponsibility.! !

!Measure methodsFor: 'converting' stamp: 'F C 6/8/2017 00:26:28'!
convertToBaseUnit 

	^self convertTo: self unit class baseUnit.! !


!Measure methodsFor: 'testing' stamp: 'F C 6/8/2017 00:48:25'!
isNullMeasure

	self subclassResponsibility.! !

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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!ConcreteMeasure methodsFor: 'converting' stamp: 'E P 6/6/2017 19:45:34'!
convertTo: anUnit
	
	(anUnit isKindOf: self unit class) ifFalse: [ self error: Measure convertToUnitOfDifferentTypeErrorDescription ].
	^self class withAmount: ((amount * unit ratio) / anUnit ratio) andUnit: anUnit.! !


!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/5/2017 20:57:24'!
+ aMeasure
	
	^aMeasure addConcreteMeasure: self.
	
! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 16:06:53'!
/ aNumber 

	^self class withAmount: (amount / aNumber) andUnit: unit. ! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/8/2017 00:54:28'!
addCompoundMeasure: aCompoundMeasure 
	
	^aCompoundMeasure addConcreteMeasure: self.! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/6/2017 23:50:16'!
addConcreteMeasure: aConcreteMeasure 
		
	 | addingResultInBaseUnit |	
	
	(aConcreteMeasure unit isKindOf: self unit class) ifTrue: [
		addingResultInBaseUnit _ self amountInBaseUnit + aConcreteMeasure amountInBaseUnit.
		^self class withAmount: (addingResultInBaseUnit / unit ratio) andUnit: unit.
	] ifFalse: [
		^CompoundMeasure with: { self.  aConcreteMeasure. }.
	]! !

!ConcreteMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/4/2017 16:09:04'!
negated
	
	^self class withAmount: amount negated andUnit: unit.! !


!ConcreteMeasure methodsFor: 'comparing' stamp: 'E P 6/4/2017 18:52:43'!
= anObject

	^ (anObject isKindOf: ConcreteMeasure) and:[
			(anObject unit isKindOf: self unit class) and: [ 
				self amountInBaseUnit = anObject amountInBaseUnit
				].
		]
	
	
	! !


!ConcreteMeasure methodsFor: 'testing' stamp: 'E P 6/4/2017 19:37:48'!
isNullMeasure
	
	^false.! !

!ConcreteMeasure methodsFor: 'testing' stamp: 'E P 6/8/2017 01:30:35'!
substractCompoundMeasure: aCompoundMeasure 

	^self negated + aCompoundMeasure.! !


!ConcreteMeasure methodsFor: 'instance creation' stamp: 'F C 6/4/2017 16:22:55'!
initializeWithAmount: anAmount andUnit: anUnit

	amount _ anAmount.
	unit _ anUnit.! !

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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!NullMeasure methodsFor: 'instance creation' stamp: 'F C 6/8/2017 00:29:14'!
initializeWithUnit: anUnit

	unit _ anUnit.
	amount _ anUnit nullValue.! !


!NullMeasure methodsFor: 'comparing' stamp: 'E P 6/4/2017 18:05:49'!
= anObject

	^ (anObject isKindOf: self class). 
	
	
	! !


!NullMeasure methodsFor: 'converting' stamp: 'F C 6/7/2017 00:05:26'!
convertTo: anUnit

	^NullMeasure withUnit: anUnit.! !


!NullMeasure methodsFor: 'arithmetic operation' stamp: 'E P 6/6/2017 21:18:16'!
+ aMeasure 
	
     ^aMeasure.! !

!NullMeasure methodsFor: 'arithmetic operation' stamp: 'F C 6/8/2017 00:39:07'!
/ aMeasure

	self error: 'cannot divide by nothing'.! !

!NullMeasure methodsFor: 'arithmetic operation' stamp: 'F C 6/8/2017 00:55:04'!
addCompoundMeasure: aCompoundMeasure 
	
	^aCompoundMeasure.! !

!NullMeasure methodsFor: 'arithmetic operation' stamp: 'F C 6/6/2017 23:33:04'!
addConcreteMeasure: aConcreteMeasure 

	^aConcreteMeasure.! !


!NullMeasure methodsFor: 'testing' stamp: 'E P 6/4/2017 19:38:22'!
isNullMeasure

	^true.! !

!NullMeasure methodsFor: 'testing' stamp: 'F C 6/8/2017 00:21:25'!
negated

	^self.! !

!NullMeasure methodsFor: 'testing' stamp: 'F C 6/8/2017 00:59:29'!
substractCompoundMeasure: aCompoundMeasure 

	^aCompoundMeasure negated.! !

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

!DistanceTest methodsFor: 'testing' stamp: 'E P 6/8/2017 01:20:50'!
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


!DistanceTest methodsFor: 'setup' stamp: 'E P 6/8/2017 01:21:13'!
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
	instanceVariableNames: 'aMeter aPeso zeroMeters zeroPesos zeroCelsius absoluteZero zeroKelvin peso dollar euro aDollar zeroEuros meter anEuro minusOnePeso minusOneDollar minusOneEuro second squaredMeter cubicMeter squaredMeterDividedByMeter meterDividedBySquaredMeter cubicMeterDividedBySquaredMeter squaredMeterDividedByCubicMeter meterBySecond'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/7/2017 00:49:05'!
TODO
	"
	-La resta esta a medias: En concrete measure en el '-' hay que doubleDispatchear. Y para eso hay que implementar 
		el substractConcreteMeasure en ConcreteMeasure y el substractCompoundMeasure en CompoundMeasure.
	-renombrar la variable de instancia 'container'
	-revisar jerarquias
	- .nullValues en msj de creacion de instancia de unit (revisar nombre tmb)
	- .revisar que metodos son genericos y pasarlos a Measure
	-. hacer la factory
	-. no puede haber kelvins negativos ( 2 K - 3K)	
	-Unidades compuestas: 50 metros/(segundo*segundo)
	-multiplcar y dividir measures con measures  y lo mismo entre measures y unidades
	-nombrar tests y categorias
	"
	! !

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/7/2017 00:29:42'!
test01
	
	self deny: aMeter = aPeso.! !

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/7/2017 00:30:41'!
test02
	
	self assert: zeroMeters = zeroPesos.
	self deny:   zeroMeters = zeroCelsius.
	
	self assert: absoluteZero = zeroKelvin.
	self deny:  zeroCelsius = zeroKelvin.
	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/8/2017 01:24:23'!
test03
	
	| tenMeters  |
	
	tenMeters _ Measure withAmount: 10 andUnit: meter.
	
	self assert: tenMeters = (10 * aMeter).
	self assert: tenMeters = (aMeter * 10).
	
	
	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'F C 6/7/2017 00:32:52'!
test04

	| aCompoundMeasure |
	
	aCompoundMeasure _ aPeso + aDollar.
	
	self assert: (aCompoundMeasure measureFor: peso) = aPeso.
	self assert: (aCompoundMeasure measureFor: dollar) = aDollar .
	self assert: (aCompoundMeasure measureFor: euro) = zeroEuros.
	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/8/2017 01:24:31'!
test05

	|  aPesoAndADollarPlusAnEuro anEuroPlusAPesoAndADollar |
	
	aPesoAndADollarPlusAnEuro _ (aPeso + aDollar) + anEuro.
	anEuroPlusAPesoAndADollar _ anEuro + (aPeso + aDollar).
	
	self assert: (aPesoAndADollarPlusAnEuro isKindOf: CompoundMeasure ).
	self assert: (aPesoAndADollarPlusAnEuro measureFor: euro) = anEuro.
	self assert: (anEuroPlusAPesoAndADollar) = (aPesoAndADollarPlusAnEuro).

	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/8/2017 01:24:36'!
test06

	|  aPesoAndADollarPlusMinusOnePesoAndAnEuro |
	
	aPesoAndADollarPlusMinusOnePesoAndAnEuro _ (aPeso + aDollar) + ( minusOnePeso + anEuro).
	
	self assert: (aPesoAndADollarPlusMinusOnePesoAndAnEuro isKindOf: CompoundMeasure ).
	self assert: (aPesoAndADollarPlusMinusOnePesoAndAnEuro measureFor: euro) = anEuro.	
	self assert: (aPesoAndADollarPlusMinusOnePesoAndAnEuro measureFor: peso) = zeroPesos.		
	self assert: (aPesoAndADollarPlusMinusOnePesoAndAnEuro measureFor: dollar) = aDollar.! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/8/2017 01:24:42'!
test07

	| aPesoAndADollar |

	aPesoAndADollar _ aPeso + aDollar.
	
	self assert: (aPesoAndADollar negated isKindOf: CompoundMeasure ).
	self assert: (aPesoAndADollar negated measureFor: peso) = minusOnePeso.	
	self assert: (aPesoAndADollar negated measureFor: dollar) = minusOneDollar.! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/8/2017 01:24:49'!
test08

	| aPesoAndMinusOneDollar aPesoAndMinusOneDollarMinusAnEuro minusOneEuroPlusAPesoAndMinusOneDollar |
	
	aPesoAndMinusOneDollar _ aPeso - aDollar.
	aPesoAndMinusOneDollarMinusAnEuro _ (aPeso - aDollar) - anEuro.
	minusOneEuroPlusAPesoAndMinusOneDollar _ minusOneEuro + aPesoAndMinusOneDollar.
	
	self assert: (aPesoAndMinusOneDollar isKindOf: CompoundMeasure ).
	self assert: (aPesoAndMinusOneDollar measureFor: peso) = aPeso.	
	self assert: (aPesoAndMinusOneDollar measureFor: dollar) = minusOneDollar.
	
	self assert: (aPesoAndMinusOneDollarMinusAnEuro isKindOf: CompoundMeasure).
	self assert: (aPesoAndMinusOneDollarMinusAnEuro measureFor: peso) = aPeso.
	self assert: (aPesoAndMinusOneDollarMinusAnEuro measureFor: dollar) = minusOneDollar.
	self assert: (aPesoAndMinusOneDollarMinusAnEuro measureFor: euro) = minusOneEuro.
	
	self assert: (aPesoAndMinusOneDollarMinusAnEuro = minusOneEuroPlusAPesoAndMinusOneDollar).
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/8/2017 01:24:57'!
test09
	
	self should: [ aMeter convertTo: TemperatureUnit kelvin ] 
		 raise:  Error - MessageNotUnderstood 
	      withExceptionDo: [ :anError | self assert: anError messageText equals: Measure convertToUnitOfDifferentTypeErrorDescription ].
	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/8/2017 01:25:02'!
test10

	| oneMeter |
	oneMeter _ Measure withAmount: 1 andUnit: DistanceUnit meter.
	
	self assert: (oneMeter + zeroKelvin) = oneMeter. ! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/7/2017 18:55:01'!
test11

	self assert: zeroKelvin * 20 = zeroKelvin.
	self assert: -5 * zeroMeters = zeroMeters.! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/8/2017 00:53:34'!
test12
	
	self assert: (squaredMeter isKindOf: CompoundUnit).
	self assert: (meterBySecond isKindOf: CompoundUnit).
	
	self assert: (squaredMeter exponentFor: meter) = 2.
	
	self assert: (meterBySecond exponentFor: meter) = 1.
	self assert: (meterBySecond exponentFor: second) = -1.
	
	! !

!MeasureTest methodsFor: 'testing' stamp: 'E P 6/7/2017 21:35:20'!
test13
	
	self assert: (squaredMeterDividedByMeter isKindOf: SimpleUnit).
	self assert: squaredMeterDividedByMeter = aMeter.
	
	self assert:  (meterDividedBySquaredMeter isKindOf: CompoundUnit).
	self assert:  (meterDividedBySquaredMeter exponentFor: meter) = 1.
	
	self assert:  (cubicMeterDividedBySquaredMeter isKindOf: SimpleUnit).
	self assert: cubicMeterDividedBySquaredMeter = aMeter.
	
	self assert:  (squaredMeterDividedByCubicMeter isKindOf: CompoundUnit).
	self assert:  (squaredMeterDividedByCubicMeter exponentFor: meter) = 1.
	
	self assert:  (squaredMeterDividedByMeter = cubicMeterDividedBySquaredMeter).
	self assert:  (meterDividedBySquaredMeter = squaredMeterDividedByCubicMeter).
	
	
	! !


!MeasureTest methodsFor: 'setup' stamp: 'E P 6/8/2017 01:24:00'!
setUp

	meter _ DistanceUnit meter.
	peso _ ArgentinianCurrencyUnit peso.
	dollar _ USCurrencyUnit dollar.
	euro _ EuropeanCurrencyUnit euro.
	second _ TimeUnit second.

	aMeter _ Measure withAmount: 1 andUnit: meter.
	aPeso _ Measure withAmount: 1 andUnit: peso.
	aDollar _ Measure withAmount: 1 andUnit: dollar.
	anEuro _ Measure withAmount: 1 andUnit: euro.
	
	zeroMeters _ Measure withAmount: 0 andUnit: DistanceUnit centimeter.
	zeroPesos _ Measure withAmount: 0 andUnit: dollar.
	zeroCelsius _ Measure withAmount: 0 andUnit: TemperatureUnit celsius. 
	absoluteZero _ Measure withAmount: -273 andUnit: TemperatureUnit celsius. 
	zeroKelvin _ Measure withAmount: 0 andUnit: TemperatureUnit kelvin. 
	zeroEuros _ Measure withAmount: 0 andUnit: euro.	
	
	minusOnePeso _ aPeso negated.
	minusOneDollar _ aDollar negated.
	minusOneEuro _ anEuro negated.

	squaredMeter _ meter * meter. 
	cubicMeter _ meter * meter * meter.
	
	squaredMeterDividedByMeter _ squaredMeter / meter.
	meterDividedBySquaredMeter _  meter / squaredMeter. 
	
	cubicMeterDividedBySquaredMeter _ cubicMeter / squaredMeter.
	squaredMeterDividedByCubicMeter _  squaredMeter / cubicMeter.
	
	meterBySecond _ meter / second.

! !


!classDefinition: #CompoundMeasure category: #'Measure-Solution'!
Object subclass: #CompoundMeasure
	instanceVariableNames: 'container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundMeasure methodsFor: 'initialization' stamp: 'F C 6/7/2017 00:16:07'!
initializeWith: aCollectionOfMeasures
		
	container _ Dictionary new.
	aCollectionOfMeasures do: [ :aMeasure |
		container at: aMeasure unit put: aMeasure 
	].
	! !


!CompoundMeasure methodsFor: 'accessing' stamp: 'E P 6/8/2017 01:25:26'!
measureFor: anUnit
	
	| aMeasure |
	aMeasure _ container at: anUnit class baseUnit ifAbsent: [ ^NullMeasure withUnit: anUnit ].
	^aMeasure convertTo: anUnit.
	! !


!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/5/2017 21:44:08'!
+ anObject

	^anObject addCompoundMeasure: self.

	! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/7/2017 00:11:43'!
- anObject

	^anObject substractCompoundMeasure: self. ! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'E P 6/7/2017 18:16:38'!
= anObject

	^(anObject isKindOf: CompoundMeasure)
		and: [ self numberOfDifferentMeasures = anObject numberOfDifferentMeasures.] 
			and: [ container allSatisfy: [ :aMeasure | aMeasure  = (anObject measureFor: aMeasure unit) ]
		 ].

! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/7/2017 00:19:36'!
addCompoundMeasure: aCompoundMeasure 
	
	| previousMeasure measures |

	aCompoundMeasure do: [ :aMeasure |
		previousMeasure _ self measureFor: aMeasure unit.
		container at: aMeasure unit put: (previousMeasure + aMeasure).
	].
	measures _ container select: [ :aMeasure | aMeasure isNullMeasure not].
	
	^CompoundMeasure with: measures.
! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/7/2017 00:01:45'!
addConcreteMeasure: aConcreteMeasure 
	
	| newMeasure |	

	newMeasure _ (self measureFor: aConcreteMeasure unit) + aConcreteMeasure.
	container at: aConcreteMeasure convertToBaseUnit unit put: newMeasure.
	^CompoundMeasure with: (container select: [ :aMeasure | aMeasure isNullMeasure not ])! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/7/2017 00:00:34'!
negated

	^CompoundMeasure with: (container collect: [ :aMeasure | aMeasure negated]).! !

!CompoundMeasure methodsFor: 'arithmetic operations' stamp: 'F C 6/7/2017 00:12:50'!
substractConcreteMeasure: aConcreteMeasure 

	^self + aConcreteMeasure negated.! !


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

!CompoundMeasure class methodsFor: 'instance creation' stamp: 'F C 6/6/2017 23:47:13'!
with: aCollectionOfMeasures
	
	| normalizedMeasures |
	normalizedMeasures _ aCollectionOfMeasures collect: [ :aMeasure | aMeasure convertToBaseUnit ].
	^self new initializeWith: normalizedMeasures.
	
	! !


!classDefinition: #DistanceFactory category: #'Measure-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/8/2017 01:21:50'!
minusOneMeter

	^ConcreteMeasure withAmount: -1 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/8/2017 01:21:54'!
oneCentimeter

	^ConcreteMeasure withAmount: 1 andUnit: DistanceUnit centimeter . ! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/8/2017 01:21:58'!
oneHundredCentimeters

	^ConcreteMeasure withAmount: 100 andUnit: DistanceUnit centimeter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/8/2017 01:22:01'!
oneMeter

	^ConcreteMeasure withAmount: 1 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/8/2017 01:22:04'!
twoHundredCentimeters

	^ConcreteMeasure withAmount: 200 andUnit: DistanceUnit centimeter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/8/2017 01:22:07'!
twoMeters

	^ConcreteMeasure withAmount: 2 andUnit: DistanceUnit meter.! !

!DistanceFactory methodsFor: 'instance creation' stamp: 'E P 6/8/2017 01:22:10'!
zeroMeters

	^ConcreteMeasure withAmount: 0 andUnit: DistanceUnit meter.! !
