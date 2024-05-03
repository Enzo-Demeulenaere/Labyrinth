Class {
	#name : #LGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'finished',
		'board',
		'activePlayer'
	],
	#category : #'Labyrinth-Model'
}

{ #category : #accessing }
LGame >> activePlayer [ 

	^ activePlayer 
]

{ #category : #accessing }
LGame >> activePlayer: aLPlayer [

	activePlayer := aLPlayer 
]

{ #category : #adding }
LGame >> addPlayer: aLPlayer [

	players add: aLPlayer
]

{ #category : #accessing }
LGame >> board [ 

	^ board
]

{ #category : #accessing }
LGame >> board: aLBoard [

	board := aLBoard 
]

{ #category : #'as yet unclassified' }
LGame >> distributeCards [ 

	| nbPlayers nbCardsPerPlayer |
	nbPlayers := self players size.
	nbCardsPerPlayer := self board cards size / nbPlayers.
	
	self players do: [ :p | 
		|cards|
		cards := self board cards removeLast: nbCardsPerPlayer.
		p cards: cards ]
]

{ #category : #accessing }
LGame >> finished: aBoolean [ 

	finished := aBoolean 
]

{ #category : #initialization }
LGame >> initialize [

	super initialize.
	players := LinkedList new
]

{ #category : #testing }
LGame >> isFinished [ 

	^ finished 
]

{ #category : #'as yet unclassified' }
LGame >> nextPlayer [

	|link nextLink |
	link := self players linkOf: self activePlayer.
	nextLink := link nextLink ifNil: [ self players firstLink ].
	self activePlayer: nextLink value.
]

{ #category : #execution }
LGame >> play [

	self distributeCards.
	self finished: false.
	[self isFinished] whileFalse: [ 
		self finished: true."game loop" ]
]

{ #category : #accessing }
LGame >> players [ 

	^ players 
]

{ #category : #accessing }
LGame >> players: aSet [

	players := aSet
]

{ #category : #'as yet unclassified' }
LGame >> prepareGame [

	self board: LBoard new.
	"other things"
	self addPlayer: (LPlayer new name: 'A').
	self addPlayer: (LPlayer new name: 'B').
	self activePlayer: self players first.
	self play
]
