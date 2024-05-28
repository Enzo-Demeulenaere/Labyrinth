Class {
	#name : #LCardElement,
	#superclass : #BlElement,
	#instVars : [
		'card'
	],
	#category : #'Labyrinth-UI'
}

{ #category : #accessing }
LCardElement class >> card: aLCard [ 

	^ self new card: aLCard 
]

{ #category : #accessing }
LCardElement >> card [ 
	^ card
]

{ #category : #accessing }
LCardElement >> card: aLCard [

	card := aLCard.
	self displayItem.
]

{ #category : #'as yet unclassified' }
LCardElement >> displayItem [

	| form item |
	form := self card item icon.
	item := BlElement new
		        size: 50 asPoint;
		        background: (form scaledIntoFormOfSize: 50 asPoint);
		        constraintsDo: [ :c |
			        c frame vertical alignCenter.
			        c frame horizontal alignCenter ].
	self addChild: item
]

{ #category : #accessing }
LCardElement >> initialize [

	super initialize.
	self size: 100 asPoint.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self layout: BlFrameLayout new.
	self background: Color white.
	self border: (BlBorder paint: Color darkGray width: 3)
]
