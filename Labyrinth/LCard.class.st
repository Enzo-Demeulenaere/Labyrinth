Class {
	#name : #LCard,
	#superclass : #Object,
	#instVars : [
		'item'
	],
	#category : #'Labyrinth-Model'
}

{ #category : #accessing }
LCard >> item [ 

	^ item
]

{ #category : #accessing }
LCard >> item: anItem [ 

	item := anItem 
]
