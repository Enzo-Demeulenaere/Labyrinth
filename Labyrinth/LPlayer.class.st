Class {
	#name : #LPlayer,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'Labyrinth-Model'
}

{ #category : #accessing }
LPlayer >> cards [ 

	^ cards 
]

{ #category : #accessing }
LPlayer >> cards: aCollection [ 

	cards := aCollection 
]
