Class {
	#name : #LPlayer,
	#superclass : #Object,
	#instVars : [
		'cards',
		'name',
		'tile'
	],
	#category : #'Labyrinth-Model'
}

{ #category : #testing }
LPlayer >> canAccessTo: aLTile [

	self tile board mapAccessibleTilesForPlayer: self.
	^ aLTile isAccessible 
]

{ #category : #accessing }
LPlayer >> cards [ 

	^ cards 
]

{ #category : #accessing }
LPlayer >> cards: aCollection [ 

	cards := aCollection 
]

{ #category : #initialization }
LPlayer >> initialize [

	super initialize.
	cards := OrderedCollection new
]

{ #category : #accessing }
LPlayer >> name [ 

	^ name 
]

{ #category : #accessing }
LPlayer >> name: aString [ 

	name := aString 
]

{ #category : #accessing }
LPlayer >> tile [ 

	^ tile
]

{ #category : #accessing }
LPlayer >> tile: aLTile [

	tile := aLTile 
]
