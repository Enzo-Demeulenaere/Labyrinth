Class {
	#name : #LBoardElement,
	#superclass : #BlElement,
	#instVars : [
		'board',
		'arrows',
		'tiles'
	],
	#category : #'Labyrinth-UI'
}

{ #category : #'instance creation' }
LBoardElement class >> open [

	<script>
	| elt space |
	elt := self new board: LBoard new.

	space := BlSpace new extent: 2000 @ 1000.
	space root addChild: elt.

	space show
]

{ #category : #'as yet unclassified' }
LBoardElement >> arrowVertical: directionBoolean at: aNumber toTheEnd: endBoolean [

	^ BlElement new background: Color lightGreen; size: 100 asPoint; addEventHandlerOn: BlClickEvent  do: [ self board insertAt: aNumber isVertical: directionBoolean toTheEnd: endBoolean ]
]

{ #category : #accessing }
LBoardElement >> board [ 

	^ board
]

{ #category : #accessing }
LBoardElement >> board: aLBoard [

	board := aLBoard.
	self initializeTiles.
	"self initializeExtraTile."
	self initializeBoardArrows.
	self initializeCards
]

{ #category : #'as yet unclassified' }
LBoardElement >> fillElement [

	^ BlElement new background: Color transparent; size: 100 asPoint.
]

{ #category : #initialization }
LBoardElement >> initialize [

	super initialize.
	self
		size: 1000 asPoint;
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
LBoardElement >> initializeBoardArrows [

	| container |
	container := BlElement new
		             background: Color transparent;
		             layout: (BlGridLayout new horizontal columnCount: 9);
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

	| extra rotateLeft rotateRight extraContainer |
	extraContainer := BlElement new
		                  layout: BlFrameLayout new;
		                  constraintsDo: [ :c |
			                  c horizontal matchParent.
			                  c vertical matchParent ].

	extra := LTileElement tile: board extraTile.
	extra constraintsDo: [ :c |
		c frame horizontal alignRightAt: 0.3.
		c frame vertical alignCenter ].
	extraContainer addChild: extra.
	"extra position: 800 @ 300."
	self addChild: extraContainer.

	rotateLeft := BlTextElement new
		              size: 50 @ 20;
		              background: Color veryLightGray;
		              border: (BlBorder paint: Color black width: 1);
		              text: 'Rotate left' asRopedText;
		              position: 800 @ 410.
	rotateRight := BlTextElement new
		               size: 50 @ 20;
		               background: Color veryLightGray;
		               border: (BlBorder paint: Color black width: 1);
		               text: 'Rotate right' asRopedText;
		               position: 850 @ 410.

	rotateLeft addEventHandlerOn: BlClickEvent do: [ extra rotateLeft ].
	rotateRight addEventHandlerOn: BlClickEvent do: [ extra rotateRight ].

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
		tiles addChild: elt ]
]
