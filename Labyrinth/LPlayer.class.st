Class {
	#name : #LPlayer,
	#superclass : #Object,
	#instVars : [
		'cards',
		'name',
		'tile',
		'game'
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

{ #category : #'as yet unclassified' }
LPlayer >> checkItem [

	self cards ifEmpty: [ "check si c'est le spawn" ].
	self tile item ifNotNil: [ :item |
		item = self cards first item ifTrue: [ self nextItem ] ]
]

{ #category : #accessing }
LPlayer >> game [ 

	^ game
]

{ #category : #accessing }
LPlayer >> game: aLGame [

	game := aLGame 
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

{ #category : #queries }
LPlayer >> nextItem [

	| card |
	card := self cards first.
	card disappear.
	self cards removeFirst.
	"temporary before checking spawn point of the player"
	self cards ifEmpty: [ self game finish ]
]

{ #category : #accessing }
LPlayer >> tile [ 

	^ tile
]

{ #category : #accessing }
LPlayer >> tile: aLTile [

	tile := aLTile.
	aLTile addPlayer: self
]
