!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #AbstractStackElement category: #'Stack-Exercise'!
Object subclass: #AbstractStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!AbstractStackElement methodsFor: 'testing' stamp: 'F C 5/6/2017 23:15:08'!
isEmpty

	self subclassResponsibility.! !

!AbstractStackElement methodsFor: 'testing' stamp: 'F C 5/6/2017 23:14:55'!
size
	
	self subclassResponsibility.! !


!AbstractStackElement methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:15:29'!
underliyingElement

	self subclassResponsibility.! !

!AbstractStackElement methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:15:19'!
value

	self subclassResponsibility.! !


!classDefinition: #NullStackElement category: #'Stack-Exercise'!
AbstractStackElement subclass: #NullStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullStackElement methodsFor: 'testing' stamp: 'F C 5/6/2017 22:37:39'!
isEmpty
	
	^true.! !

!NullStackElement methodsFor: 'testing' stamp: 'F C 5/6/2017 23:07:58'!
size
	
	^0.! !


!NullStackElement methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:11:22'!
underliyingElement

	^self error: (OOStack stackEmptyErrorDescription).

	! !

!NullStackElement methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:10:38'!
value
	
	^self error: (OOStack stackEmptyErrorDescription).! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
AbstractStackElement subclass: #StackElement
	instanceVariableNames: 'value underlyingElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'testing' stamp: 'F C 5/6/2017 22:42:26'!
isEmpty

	^false.! !

!StackElement methodsFor: 'testing' stamp: 'F C 5/6/2017 23:07:48'!
size
	
	^underlyingElement size + 1.! !


!StackElement methodsFor: 'initialization' stamp: 'F C 5/6/2017 22:58:18'!
initializeWith: anElement onTopOf: anotherElement

	value _ anElement.
	underlyingElement _ anotherElement.! !


!StackElement methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:01:23'!
underliyingElement
	
	^underlyingElement.! !

!StackElement methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:00:51'!
value
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackElement class' category: #'Stack-Exercise'!
StackElement class
	instanceVariableNames: ''!

!StackElement class methodsFor: 'as yet unclassified' stamp: 'F C 5/6/2017 22:57:47'!
with: anElement onTopOf: anotherElement
	
	^self new initializeWith: anElement onTopOf: anotherElement.
	! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'F C 5/6/2017 21:39:58'!
isEmpty

	^elements isEmpty.! !

!OOStack methodsFor: 'testing' stamp: 'F C 5/6/2017 21:52:31'!
size

	^elements size.! !


!OOStack methodsFor: 'initialization' stamp: 'F C 5/6/2017 22:11:29'!
initialize

	elements  _ NullStackElement new.! !


!OOStack methodsFor: 'adding' stamp: 'F C 5/6/2017 23:03:09'!
push: anElement
	
	elements _ StackElement with: anElement onTopOf: elements.! !


!OOStack methodsFor: 'removing' stamp: 'F C 5/6/2017 23:02:15'!
pop

	| top |
	
	top _ elements value.
	elements _  elements underliyingElement.
	^top.
	! !


!OOStack methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:05:44'!
top

	^elements value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !
