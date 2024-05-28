Class {
	#name : #LBoardElement,
	#superclass : #BlElement,
	#instVars : [
		'board',
		'arrows',
		'tiles',
		'extraTileElement',
		'game'
	],
	#category : #'Labyrinth-UI'
}

{ #category : #'as yet unclassified' }
LBoardElement class >> arrowForm [ 

	| w h shape |
	w := 100.
h := 100.
shape := BlElement new
		         size: w @ h;
		         background: Color lightGreen ;
		         border: (BlBorder paint: Color gray width: 2);
		         geometry: (BlPolygonGeometry vertices: {
						          (w / 3 @ 0).
						          (w * 2/3 @ 0).
						          (w * 2/3 @ (h /2)).
						          (w  @ (h /2)).
						          (w / 2 @ h).
						          (0 @ (h/2)).
									(w /3 @ (h/2) )}).
									
	^ shape asForm
]

{ #category : #'as yet unclassified' }
LBoardElement class >> cardElement [

	| elt |
	elt := BlElement new
		       size: 100 asPoint;
		       background: Color blue muchLighter;
		       geometry: (BlRoundedRectangleGeometry cornerRadius: 20).
	elt addChild: (BlElement new
			 size: 80 asPoint;
			 position: 10 asPoint;
			 background: Color white;
			 geometry: BlCircleGeometry new).

	^ elt
]

{ #category : #'instance creation' }
LBoardElement class >> open [

	<script>
	| elt space |
	elt := self new board: LBoard new.

	space := BlSpace new extent: 1500 @ 900.
	space root addChild: elt.
	space root clipChildren: false.

	"elt tiles children first tile tagAccessibleNeighbors.
	elt tiles children do: [ :e | e updateBackgroundRepresentation ]."


	space show.
	^ elt
]

{ #category : #'as yet unclassified' }
LBoardElement >> arrowVertical: directionBoolean at: aNumber toTheEnd: endBoolean [

	| arrow form |
	form := self class arrowForm.
	"rotate form"
	directionBoolean
		ifTrue: [
			endBoolean ifFalse: [
				form := form rotateBy: #pi centerAt: 50 asPoint ] ]
		ifFalse: [
			form := endBoolean
				        ifTrue: [ form rotateBy: #left centerAt: 50 asPoint ]
				        ifFalse: [ form rotateBy: #right centerAt: 50 asPoint ] ].
	arrow := BlElement new
		         size: 100 asPoint;
		         background: form;
		         addEventHandlerOn: BlClickEvent do: [
			         self board
				         insertAt: aNumber
				         isVertical: directionBoolean
				         toTheEnd: endBoolean.
			         self
				         updateLineVertical: directionBoolean
				         at: aNumber
				         toTheEnd: endBoolean.
			         self hideArrows.
			         self board game enterMovePhase ].

	^ arrow
]

{ #category : #accessing }
LBoardElement >> arrows [ 

	^ arrows
]

{ #category : #accessing }
LBoardElement >> board [ 

	^ board
]

{ #category : #accessing }
LBoardElement >> board: aLBoard [

	board := aLBoard.
	aLBoard boardElement: self.
	self initializeTiles.
	self initializeExtraTile.
	self initializeBoardWithArrows.
	"self initializeCards"
]

{ #category : #accessing }
LBoardElement >> extraTileElement [ 

	^ extraTileElement 
]

{ #category : #accessing }
LBoardElement >> extraTileElement: aLTile [

	extraTileElement := aLTile
]

{ #category : #'as yet unclassified' }
LBoardElement >> fillElement [

	^ BlElement new background: Color transparent; size: 100 asPoint.
]

{ #category : #accessing }
LBoardElement >> game [ 

	^ game 
]

{ #category : #accessing }
LBoardElement >> game: aLGame [

	game := aLGame.
	aLGame board: self board.
]

{ #category : #'as yet unclassified' }
LBoardElement >> hideArrows [ 

	self arrows do: [ :e |
		e visibility: BlVisibilityHidden new ]
]

{ #category : #initialization }
LBoardElement >> initialize [

	super initialize.
	self
		size: 1300 @ 900 ;
		background: (BlBackground paint: Color transparent);
		requestFocus
]

{ #category : #initialization }
LBoardElement >> initializeArrows [

	arrows := { self arrowVertical: true at: 2 toTheEnd: true. 
	self arrowVertical: true at: 4 toTheEnd: true.
	self arrowVertical: true at: 6 toTheEnd: true.
	self arrowVertical: false at: 2 toTheEnd: true.
	self arrowVertical: false at: 2 toTheEnd: false.
	self arrowVertical: false at: 4 toTheEnd: true.
	self arrowVertical: false at: 4 toTheEnd: false.
	self arrowVertical: false at: 6 toTheEnd: true.
	self arrowVertical: false at: 6 toTheEnd: false.
	self arrowVertical: true at: 2 toTheEnd: false.
	self arrowVertical: true at: 4 toTheEnd: false.
	self arrowVertical: true at: 6 toTheEnd: false.}
]

{ #category : #initialization }
LBoardElement >> initializeBoardWithArrows [

	| container |
	container := BlElement new
		             background: Color transparent;
		             layout: (BlGridLayout new horizontal columnCount: 9);
		             position: 400 @ 0;
		             size: 900 asPoint.
	self initializeArrows.

	container addChildren: {
			self fillElement.
			self fillElement.
			(arrows at: 1).
			self fillElement.
			(arrows at: 2).
			self fillElement.
			(arrows at: 3).
			self fillElement.
			self fillElement.
			self fillElement.
			tiles.
			self fillElement.
			(arrows at: 4).
			(arrows at: 5).
			self fillElement.
			self fillElement.
			(arrows at: 6).
			(arrows at: 7).
			self fillElement.
			self fillElement.
			(arrows at: 8).
			(arrows at: 9).
			self fillElement.
			self fillElement.
			self fillElement.
			self fillElement.
			(arrows at: 10).
			self fillElement.
			(arrows at: 11).
			self fillElement.
			(arrows at: 12).
			self fillElement }.

	self addChild: container
]

{ #category : #'as yet unclassified' }
LBoardElement >> initializeCards [

	
]

{ #category : #initialization }
LBoardElement >> initializeExtraTile [

	| rotateLeft rotateRight |
	extraTileElement := LTileElement tile: board extraTile.

	extraTileElement position: 150 @ 400.
	self addChild: extraTileElement.


	rotateLeft := BlTextElement new
		              size: 100 @ 20;
		              background: Color veryLightGray;
		              border: (BlBorder paint: Color black width: 1);
		              text: 'Rotate left' asRopedText;
		              position: 150 @ 505.
	rotateRight := BlTextElement new
		               size: 100 @ 20;
		               background: Color veryLightGray;
		               border: (BlBorder paint: Color black width: 1);
		               text: 'Rotate right' asRopedText;
		               position: 150 @ 535.

	rotateLeft
		addEventHandlerOn: BlClickEvent
		do: [ extraTileElement rotateLeft ].
	rotateRight
		addEventHandlerOn: BlClickEvent
		do: [ extraTileElement rotateRight ].

	self addChild: rotateLeft.
	self addChild: rotateRight
]

{ #category : #'as yet unclassified' }
LBoardElement >> initializeTiles [

	tiles := BlElement new
		         background: Color transparent;
		         layout: (BlGridLayout horizontal columnCount: 7);
		         constraintsDo: [ :c |
			         c horizontal fitContent.
			         c vertical fitContent.
			         c grid horizontal span: 7.
			         c grid vertical span: 7 ].
	self board do: [ :aTile |
		| elt |
		elt := LTileElement tile: aTile.
		elt boardPosition: aTile position.
		tiles addChild: elt ]
]

{ #category : #'as yet unclassified' }
LBoardElement >> showArrows [

	self arrows do: [ :e | e visibility: BlVisibilityVisible new ]
]

{ #category : #accessing }
LBoardElement >> tiles [ 

	^ tiles
]

{ #category : #'as yet unclassified' }
LBoardElement >> translateLine: anOrderedCollection [

	| line extraTile |
	line := anOrderedCollection.
	extraTile := extraTileElement tile.
	extraTileElement tile: line last tile.
	
	line size to: 2 by: -1 do: [ :i |
		|tileElt prevTileElt|
		tileElt := line at: i.
		prevTileElt := line at: i-1.
		tileElt tile: prevTileElt tile ].
	(line at: 1) tile: extraTile.
]

{ #category : #'as yet unclassified' }
LBoardElement >> updateLineVertical: directionBoolean at: aNumber toTheEnd: endBoolean [

	directionBoolean
		ifTrue: [
			| column |
			column := tiles children select: [ :e |
				          e boardPosition x = aNumber ].
			endBoolean ifFalse: [ column := column reverse ].
			self translateLine: column ]
		ifFalse: [
			| row |
			row := tiles children select: [ :e | e boardPosition y = aNumber ].
			endBoolean ifFalse: [ row := row reverse ].
			self translateLine: row ]
]
