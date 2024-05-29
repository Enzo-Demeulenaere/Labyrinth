Class {
	#name : #LGameElement,
	#superclass : #BlElement,
	#instVars : [
		'game',
		'boardElement',
		'scoreContainerElement',
		'scoreElements'
	],
	#category : #'Labyrinth-UI'
}

{ #category : #accessing }
LGameElement >> boardElement [ 

	^ boardElement 
]

{ #category : #accessing }
LGameElement >> boardElement: aLBoardElement [

	boardElement := aLBoardElement.
]

{ #category : #initialization }
LGameElement >> finish [

	| finishScreen finishText |
	finishScreen := BlElement new
		                background: (Color lightGreen alpha: 0.5);
		                constraintsDo: [ :c |
			                c ignoredByLayout.
			                c vertical matchParent.
			                c horizontal matchParent ];
		                layout: BlFrameLayout new.

	finishText := BlTextElement new
		              text: ('Game finished' asRopedText fontSize: 150);
		              constraintsDo: [ :c |
			              c frame vertical alignCenter.
			              c frame horizontal alignCenter ].

	finishScreen addChild: finishText.

	self parent addChild: finishScreen
]

{ #category : #accessing }
LGameElement >> game [ 

	^ game
]

{ #category : #accessing }
LGameElement >> game: aLGame [

	game := aLGame.
	aLGame boardElement: self boardElement.
]

{ #category : #initialization }
LGameElement >> initialize [

	super initialize.
	self constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	self background: (BlLinearGradientPaint horizontal
			 from: Color white
			 to: Color lightOrange).
	self layout: BlLinearLayout horizontal.
	self initializeBoardElement
	"self initializeScoreElements"
]

{ #category : #initialization }
LGameElement >> initializeBoardElement [

	self boardElement: (LBoardElement new board: LBoard new).
	self addChild: self boardElement
]

{ #category : #'as yet unclassified' }
LGameElement >> initializeScoreElements [

	| frame |
	frame := BlElement new
		         background: Color transparent;
		         layout: BlFrameLayout new;
		         constraintsDo: [ :c |
			         c vertical matchParent.
			         c horizontal matchParent ].
	self addChild: frame.

	scoreElements := OrderedCollection new.

	scoreContainerElement := BlElement new
		                         layout: BlLinearLayout vertical;
		                         constraintsDo: [ :c |
			                         c frame vertical alignCenter.
			                         c frame horizontal alignRight.
			                         c vertical fitContent.
			                         c horizontal fitContent ].
	1 to: self game players size do: [ :i |
		| elt |
		elt := LScoreElement new player: (self game players at: i).
		scoreElements add: elt.
		scoreContainerElement addChild: elt ].
	frame addChild: scoreContainerElement
]

{ #category : #accessing }
LGameElement >> scoreContainerElement [ 

	^ scoreContainerElement 
]

{ #category : #accessing }
LGameElement >> scoreElements [

	^ scoreElements
]
