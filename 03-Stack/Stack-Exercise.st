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


!classDefinition: #AbstractStackeableElement category: #'Stack-Exercise'!
Object subclass: #AbstractStackeableElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!AbstractStackeableElement methodsFor: 'testing' stamp: 'F C 5/6/2017 23:15:08'!
isEmpty

	self subclassResponsibility.! !

!AbstractStackeableElement methodsFor: 'testing' stamp: 'F C 5/6/2017 23:14:55'!
size
	
	self subclassResponsibility.! !


!AbstractStackeableElement methodsFor: 'accessing' stamp: 'E P 5/9/2017 18:44:24'!
base

	self subclassResponsibility.! !

!AbstractStackeableElement methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:15:19'!
value

	self subclassResponsibility.! !


!classDefinition: #EmptyStackeableElement category: #'Stack-Exercise'!
AbstractStackeableElement subclass: #EmptyStackeableElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackeableElement methodsFor: 'testing' stamp: 'F C 5/6/2017 22:37:39'!
isEmpty
	
	^true.! !

!EmptyStackeableElement methodsFor: 'testing' stamp: 'F C 5/6/2017 23:07:58'!
size
	
	^0.! !


!EmptyStackeableElement methodsFor: 'accessing' stamp: 'E P 5/9/2017 18:44:15'!
base

	^self error: (OOStack stackEmptyErrorDescription).

	! !

!EmptyStackeableElement methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:10:38'!
value
	
	^self error: (OOStack stackEmptyErrorDescription).! !


!classDefinition: #StackeableElement category: #'Stack-Exercise'!
AbstractStackeableElement subclass: #StackeableElement
	instanceVariableNames: 'value base'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackeableElement methodsFor: 'testing' stamp: 'F C 5/6/2017 22:42:26'!
isEmpty

	^false.! !

!StackeableElement methodsFor: 'testing' stamp: 'E P 5/9/2017 18:42:57'!
size
	
	^base size + 1.! !


!StackeableElement methodsFor: 'initialization' stamp: 'E P 5/9/2017 18:50:01'!
initializeWith: anElement onTopOf: aStackeableElement

	value _ anElement.
	base _ aStackeableElement.! !


!StackeableElement methodsFor: 'accessing' stamp: 'E P 5/9/2017 18:43:46'!
base
	
	^base.! !

!StackeableElement methodsFor: 'accessing' stamp: 'F C 5/6/2017 23:00:51'!
value
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackeableElement class' category: #'Stack-Exercise'!
StackeableElement class
	instanceVariableNames: ''!

!StackeableElement class methodsFor: 'instance creation' stamp: 'E P 5/9/2017 18:46:20'!
with: anElement onTopOf: aStackElement
	
	^self new initializeWith: anElement onTopOf: aStackElement.
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


!OOStack methodsFor: 'initialization' stamp: 'E P 5/9/2017 18:49:06'!
initialize

	elements  _ EmptyStackeableElement new.! !


!OOStack methodsFor: 'adding' stamp: 'E P 5/9/2017 18:48:41'!
push: anElement
	
	elements _ StackeableElement with: anElement onTopOf: elements.! !


!OOStack methodsFor: 'removing' stamp: 'E P 5/9/2017 18:43:57'!
pop

	| top |
	
	top _ elements value.
	elements _  elements base.
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
