Class {
	#name : #LBoard,
	#superclass : #MygBoard,
	#instVars : [
		'extraTile',
		'cards',
		'items',
		'game'
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

{ #category : #enumerating }
LBoard >> do: aBlock [ 

	grid do: aBlock 

	
]

{ #category : #accessing }
LBoard >> extraTile [ 

	^ extraTile 
]

{ #category : #accessing }
LBoard >> extraTile: aLTile [ 

	extraTile := aLTile 
]

{ #category : #accessing }
LBoard >> game [ 

	^ game
]

{ #category : #accessing }
LBoard >> game: aLGame [

	game := aLGame 
]

{ #category : #initialization }
LBoard >> initialize [

	super initialize.
	self initializeItems.
	self initializeCards.
	self initializeTiles
]

{ #category : #initialization }
LBoard >> initializeCards [

	cards := items collect: [ :item | LCard item: item ].
	cards shuffle.
]

{ #category : #initialization }
LBoard >> initializeFixedTiles [
	"legend is like such: 
	
	XY 
	X = shape (C: corner/ T: tShaped/ S: straight)
	Y = orientation (N/W/S/E) 
	
	
	CE | _ | TS | _ | TS | _ | CS
	-----------------------------
	-- | - | -- | - | -- | - | --
	-----------------------------
	TE | - | TE | - | TS | - | TW
	-----------------------------
	-- | - | -- | - | -- | - | --
	-----------------------------
	TE | - | TN | - | TW | - | TW
	-----------------------------
	-- | - | -- | - | -- | - | --
	-----------------------------
	CN | - | TN | - | TN | - | CW
	"

	| array |
	array := CTNewArray2D width: 7 height: 7.
	array
		at: 1 @ 1 put: LTile corner;
		at: 3 @ 1
		put: ((LTile tShaped rotateRightTimes: 1) item: (items at: 1));
		at: 5 @ 1
		put: ((LTile tShaped rotateRightTimes: 1) item: (items at: 2));
		at: 7 @ 1 put: (LTile corner rotateRightTimes: 1);
		at: 1 @ 3 put: (LTile tShaped item: (items at: 3));
		at: 3 @ 3 put: (LTile tShaped item: (items at: 4));
		at: 5 @ 3
		put: ((LTile tShaped rotateRightTimes: 1) item: (items at: 5));
		at: 7 @ 3
		put: ((LTile tShaped rotateRightTimes: 2) item: (items at: 6));
		at: 1 @ 5 put: (LTile tShaped item: (items at: 7));
		at: 3 @ 5
		put: ((LTile tShaped rotateRightTimes: 3) item: (items at: 8));
		at: 5 @ 5
		put: ((LTile tShaped rotateRightTimes: 2) item: (items at: 9));
		at: 7 @ 5
		put: ((LTile tShaped rotateRightTimes: 2) item: (items at: 10));
		at: 1 @ 7 put: (LTile corner rotateRightTimes: 3);
		at: 3 @ 7
		put: ((LTile tShaped rotateRightTimes: 3) item: (items at: 11));
		at: 5 @ 7
		put: ((LTile tShaped rotateRightTimes: 3) item: (items at: 12));
		at: 7 @ 7 put: (LTile corner rotateRightTimes: 2).

	self grid: array
]

{ #category : #initialization }
LBoard >> initializeItems [

	items := OrderedCollection new.
	items addAll: {
			(LItem name: 'bird').
			(LItem name: 'chandelier').
			(LItem name: 'cat').
			(LItem name: 'chest').
			(LItem name: 'crown').
			(LItem name: 'crystalBall').
			(LItem name: 'diamond').
			(LItem name: 'dino').
			(LItem name: 'dreamCatcher').
			(LItem name: 'egg').
			(LItem name: 'fossil').
			(LItem name: 'idol').
			(LItem name: 'key').
			(LItem name: 'money').
			(LItem name: 'mouse').
			(LItem name: 'necklace').
			(LItem name: 'parchment').
			(LItem name: 'potion').
			(LItem name: 'ring').
			(LItem name: 'scarab').
			(LItem name: 'skull').
			(LItem name: 'snake').
			(LItem name: 'vase').
			(LItem name: 'viking') }
]

{ #category : #initialization }
LBoard >> initializeRemainingTiles [
	"encore 16 corner, 12 straight, 14 tShaped"

	| tiles |
	tiles := OrderedCollection new.
	1 to: 12 do: [ :i | tiles add: LTile straight randomRotate ]. "12 total, 0 definitive"
	1 to: 6 do: [ :i | tiles add: LTile tShaped randomRotate ]. "18 total, 12 definitive"
	1 to: 16 do: [ :i | tiles add: LTile corner randomRotate ]. "20 corners total, 4 definitive"

	13 to: 24 do: [ :i | (tiles at: i) item: (items at: i) ].
	"This adds 6 items to the last 6 tShaped and the 6 last items the 6 corners"
	"We start at i = 13 because the first 12 items were assigned in the 'initializeFixedTiles' method"
	"Now each item is correctly assigned to a tile, they can be shuffled to be placed"
	tiles shuffle.

	self grid withIndexesDo: [ :col :row :each |
		each ifNil: [ self grid at: col @ row put: tiles removeLast ] ].

	self extraTile: tiles first.
	self extraTile board: self
]

{ #category : #initialization }
LBoard >> initializeTiles [

	self initializeFixedTiles.
	self initializeRemainingTiles.
	self configureGrid: self grid.
]

{ #category : #accessing }
LBoard >> insertAt: anIndex isVertical: verticalBoolean toTheEnd: endBoolean [

	verticalBoolean ifTrue: [ 
		self insertAtColumn: anIndex toTheEnd: endBoolean ] ifFalse: [ 
		self insertAtRow: anIndex toTheEnd: endBoolean  ]
]

{ #category : #'as yet unclassified' }
LBoard >> insertAtColumn: anIndex toTheEnd: endBoolean [
	"endBoolean True means Top to Bottom"

	| col |
	col := (grid columns at: anIndex) asOrderedCollection.

	endBoolean
		ifTrue: [
			col addFirst: extraTile.
			extraTile := col removeLast ]
		ifFalse: [
			col add: extraTile.
			extraTile := col removeFirst ].

	grid atColumn: anIndex put: col.
]

{ #category : #'as yet unclassified' }
LBoard >> insertAtRow: anIndex toTheEnd: endBoolean [
	"endBoolean True means Left to Right"

	| row |
	row := (grid rows at: anIndex) asOrderedCollection .

	endBoolean
		ifTrue: [
			row addFirst: extraTile.
			extraTile := row removeLast ]
		ifFalse: [
			row add: extraTile.
			extraTile := row removeFirst ].

	grid atRow: anIndex put: row
]

{ #category : #accessing }
LBoard >> items [ 

	^ items
]

{ #category : #'as yet unclassified' }
LBoard >> mapAccessibleTilesForPlayer: aLPlayer [

	| initialTile |
	initialTile := aLPlayer tile.
	initialTile tagAccessibleNeighbors
]
