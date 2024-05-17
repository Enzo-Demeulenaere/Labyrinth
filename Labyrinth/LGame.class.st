Class {
	#name : #LGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'finished',
		'board',
		'activePlayer',
		'boardElement'
	],
	#category : #'Labyrinth-Model'
}

{ #category : #'as yet unclassified' }
LGame class >> gameTest2Players [

	| board elt game |
	board := LBoard new.
	elt := LBoardElement new board: board.
	game := self new boardElement: elt.
	game board: board.

	game addPlayer: (LPlayer new name: 'A').
	game addPlayer: (LPlayer new name: 'B').

	game launchGame.
	^ game
]

{ #category : #'as yet unclassified' }
LGame class >> gameTest3Players [

	| board elt game |
	board := LBoard new.
	elt := LBoardElement new board: board.
	game := self new boardElement: elt.
	game board: board.

	game addPlayer: (LPlayer new name: 'A').
	game addPlayer: (LPlayer new name: 'B').
	game addPlayer: (LPlayer new name: 'C').

	game launchGame.
	^ game
]

{ #category : #'as yet unclassified' }
LGame class >> gameTest4Players [

	| board elt game |
	board := LBoard new.
	elt := LBoardElement new board: board.
	game := self new boardElement: elt.
	game board: board.

	game addPlayer: (LPlayer new name: 'A').
	game addPlayer: (LPlayer new name: 'B').
	game addPlayer: (LPlayer new name: 'C').
	game addPlayer: (LPlayer new name: 'D').
	
	game launchGame.
	^ game
]

{ #category : #'instance creation' }
LGame class >> open [

	<script>
	| game elt board space |
	board := LBoard new.
	elt := LBoardElement new board: board.
	game := self new boardElement: elt.
	game board: board.

	game launchGame.

	space := BlSpace new extent: 1500 @ 1000.
	space root addChild: elt.
	space root clipChildren: false.

	space show.

	^ game 
]

{ #category : #'instance creation' }
LGame class >> openTest [

	<script>
	| game elt board space gameElement scoreContainerElement |
	space := BlSpace new extent: 1800 @ 1200.

	gameElement := BlElement new
		               constraintsDo: [ :c |
			               c vertical matchParent.
			               c horizontal matchParent ];
		               layout: BlLinearLayout horizontal.

	game := self gameTest4Players.

	game boardElement
		background: Color lightRed;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	gameElement addChild: game boardElement.

	scoreContainerElement := BlElement new
		                         background: Color lightBlue;
		                         layout: BlFrameLayout new;
		                         constraintsDo: [ :c |
			                         c vertical matchParent.
			                         c horizontal matchParent ].

	gameElement addChild: scoreContainerElement.

	space root addChild: gameElement.
	space show.
	^ self
	"space root clipChildren: false.

	space show.

	^ game"
]

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

	players add: aLPlayer.
	aLPlayer game: self
]

{ #category : #accessing }
LGame >> board [ 

	^ board
]

{ #category : #accessing }
LGame >> board: aLBoard [

	board := aLBoard.
	aLBoard game: self.
]

{ #category : #accessing }
LGame >> boardElement [ 

	^ boardElement 
]

{ #category : #accessing }
LGame >> boardElement: aLBoardElement [

	boardElement := aLBoardElement.
	aLBoardElement game: self.
]

{ #category : #'as yet unclassified' }
LGame >> distributeCards [

	| nbPlayers nbCardsPerPlayer |
	nbPlayers := self players size.
	nbCardsPerPlayer := self board cards size / nbPlayers.

	self players do: [ :p |
		| cards |
		cards := self board cards removeLast: nbCardsPerPlayer.
		p cards: cards asOrderedCollection  ]
]

{ #category : #'as yet unclassified' }
LGame >> enterMovePhase [

	self board mapAccessibleTilesForPlayer: self activePlayer.
	"the accessible tiles are now highlighted and we wait for the player to click on one of those to check for picking the item before moving to the next player"
]

{ #category : #'as yet unclassified' }
LGame >> enterTilePhase [

	self boardElement showArrows
	"arrows are now showing, when an arrows is clicked on, they disappear and we enter the movePhase"
]

{ #category : #initialization }
LGame >> finish [ 

	finished := true.
	"things at the end"
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
LGame >> launchGame [

	self players ifEmpty: [ self notify: 'Impossible to launch a game with no players'. ^ self ].
	self activePlayer: self players first.
	self placePlayers.
	self play
]

{ #category : #'as yet unclassified' }
LGame >> nextPlayer [

	| link nextLink |
	link := self players linkOf: self activePlayer.
	nextLink := link nextLink ifNil: [ self players firstLink ].
	self activePlayer: nextLink value.
	self enterTilePhase 
]

{ #category : #'as yet unclassified' }
LGame >> placePlayers [

	self players first tile: (self board grid at: 1 @ 1).
	self players size >= 2 ifTrue: [
		(self players at: 2) tile: (self board grid at: 7 @ 1) ].
	self players size >= 3 ifTrue: [
		(self players at: 3) tile: (self board grid at: 1 @ 7) ].
	self players size = 4 ifTrue: [
		(self players at: 4) tile: (self board grid at: 7 @ 7) ]
]

{ #category : #execution }
LGame >> play [

	self distributeCards.
	self finished: false.
	self enterTilePhase
]

{ #category : #accessing }
LGame >> players [ 

	^ players 
]

{ #category : #accessing }
LGame >> players: aSet [

	players := aSet
]
