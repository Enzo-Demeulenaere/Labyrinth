Class {
	#name : #LTile,
	#superclass : #MygAbstractBox,
	#instVars : [
		'item',
		'players',
		'directions'
	],
	#category : #'Labyrinth-Model'
}

{ #category : #accessing }
LTile >> directions [ 

	^ directions 
]

{ #category : #accessing }
LTile >> directions: aCollection [ 

	directions := aCollection
]

{ #category : #accessing }
LTile >> item [ 

	^ item
]

{ #category : #accessing }
LTile >> item: anItem [ 

	item := anItem 
]

{ #category : #accessing }
LTile >> players [ 

	^ players 
]

{ #category : #accessing }
LTile >> players: aCollection [ 

	players := aCollection 
]
