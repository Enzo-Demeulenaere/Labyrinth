Class {
	#name : 'LScoreElement',
	#superclass : 'BlElement',
	#instVars : [
		'player',
		'nameTag',
		'highlightAnimation'
	],
	#category : 'Labyrinth-UI',
	#package : 'Labyrinth',
	#tag : 'UI'
}

{ #category : 'as yet unclassified' }
LScoreElement >> defaultHighlightAnimation [

	^ BlColorTransition new
		                      from: Color white;
		                      to: self player playerColor;
		                      duration: 1 seconds;
		                      onStepDo: [ :c | self nameTag background: c ];
		                      beInfinite;
		                      yourself.

]

{ #category : 'as yet unclassified' }
LScoreElement >> highlight [

	highlightAnimation := self defaultHighlightAnimation copy.
	self addAnimation: self highlightAnimation 
]

{ #category : 'accessing' }
LScoreElement >> highlightAnimation [

	^ highlightAnimation "ifNil: [
		  highlightAnimation := BlColorTransition new
			                        from: Color white;
			                        to: self player playerColor;
			                        duration: 1 seconds;
			                        onStepDo: [ :c |
				                        self nameTag background: c ] ]"
]

{ #category : 'accessing' }
LScoreElement >> initialize [

	super initialize.
	self
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c margin: (BlInsets top: 30 bottom: 30).
			c vertical fitContent.
			c horizontal fitContent.
			c frame horizontal alignRight ].
]

{ #category : 'initialization' }
LScoreElement >> initializeCards [

	| cardsSlot |
	cardsSlot := BlElement new
		             size: 300 @ 120;
		             background: Color veryVeryLightGray;
		             geometry:
			             (BlRoundedRectangleGeometry cornerRadii:
					              (BlCornerRadii new
						               bottomLeft: 10;
						               bottomRight: 0;
						               topLeft: 0;
						               topRight: 0;
						               yourself)).

	self player cards size to: 1 by: -1 do: [ :i |
		| cardElt |
		cardElt := LCardElement card: (self player cards at: i).
		cardElt position: i - 1 * 20 + 40 @ 10.
		cardsSlot addChild: cardElt ].

	self addChild: cardsSlot
]

{ #category : 'initialization' }
LScoreElement >> initializeNameTag [

	| name |
	nameTag := BlElement new
		           size: 300 @ 30;
		           background: self player playerColor;
		           geometry:
			           (BlRoundedRectangleGeometry cornerRadii:
					            (BlCornerRadii new
						             topLeft: 10;
						             topRight: 0;
						             bottomLeft: 0;
						             bottomRight: 0;
						             yourself)).

	name := BlTextElement new
		        text: self player name asRopedText;
		        padding: (BlInsets all: 10).

	nameTag addChild: name.
	self addChild: nameTag
]

{ #category : 'accessing' }
LScoreElement >> nameTag [

	^ nameTag
]

{ #category : 'accessing' }
LScoreElement >> player [ 

	^ player
]

{ #category : 'accessing' }
LScoreElement >> player: aLPlayer [

	player := aLPlayer.
	self initializeNameTag.
	self initializeCards
]

{ #category : 'as yet unclassified' }
LScoreElement >> stopHighlighting [

	self highlightAnimation loops: 0
]
