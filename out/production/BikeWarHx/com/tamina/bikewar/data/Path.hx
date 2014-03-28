package com.tamina.bikewar.data;
import org.tamina.geom.Junction;
class Path {

    public var length(get, null):Int;

    private var _content:Array<Junction>;

    public function new(?content:Array<Junction>) {
        if (content == null) {
            _content = new Array<Junction>();
        } else {
            _content = content;
        }
    }

    public static function contains(item:Junction, list:Array<Path>):Bool{
        var result:Bool = false;
        for(i in 0...list.length){
            if( list[i].hasItem(item)){
                result = true;
                break;
            }
        }
        return result;
    }

    public function getLastItem():Junction {
        return _content[_content.length - 1];
    }

    public function hasItem(item:Junction):Bool {
        var result = false;
        for (i in 0..._content.length) {
            if (item.id == _content[i].id) {
                result = true;
                break;
            }
        }
        return result;
    }

    public function getGuide():Array<Float>{
        var result = new Array<Float>();
        for(i in 0..._content.length){
            result.push(_content[i].x - 8);
            result.push(_content[i].y - 8);
        }
        return result;
    }

    public function getItemAt(index:Int):Junction {
        return _content[index];
    }

    public function push(item:Junction):Void {
        _content.push(item);
    }

    public function remove(item:Junction):Bool {
        return _content.remove(item);
    }

    public function copy():Path {
        return new Path(_content.copy());
    }

    private function get_length():Int {
        return _content.length;
    }
}
