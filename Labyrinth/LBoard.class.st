Class {
	#name : #LBoard,
	#superclass : #MygBoard,
	#instVars : [
		'extraTile',
		'cards'
	],
	#category : #'Labyrinth-Model'
}

{ #category : #accessing }
LBoard >> cards [ 

	^ cards
]

{ #category : #accessing }
LBoard >> cards: aCollection [ 

	cards := aCollection 
]

{ #category : #accessing }
LBoard >> extraTile [ 

	^ extraTile 
]

{ #category : #accessing }
LBoard >> extraTile: aLTile [ 

	extraTile := aLTile 
]
