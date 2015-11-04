package com.graphicalevents{
	
import flash.events.Event;
import flash.events.TouchEvent;
import flash.display.Shape;
import flash.display.MovieClip;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Stage;
import flash.display.Sprite;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import flash.geom.ColorTransform;
import flash.display.SimpleButton;

	
// Graphical Key v.0.0.7 
// Author: Erekle Asatiani
// Script: Type: ActionScript 3.0
// IDE: Adobe Flash Professional CC
// Android Version ------------------------------------------------------------------------------------------------------------------------------------------------------------
// Optional you can move your elements for yourself in FLA file to combine multiplay keys.
	
	
	// Graphicalkey.as
	
	public class Graphicalkey {
		
public var counter:Array = []; //index for each display object
public var isDragging:Boolean = false; // check if dragging
public var _ovalHit:Boolean = false; // check if main drag element hits another objects

public var ovalP:Point = new Point(); // points for each display object
public var pointer1:Point = new Point();
public var pointer2:Point = new Point();
public var pointer3:Point = new Point();
public var pointer4:Point = new Point();
public var pointer5:Point = new Point();

public var _fireOnce:Boolean = false;
public var myShape = new Shape();
public var myLine = new Shape();
public var posite:Number = 0;
public var _stage:Stage;
public var fl_DragBounds:Rectangle;
		
//---------------------------------------Display Objects

public var oval:MovieClip;
public var a:SimpleButton;
public var b:SimpleButton;
public var c:SimpleButton;
public var d:SimpleButton;
public var ed:SimpleButton;
//public var f:SimpleButton;

//------------------------------------------------------
		

		public function Graphicalkey(_stage:Stage, oval:MovieClip, 
		                              a:SimpleButton, b:SimpleButton, c:SimpleButton,
									  d:SimpleButton = null, ed:SimpleButton = null, f:SimpleButton = null
									  
									  ) {
			if (d != null) this.d = d;
			if (d != null) this.ed = ed;
		
			//if (d != null) this.f = f;
										  
			this._stage = _stage;
			this.oval = oval;
			this.a = a;
			this.b = b;
			this.c = c;
			
			//swapChildren(oval, a);
            //swapChildren(oval, b);
            //swapChildren(oval, c);
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

            oval.addEventListener(TouchEvent.TOUCH_BEGIN, fl_TouchBeginHandler);
            oval.addEventListener(TouchEvent.TOUCH_END, fl_TouchEndHandler);
            oval.addEventListener(Event.ENTER_FRAME, update);
			//randomPos();
			initPoints();
			_stage.addChild(myShape);
			
			fl_DragBounds = new Rectangle(0, 0, _stage.stageWidth, _stage.stageHeight);;
		}
		
		private function fl_TouchBeginHandler(event:TouchEvent):void
        {
	        event.target.startTouchDrag(event.touchPointID, false, fl_DragBounds);
	        isDragging = true;
        }

		private function fl_TouchEndHandler(event:TouchEvent):void
		{
			event.target.stopTouchDrag(event.touchPointID);
			isDragging = false;
			initOvalPoint();
		}
		
		
		private function update(e:Event):void{
	
				if (oval.hitTestObject(a) && posite == 0){
					fireOnce(1);
					
					}
				else if (oval.hitTestObject(b) && posite == 1){
					fireOnce(2);

					}
				else if (oval.hitTestObject(c) && posite == 2){
					fireOnce(3);

					}
					
				else if (oval.hitTestObject(d) && posite == 3){
						fireOnce(4);
						}
					
				else if (oval.hitTestObject(ed) && posite == 4){
						fireOnce(5);
					}
					
					
				else {
					_fireOnce = false;
				}
				
					connectiveLineForOval(oval, pointer1);
					//posite = 0;
					//trace('Array = ' + counter);
					//trace('Index = ' + posite);
		}
		
		
		private function initPoints():void {
			
			
			pointer1.x = a.x;
			pointer1.y = a.y;
			
			pointer2.x = b.x;
			pointer2.y = b.y;
			
			pointer3.x = c.x;
			pointer3.y = c.y;
			
			
			if (d != null) { pointer4.x = d.x; pointer4.y = d.y; }
			if (ed != null) { pointer5.x = ed.x; pointer5.y = ed.y; }
			
			initOvalPoint();
			
			}
			
		private function initOvalPoint():void {
			oval.x = pointer1.x;
			oval.y = pointer1.y;
			}
			

		private function randomPos():void{
			a.x = Math.floor( Math.random()*(_stage.stageWidth) );
			a.y = Math.floor( Math.random()*(_stage.stageHeight) );
			
			b.x = Math.floor( Math.random()*(_stage.stageWidth) );
			b.y = Math.floor( Math.random()*(_stage.stageHeight) );
			
			c.x = Math.floor( Math.random()*(_stage.stageWidth) );
			c.y = Math.floor( Math.random()*(_stage.stageHeight) );
			
	
	     }
		 
		 private function paint(index:int):void {
			switch(index){
				case 1:
				  a.transform.colorTransform = new ColorTransform(255, 153, 0);
				break;
				
				case 2:
				  b.transform.colorTransform = new ColorTransform(255, 153, 0);
				break;
				
				case 3:
				  c.transform.colorTransform = new ColorTransform(255, 153, 0);
				break;
				
				case 4:
				  d.transform.colorTransform = new ColorTransform(255, 153, 0);
				break;
				
				case 5:
				  ed.transform.colorTransform = new ColorTransform(255, 153, 0);
				break;
	                     }
           }
		   
		  private function connectiveLine(ovalP:Point, p:Point):void {
			  
					if(ovalP.x != 0 && p.x != 0) {
				myShape.graphics.lineStyle(6, 0xFFF8FF, .10);
				myShape.graphics.beginFill(0xFFF8FF);
				myShape.graphics.moveTo(ovalP.x, ovalP.y); 
				myShape.graphics.lineTo(p.x, p.y);
						
					}
				}

		  private function connectiveLineForOval(oval:MovieClip, p:Point):void {
			  
					if(ovalP.x != 0 && p.x != 0) {
				myLine.graphics.lineStyle(6, 0xFF0000, .10);
				myLine.graphics.beginFill(0x00FF00);
				myLine.graphics.moveTo(oval.x, oval.y); 
				myLine.graphics.lineTo(p.x, p.y);
						
					}
				}
				
		  private function ovalHit(pos:int):void{
				switch(pos){
					case 1:
						connectiveLineForOval(oval, pointer1);
						break;
					}
				}
				
				
				
		  private function fireOnce(pos:Number):void {
                    trace(ed.x);
					this.posite = pos;
			        trace('Index = ' + posite);
					// ничего не изменилось, просто выходим из функции-сеттера
						if (posite == 1){
								ovalP.x = oval.x;
								ovalP.y = oval.y;
								trace('A = ' + pointer1.toString()); 
								counter.push(1);
								counter.length = 1;
								paint(1);
							 }
						 
						 else if (posite == 2 && counter[0]) {
							trace('B = ' + pointer2.toString());	
							connectiveLine(pointer1, pointer2);
							counter.push(2);
							counter.length = 2;
							paint(2);
						 }
						 
						 else if (posite == 3 && counter[1]){
							trace('C = ' + pointer3.toString());	
							connectiveLine(pointer2, pointer3);
							counter.push(3);
							counter.length = 3;
							paint(3);
						 }
						 
						 else if (posite == 4 && counter[2]){
							trace('D = ' + pointer4.toString());	
							connectiveLine(pointer3, pointer4);
							counter.push(4);
							counter.length = 4;
							paint(4);
						 }
						 
						 
						 else if (posite == 5 && counter[3]){
							trace('E = ' + pointer5.toString());	
							connectiveLine(pointer4, pointer5);
							counter.push('done');
							counter.length = 5;
							paint(5);
						 } 
						 
						 else {
							 posite = 0;
						 }
	
           }

	}
	
}


	







	
	
	








 




