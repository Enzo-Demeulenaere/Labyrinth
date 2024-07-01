Class {
	#name : 'LPlayer',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'name',
		'tile',
		'game',
		'id'
	],
	#category : 'Labyrinth-Model',
	#package : 'Labyrinth',
	#tag : 'Model'
}

{ #category : 'testing' }
LPlayer >> canAccessTo: aLTile [

	self tile board mapAccessibleTilesForPlayer: self.
	^ aLTile isAccessible 
]

{ #category : 'accessing' }
LPlayer >> cards [ 

	^ cards 
]

{ #category : 'accessing' }
LPlayer >> cards: aCollection [ 

	cards := aCollection 
]

{ #category : 'as yet unclassified' }
LPlayer >> checkItem [

	self cards ifEmpty: [ self error: 'This player has no more cards' ].
	self tile item ifNotNil: [ :item |
		item = self cards first item ifTrue: [ self nextItem ] ]
]

{ #category : 'accessing' }
LPlayer >> game [ 

	^ game
]

{ #category : 'accessing' }
LPlayer >> game: aLGame [

	game := aLGame 
]

{ #category : 'as yet unclassified' }
LPlayer >> gameElement [

	^ self game gameElement
]

{ #category : 'accessing' }
LPlayer >> id [ 
	^ id
]

{ #category : 'accessing' }
LPlayer >> id: aNumber [

	id := aNumber 
]

{ #category : 'initialization' }
LPlayer >> initialize [

	super initialize.
	cards := OrderedCollection new.
	id := 0
]

{ #category : 'accessing' }
LPlayer >> name [ 

	^ name 
]

{ #category : 'accessing' }
LPlayer >> name: aString [ 

	name := aString 
]

{ #category : 'queries' }
LPlayer >> nextItem [

	| card |
	card := self cards first.
	card disappear.
	self cards removeFirst.
	self cards ifEmpty: [ self game finish ]
]

{ #category : 'as yet unclassified' }
LPlayer >> playerBorderColor [

	^ self gameElement borderForID: self id
]

{ #category : 'as yet unclassified' }
LPlayer >> playerColor [

	^ self gameElement colorForID: self id
]

{ #category : 'accessing' }
LPlayer >> scoreElement [

	^ self gameElement scoreElementForID: self id
]

{ #category : 'accessing' }
LPlayer >> tile [ 

	^ tile
]

{ #category : 'accessing' }
LPlayer >> tile: aLTile [

	tile := aLTile.
	aLTile addPlayer: self
]
