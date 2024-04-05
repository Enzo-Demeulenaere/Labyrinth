Class {
	#name : #LTileElement,
	#superclass : #BlElement,
	#instVars : [
		'tile'
	],
	#category : #'Labyrinth-UI'
}

{ #category : #'as yet unclassified' }
LTileElement >> rotateLeft [

	"careful to rotate the background form and not the element"
	self rotateBy: #left centerAt: 50 asPoint
]

{ #category : #'as yet unclassified' }
LTileElement >> rotateLeftTimes: aNumber [

	aNumber = 0 ifTrue: [ ^ self ].
	self rotateLeft.
	self rotateLeftTimes: aNumber - 1
]

{ #category : #'as yet unclassified' }
LTileElement >> rotateRight [
	"careful to rotate the background form and not the element"

	self rotateBy: #right centerAt: 50 asPoint
]

{ #category : #'as yet unclassified' }
LTileElement >> rotateRightTimes: aNumber [

	aNumber = 0 ifTrue: [ ^ self ].
	self rotateRight.
	self rotateRightTimes: aNumber - 1
]
