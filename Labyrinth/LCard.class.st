Class {
	#name : #LCard,
	#superclass : #Object,
	#instVars : [
		'item',
		'cardElement'
	],
	#category : #'Labyrinth-Model'
}

{ #category : #accessing }
LCard class >> item: aLItem [ 

	^ self new item: aLItem 
]

{ #category : #accessing }
LCard >> cardElement [ 

	^ cardElement
]

{ #category : #accessing }
LCard >> cardElement: aLCardElement [

	cardElement := aLCardElement 
]

{ #category : #actions }
LCard >> disappear [ 

	self cardElement disappear.
]

{ #category : #accessing }
LCard >> item [ 

	^ item
]

{ #category : #accessing }
LCard >> item: anItem [ 

	item := anItem 
]
