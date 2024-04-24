Class {
	#name : #LTile,
	#superclass : #MygAbstractBox,
	#instVars : [
		'item',
		'players',
		'directions'
	],
	#classVars : [
		'Configurations'
	],
	#category : #'Labyrinth-Model'
}

{ #category : #'as yet unclassified' }
LTile class >> corner [
	"20, corners are covering the bottom right angle by default"

	| dict |
	dict := Dictionary new
		        at: CpNorthDirection put: false;
		        at: CpEastDirection put: true;
		        at: CpSouthDirection put: true;
		        at: CpWestDirection  put: false;
		        yourself.

	^ self basicNew directions: dict
]

{ #category : #'as yet unclassified' }
LTile class >> cornerPath [

	| w h shape |
	w := 100.
	h := 100.
	shape := BlElement new
		         size: w @ h;
		         background:
					          (Color fromRgbTriplet: { 247. 244. 223 } / 256);
		         border: (BlBorder paint: Color gray width: 2);
		         geometry: (BlPolygonGeometry vertices: {
						          (w / 4 @ (h / 4)).
						          (w @ (h / 4)).
						          (w @ (h / 4 * 3)).
						          (w / 4 * 3 @ (h / 4 * 3)).
						          (w / 4 * 3 @ h).
						          (w / 4 @ h) }).
	^ shape
]

{ #category : #'class initialization' }
LTile class >> initialize [

	Configurations := {
		                  (3 -> 'CN').
		                  (5 -> 'SN').
		                  (6 -> 'CE').
		                  (7 -> 'TE').
		                  (9 -> 'CW').
		                  (10 -> 'SE').
		                  (11 -> 'TN').
		                  (12 -> 'CS').
		                  (13 -> 'TW').
		                  (14 -> 'TS') } asDictionary.
]

{ #category : #'as yet unclassified' }
LTile class >> straight [
	"12, straight are vertical by default"

	| dict |
	dict := Dictionary new
		        at: CpNorthDirection put: true;
		        at: CpEastDirection put: false;
		        at: CpSouthDirection put: true;
		        at: CpWestDirection  put: false;
		        yourself.

	^ self basicNew directions: dict
]

{ #category : #'as yet unclassified' }
LTile class >> straightPath [

	| w h shape |
	w := 100.
	h := 100.
	shape := BlElement new
		         size: w @ h;
		         background:
					          (Color fromRgbTriplet: { 247. 244. 223 } / 256);
		         border: (BlBorder paint: Color black width: 2);
		         geometry: (BlPolygonGeometry vertices: {
						          (w / 4 @ 0).
						          (w / 4 * 3 @ 0).
						          (w / 4 * 3 @ h).
						          (w / 4 @ h) }).

	^ shape
]

{ #category : #'as yet unclassified' }
LTile class >> tShaped [
	"18,  tShaped are 'facing' east by default"

	| dict |
	dict := Dictionary new
		        at: CpNorthDirection put: true;
		        at: CpEastDirection put: true;
		        at: CpSouthDirection put: true;
		        at: CpWestDirection  put: false;
		        yourself.

	^ self basicNew directions: dict
]

{ #category : #'as yet unclassified' }
LTile class >> tShapedPath [

	| w h shape |
	w := 100.
	h := 100.
	shape := BlElement new
		         size: w @ h;
		         background:
					          (Color fromRgbTriplet: { 247. 244. 223 } / 256);
		         border: (BlBorder paint: Color black width: 2);
		         geometry: (BlPolygonGeometry vertices: {
						          (w / 4 @ 0).
						          (w / 4 * 3 @ 0).
						          (w / 4 * 3 @ (h / 4)).
						          (w @ (h / 4)).
						          (w @ (h / 4 * 3)).
						          (w / 4 * 3 @ (h / 4 * 3)).
						          (w / 4 * 3 @ h).
						          (w / 4 @ h) }).

	^ shape
]

{ #category : #accessing }
LTile >> configuration [

	| value |
	value := 0.
	(directions at: CpNorthDirection) ifTrue: [ value := value + 1 ].
	(directions at: CpEastDirection) ifTrue: [ value := value + 2 ].
	(directions at: CpSouthDirection ) ifTrue: [ value := value + 4 ].
	(directions at: CpWestDirection ) ifTrue: [ value := value + 8 ].

	^ Configurations at: value ifAbsent: $*
]

{ #category : #accessing }
LTile >> configurations [

	^ Configurations
]

{ #category : #accessing }
LTile >> directions [ 

	^ directions 
]

{ #category : #accessing }
LTile >> directions: aDictionary [

	directions := aDictionary 
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

{ #category : #printing }
LTile >> printOn: aStream [

	aStream 
	nextPut: $|;
	nextPutAll: self configuration;
	nextPut: $|
]

{ #category : #'as yet unclassified' }
LTile >> randomRotate [ 

	| nbRotate |
	nbRotate := { 0. 1. 2. 3 } atRandom.
	self rotateLeftTimes: nbRotate.
]

{ #category : #'as yet unclassified' }
LTile >> rotateLeft [

	| north |
	north := self directions at: CpNorthDirection.
	self directions
		at: CpNorthDirection
		put: (self directions at: CpEastDirection).
	self directions
		at: CpEastDirection
		put: (self directions at: CpSouthDirection).
	self directions
		at: CpSouthDirection
		put: (self directions at: CpWestDirection).
	self directions at: CpWestDirection  put: north
]

{ #category : #'as yet unclassified' }
LTile >> rotateLeftTimes: aNumber [ 

	aNumber = 0 ifTrue: [ ^ self ].
	self rotateLeft.
	self rotateLeftTimes: aNumber -1
]

{ #category : #'as yet unclassified' }
LTile >> rotateRight [ 

	|north|
	north := self directions at: CpNorthDirection.
	self directions at: CpNorthDirection put: (self directions at: CpWestDirection).
	self directions at: CpWestDirection put: (self directions at: CpSouthDirection ).
	self directions at: CpSouthDirection put: (self directions at: CpEastDirection ).
	self directions at: CpEastDirection put: north.
]

{ #category : #'as yet unclassified' }
LTile >> rotateRightTimes: aNumber [ 

	aNumber = 0 ifTrue: [ ^ self ].
	self rotateRight.
	self rotateRightTimes: aNumber -1
]
