Class {
	#name : #LBoardElement,
	#superclass : #BlElement,
	#instVars : [
		'board',
		'arrows',
		'tiles',
		'extraTileElement',
		'game',
		'buttons'
	],
	#category : #'Labyrinth-UI'
}

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
LBoardElement class >> rotateLeftArrowElement [

	| annulus arrow border container |
	border := BlBorder paint: Color lightGray width: 2.
	annulus := BlElement new
		           background: Color lightGreen;
		           size: 100 asPoint;
		           geometry: (BlAnnulusSectorGeometry new
				            startAngle: 45;
				            endAngle: 135;
				            innerRadius: 0.6;
				            outerRadius: 0.95);
		           border: border.

	arrow := BlElement new
		         background: Color lightGreen;
		         geometry: (BlPolylineGeometry vertices: {
						          (12 @ 20).
						          (0 @ 20).
						          (20 @ 0).
						          (40 @ 20).
						          (28 @ 20) });
		         border: border.

	arrow position: 50 @ 62.
	arrow transformDo: [ :t | t rotateBy: 45 ].

	container := BlElement new size: 100 asPoint.

	container addChild: annulus.
	container addChild: arrow.

	^ container
]

{ #category : #'as yet unclassified' }
LBoardElement class >> rotateRightArrowElement [

	| container |
	container := self rotateLeftArrowElement.
	container transformDo: [ :t | t flipX ].

	^ container
]

{ #category : #'as yet unclassified' }
LBoardElement class >> slideArrowForm [ 

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
LBoardElement >> animationDirectionIsVertical: directionBoolean toTheEnd: endBoolean [

	| animationDirection |
	animationDirection := 0 @ 0.
	directionBoolean
		ifTrue: [
			animationDirection setX: 0 setY: 1.
			endBoolean ifFalse: [ animationDirection setX: 0 setY: -1 ] ]
		ifFalse: [
			animationDirection setX: 1 setY: 0.
			endBoolean ifFalse: [ animationDirection setX: -1 setY: 0 ] ].
	^ animationDirection * self extraTileElement width
]

{ #category : #'as yet unclassified' }
LBoardElement >> arrowVertical: directionBoolean at: aNumber toTheEnd: endBoolean [

	| arrow form |
	form := self class slideArrowForm.
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
			         self hideClickables.
			         self addAnimation: (self
						          sequentialAnimationForArrow: arrow
						          number: aNumber
						          direction: directionBoolean
						          end: endBoolean) ]; yourself.

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
	self initializeBoardWithArrows
]

{ #category : #accessing }
LBoardElement >> buttons [

	^ buttons
]

{ #category : #accessing }
LBoardElement >> buttons: aCollection [

	buttons := aCollection 
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
LBoardElement >> getLineAt: aNumber isVertical: directionBoolean toTheEnd: endBoolean [

	directionBoolean
		ifTrue: [
			| column |
			column := tiles children select: [ :e |
				          e boardPosition x = aNumber ].
			endBoolean ifFalse: [
				column := column reverse. ].
			^ column ]
		ifFalse: [
			| row |
			row := tiles children select: [ :e | e boardPosition y = aNumber ].
			endBoolean ifFalse: [
				row := row reverse. ].
			^ row]
]

{ #category : #'as yet unclassified' }
LBoardElement >> hideClickables [

	self arrows do: [ :e | e visibility: BlVisibility hidden ].
	self buttons do: [ :e | e visibility: BlVisibility hidden ]
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

	arrows := {
		          (self arrowVertical: true at: 2 toTheEnd: true).
		          (self arrowVertical: true at: 4 toTheEnd: true).
		          (self arrowVertical: true at: 6 toTheEnd: true).
		          (self arrowVertical: false at: 2 toTheEnd: true).
		          (self arrowVertical: false at: 2 toTheEnd: false).
		          (self arrowVertical: false at: 4 toTheEnd: true).
		          (self arrowVertical: false at: 4 toTheEnd: false).
		          (self arrowVertical: false at: 6 toTheEnd: true).
		          (self arrowVertical: false at: 6 toTheEnd: false).
		          (self arrowVertical: true at: 2 toTheEnd: false).
		          (self arrowVertical: true at: 4 toTheEnd: false).
		          (self arrowVertical: true at: 6 toTheEnd: false) }.
]

{ #category : #initialization }
LBoardElement >> initializeBoardWithArrows [

	| container |
	container := BlElement new
		             background: Color transparent;
						clipChildren: false;
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

{ #category : #initialization }
LBoardElement >> initializeExtraTile [

	extraTileElement := LTileElement tile: board extraTile.

	extraTileElement position: 150 @ 400.
	self addChild: extraTileElement.
	self initializeRotateButtons.
]

{ #category : #initialization }
LBoardElement >> initializeRotateButtons [

	| rotateLeft rotateRight |
	rotateLeft := self class rotateLeftArrowElement.
	rotateLeft position: 150 @ 450.

	rotateRight := self class rotateRightArrowElement.
	rotateRight position: 150 @ 350.

	rotateLeft
		addEventHandlerOn: BlClickEvent
		do: [ extraTileElement addAnimation: self rotateLeftAnimation ].
	rotateRight
		addEventHandlerOn: BlClickEvent
		do: [ extraTileElement addAnimation: self rotateRightAnimation ].

	self buttons: { rotateLeft. rotateRight }.

	self addChildren: self buttons
]

{ #category : #'as yet unclassified' }
LBoardElement >> initializeTiles [

	tiles := BlElement new
		         background: Color transparent;
		         clipChildren: false;
		         zIndex: 5;
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
LBoardElement >> parallelTranslateAnimationOnLine: line direction: animationDirection [

	| animation parallelAnimation |

	animation := (BlTransformAnimation translate: animationDirection)
		             duration: 0.5 seconds.

	parallelAnimation := BlParallelAnimation withAll:
		                     (line collect: [ :e |
			                      | anim |
			                      anim := animation copy.
			                      anim target: e.
			                      anim ]).

	^ parallelAnimation
]

{ #category : #'as yet unclassified' }
LBoardElement >> rotateLeftAnimation [

	| anim |
	anim := (BlTransformAnimation rotate: -90) duration: 0.5 second.
	anim onFinishedDo: [
		extraTileElement resetTransformation.
		extraTileElement rotateLeft ].
	^ anim
]

{ #category : #'as yet unclassified' }
LBoardElement >> rotateRightAnimation [

	| anim |
	anim := (BlTransformAnimation rotate: 90) duration: 0.5 second.
	anim onFinishedDo: [
		extraTileElement resetTransformation. extraTileElement rotateRight ].
	^ anim
]

{ #category : #'as yet unclassified' }
LBoardElement >> sequentialAnimationForArrow: arrow number: aNumber direction: directionBoolean end: endBoolean [

	| line animationDirection sequentialAnimation |
	line := self
		        getLineAt: aNumber
		        isVertical: directionBoolean
		        toTheEnd: endBoolean.
		
	animationDirection := self
		                      animationDirectionIsVertical: directionBoolean
		                      toTheEnd: endBoolean.
	sequentialAnimation := self
		                       sequentialAnimationOnLine: line
		                       withArrow: arrow
		                       direction: animationDirection.

	sequentialAnimation onFinishedDo: [
		self
			updateLineVertical: directionBoolean
			at: aNumber
			toTheEnd: endBoolean.
		self board game enterMovePhase ].

	^ sequentialAnimation
]

{ #category : #'as yet unclassified' }
LBoardElement >> sequentialAnimationOnLine: line withArrow: arrow direction: animationDirection [

	| translateExtra parallelTranslate translateNewExtra sequentialAnimation lineWithExtra|
	lineWithExtra := line asOrderedCollection
			                                   addFirst: self extraTileElement;
			                                   yourself.
	translateExtra := self translateExtraToArrowAnimation: arrow.
	parallelTranslate := self
		                     parallelTranslateAnimationOnLine: lineWithExtra
		                     direction: animationDirection.
	translateNewExtra := self
		                     translateNewExtraAnimation: line last
		                     direction: animationDirection.

	sequentialAnimation := (BlSequentialAnimation new
		                        addAll: {
				                        translateExtra.
				                        parallelTranslate.
				                        translateNewExtra };
		                        yourself) onFinishedDo: [		                 
		                       lineWithExtra do: [ :e |
			                       e resetTransformation  ] ].

	^ sequentialAnimation
]

{ #category : #'as yet unclassified' }
LBoardElement >> showClickables [

	self arrows do: [ :e | e visibility: BlVisibility visible ].
	self buttons do: [ :e | e visibility: BlVisibility visible ]
]

{ #category : #accessing }
LBoardElement >> tiles [ 

	^ tiles
]

{ #category : #'as yet unclassified' }
LBoardElement >> translateExtraToArrowAnimation: anObject [

	| translation |
	"self extraTileElement zIndex: 2."
	translation := (BlTransformAnimation translate:
			                anObject positionInSpace
			                - self extraTileElement positionInSpace)
		               easing: BlQuinticInterpolator new;
		               duration: 1 seconds;
		               target: self extraTileElement.
	^ translation
]

{ #category : #'as yet unclassified' }
LBoardElement >> translateLine: anOrderedCollection [

	| line extraTile |
	line := anOrderedCollection.
	extraTile := extraTileElement tile.
	extraTileElement tile: line last tile.
	
	line do: [ :each | each tile: (self board grid at: each boardPosition) ]
]

{ #category : #'as yet unclassified' }
LBoardElement >> translateNewExtraAnimation: newExtra direction: animationDirection [

	| animation |
	newExtra zIndex: 15.
	animation := (BlTransformAnimation translate:
			              self extraTileElement positionInSpace
			              - newExtra positionInSpace - animationDirection)
		             easing: BlQuinticInterpolator new;
		             duration: 1 seconds;
		             target: newExtra;
		             onFinishedDo: [ newExtra zIndex: 10 ]. "- animationDirection"

	^ animation
]

{ #category : #'as yet unclassified' }
LBoardElement >> updateLineVertical: directionBoolean at: aNumber toTheEnd: endBoolean [

	directionBoolean
		ifTrue: [
			| column |
			column := tiles children select: [ :e |
				          e boardPosition x = aNumber ].
			endBoolean ifFalse: [
				column := column reverse.].
			self translateLine: column
			"self translateLine: column inDirection: animationDirection" ]
		ifFalse: [
			| row |
			row := tiles children select: [ :e | e boardPosition y = aNumber ].
			endBoolean ifFalse: [
				row := row reverse. ].
			self translateLine: row
			"self translateLine: row inDirection: animationDirection" ]
]
