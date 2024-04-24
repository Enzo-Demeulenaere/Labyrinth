Class {
	#name : #LBoardElement,
	#superclass : #BlElement,
	#instVars : [
		'board'
	],
	#category : #'Labyrinth-UI'
}

{ #category : #accessing }
LBoardElement >> board [ 

	^ board
]

{ #category : #accessing }
LBoardElement >> board: aLBoard [

	board := aLBoard.
	self initializeTiles.
	self initializeCards.
]

{ #category : #initialization }
LBoardElement >> initialize [

	super initialize.
	self
		size: 1000 asPoint;
		background: (BlBackground paint: Color transparent);
		requestFocus
]

{ #category : #'as yet unclassified' }
LBoardElement >> initializeCards [

	
]

{ #category : #'as yet unclassified' }
LBoardElement >> initializeTiles [

	| tiles |
	tiles := BlElement new
		         background: Color transparent;
		         layout: (BlGridLayout horizontal columnCount: 7);
		         constraintsDo: [ :c |
			         c horizontal fitContent.
			         c vertical fitContent ].
	self addChild: tiles.
	self board do: [ :aTile |
		|elt|
		elt := LTileElement tile: aTile.
		tiles addChild: elt. ]
]
