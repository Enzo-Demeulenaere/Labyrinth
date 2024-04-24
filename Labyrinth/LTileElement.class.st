Class {
	#name : #LTileElement,
	#superclass : #BlElement,
	#instVars : [
		'tile'
	],
	#category : #'Labyrinth-UI'
}

{ #category : #'as yet unclassified' }
LTileElement class >> CE [

	| w h shape |
	w := 100.
	h := 100.
	shape := BlElement new
		         size: w @ h;
		         background: (Color fromRgbTriplet: { 247. 244. 223 } / 256);
		         border: (BlBorder paint: Color gray width: 2);
		         geometry: (BlPolygonGeometry vertices: {
						          (w / 4 @ (h / 4)).
						          (w @ (h / 4)).
						          (w @ (h / 4 * 3)).
						          (w / 4 * 3 @ (h / 4 * 3)).
						          (w / 4 * 3 @ h).
						          (w / 4 @ h) }).
	^ shape
]

{ #category : #'as yet unclassified' }
LTileElement class >> CN [

	| form |
	form := self CE asForm rotateBy: #left
			          centerAt: 50 asPoint.
	^ form asElement
]

{ #category : #'as yet unclassified' }
LTileElement class >> CS [

	| form |
	form := self CE asForm rotateBy: #right centerAt: 50 asPoint.
	^ form asElement
]

{ #category : #'as yet unclassified' }
LTileElement class >> CW [

	| form |
	form := self CE asForm rotateBy: #pi centerAt: 50 asPoint.
	^ form asElement
]

{ #category : #'as yet unclassified' }
LTileElement class >> SE [

	| form |
	form := self SN asForm rotateBy: #left
			          centerAt: 50 asPoint.
	^ form asElement
]

{ #category : #'as yet unclassified' }
LTileElement class >> SN [

	| w h shape |
	w := 100.
	h := 100.
	shape := BlElement new
		         size: w @ h;
		         background: (Color fromRgbTriplet: { 247. 244. 223 } / 256);
		         border: (BlBorder paint: Color gray width: 2);
		         geometry: (BlPolygonGeometry vertices: {
						          (w / 4 @ 0).
						          (w / 4 * 3 @ 0).
						          (w / 4 * 3 @ h).
						          (w / 4 @ h) }).

	^ shape
]

{ #category : #'as yet unclassified' }
LTileElement class >> TE [

	| w h shape |
	w := 100.
	h := 100.
	shape := BlElement new
		         size: w @ h;
		         background: (Color fromRgbTriplet: { 247. 244. 223 } / 256);
		         border: (BlBorder paint: Color gray width: 2);
		         geometry: (BlPolygonGeometry vertices: {
						          (w / 4 @ 0).
						          (w / 4 * 3 @ 0).
						          (w / 4 * 3 @ (h / 4)).
						          (w @ (h / 4)).
						          (w @ (h / 4 * 3)).
						          (w / 4 * 3 @ (h / 4 * 3)).
						          (w / 4 * 3 @ h).
						          (w / 4 @ h) }).

	^ shape
]

{ #category : #'as yet unclassified' }
LTileElement class >> TN [

	| form |
	form := self TE asForm rotateBy: #left centerAt: 50 asPoint.

	^ form asElement
]

{ #category : #'as yet unclassified' }
LTileElement class >> TS [

	| form |
	form := self TE asForm rotateBy: #right centerAt: 50 asPoint.

	^ form asElement
]

{ #category : #'as yet unclassified' }
LTileElement class >> TW [

	| form |
	form := self TE asForm rotateBy: #pi centerAt: 50 asPoint.

	^ form asElement
]

{ #category : #'as yet unclassified' }
LTileElement class >> tile: aLTile [ 

	^ self new tile: aLTile 
]

{ #category : #'as yet unclassified' }
LTileElement >> elementForConfig: config [

	^ self class perform: config asSymbol 
]

{ #category : #'as yet unclassified' }
LTileElement >> initialize [ 

	super initialize.
	self size: 100 asPoint
]

{ #category : #'as yet unclassified' }
LTileElement >> rotateLeft [
	"careful to rotate the background form and not the element"

	| form |
	form := self background image.
	form := form rotateBy: #left centerAt: 50 asPoint.
	self background: form.
	self tile rotateLeft.
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

	| form |
	form := self background image.
	form := form rotateBy: #right centerAt: 50 asPoint.
	self background: form.
	self tile rotateRight.
]

{ #category : #'as yet unclassified' }
LTileElement >> rotateRightTimes: aNumber [

	aNumber = 0 ifTrue: [ ^ self ].
	self rotateRight.
	self rotateRightTimes: aNumber - 1
]

{ #category : #accessing }
LTileElement >> tile [ 

	^ tile
]

{ #category : #accessing }
LTileElement >> tile: aLTile [

	tile := aLTile.
	self updateBackgroundRepresentation
]

{ #category : #'change reporting' }
LTileElement >> updateBackgroundRepresentation [

	| form path formElt config |
	formElt := (LRessources wallIcon scaledIntoFormOfSize: 100 asPoint)
		           asElement.
	config := tile configuration.
	path := self elementForConfig: config.
	formElt addChild: path.
	form := formElt asForm.
	self background: form
]
