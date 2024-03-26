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

{ #category : #initialization }
LBoard >> initialize [ 

	super initialize.
	self initializeTiles.
	self initializeCards.
	
]

{ #category : #initialization }
LBoard >> initializeCards [
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
		at: 3 @ 1 put: (LTile tShaped rotateRightTimes: 1);
		at: 5 @ 1 put: (LTile tShaped rotateRightTimes: 1);
		at: 7 @ 1 put: (LTile corner rotateRightTimes: 1);
		at: 1 @ 3 put: LTile tShaped;
		at: 3 @ 3 put: LTile tShaped;
		at: 5 @ 3 put: (LTile tShaped rotateRightTimes: 1);
		at: 7 @ 3 put: (LTile tShaped rotateRightTimes: 2);
		at: 1 @ 5 put: LTile tShaped;
		at: 3 @ 5 put: (LTile tShaped rotateRightTimes: 3);
		at: 5 @ 5 put: (LTile tShaped rotateRightTimes: 2);
		at: 7 @ 5 put: (LTile tShaped rotateRightTimes: 2);
		at: 1 @ 7 put: (LTile corner rotateRightTimes: 3);
		at: 3 @ 7 put: (LTile tShaped rotateRightTimes: 3);
		at: 5 @ 7 put: (LTile tShaped rotateRightTimes: 3);
		at: 7 @ 7 put: (LTile corner rotateRightTimes: 2).

	self grid: array
]

{ #category : #initialization }
LBoard >> initializeRemainingTiles [
	"encore 16 corner, 12 straight, 14 tShaped"

	| tiles |
	tiles := OrderedCollection new.
	1 to: 16 do: [ :i | tiles add: LTile corner randomRotate ].
	1 to: 12 do: [ :i | tiles add: LTile straight randomRotate ].
	1 to: 14 do: [ :i | tiles add: LTile tShaped randomRotate ].
	tiles shuffle.
	
	self grid withIndexesDo: [ :col :row :each | each ifNil: [ self grid at: col@row put: tiles removeLast ] ].
]

{ #category : #initialization }
LBoard >> initializeTiles [

	self initializeFixedTiles.
	self initializeRemainingTiles
]
