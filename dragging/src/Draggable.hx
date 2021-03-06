//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

import flambe.Component;
import flambe.display.Sprite;
import flambe.Entity;
import flambe.input.MouseCursor;
import flambe.input.PointerEvent;
import flambe.math.Point;
import flambe.System;
import flambe.util.SignalConnection;

class Draggable extends Component
{
    public function new ()
    {
    }

    private function onPointerDown (event :PointerEvent)
    {
        var sprite = owner.get(Sprite);
        _offset = new Point(event.viewX - sprite.x._, event.viewY - sprite.y._);

        _dragging = true;
        System.mouse.cursor = Button;
    }

    override public function onUpdate (dt :Float)
    {
        if (_dragging) {
            if (System.pointer.isDown()) {
                var sprite = owner.get(Sprite);
                sprite.setXY(System.pointer.x - _offset.x, System.pointer.y - _offset.y);
            } else {
                _dragging = false;
                System.mouse.cursor = Default;
            }
        }
    }

    override public function onAdded ()
    {
        _connection = owner.get(Sprite).pointerDown.connect(onPointerDown);
    }

    override public function onRemoved ()
    {
        _connection.dispose();
    }

    private var _connection :SignalConnection;
    private var _dragging :Bool;
    private var _offset :Point;
}
