Class {
	#name : #LGameElement,
	#superclass : #BlElement,
	#instVars : [
		'game',
		'boardElement',
		'scoreContainerElement',
		'scoreElements',
		'playerColors',
		'playerBorderColors'
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

{ #category : #'as yet unclassified' }
LGameElement >> borderForID: aPlayerID [ 

	^ self playerBorderColors at: aPlayerID 
]

{ #category : #'as yet unclassified' }
LGameElement >> colorForID: aPlayerID [

	^ self playerColors at: aPlayerID
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
	self background: Color orange muchLighter.
	self layout: BlLinearLayout horizontal.
	self initializeBoardElement.
	self initializePlayerColors.
]

{ #category : #initialization }
LGameElement >> initializeBoardElement [

	self boardElement: (LBoardElement new board: LBoard new).
	self addChild: self boardElement
]

{ #category : #initialization }
LGameElement >> initializePlayerColors [

	playerColors := Dictionary new
		                at: 1 put: (Color blue alpha: 0.4);
		                at: 2 put: (Color red alpha: 0.4);
		                at: 3 put: (Color yellow alpha: 0.4);
		                at: 4 put: (Color green alpha: 0.4);
							yourself.
	playerBorderColors := Dictionary new
		                at: 1 put: (BlBorderBuilder new
				                 paint: Color blue;
				                 width: 4;
				                 dashArray: { 0. 60. 30. 100 };
				                 build);
		                at: 2 put: (BlBorderBuilder new
			                 width: 4;
			                 paint: Color red;
			                 dashArray: { 0. 90. 30. 100 };
			                 build);
		                at: 3 put: (BlBorderBuilder new
			                 width: 4;
			                 paint: Color yellow;
			                 dashArray: { 0. 30. 30. 100 };
			                 build);
		                at: 4 put: (BlBorderBuilder new
			                 width: 4;
			                 paint: Color green;
			                 dashArray: { 30. 100 };
			                 build);
		                yourself
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
LGameElement >> playerBorderColors [ 

	^ playerBorderColors 
]

{ #category : #accessing }
LGameElement >> playerBorderColors: aDictionary [

	playerBorderColors:= aDictionary 
]

{ #category : #accessing }
LGameElement >> playerColors [ 

	^ playerColors 
]

{ #category : #accessing }
LGameElement >> playerColors: aDictionary [

	playerColors := aDictionary 
]

{ #category : #accessing }
LGameElement >> scoreContainerElement [ 

	^ scoreContainerElement 
]

{ #category : #'as yet unclassified' }
LGameElement >> scoreElementForID: aPlayerID [ 

	^ self scoreElements ifNotNil: [ :e | e at: aPlayerID ]
]

{ #category : #accessing }
LGameElement >> scoreElements [

	^ scoreElements
]
