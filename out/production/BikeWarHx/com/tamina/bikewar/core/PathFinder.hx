package com.tamina.bikewar.core;
import com.tamina.bikewar.data.Path;
import org.tamina.geom.Junction;
import com.tamina.bikewar.data.MapData;
import com.tamina.bikewar.data.BikeStation;

class PathFinder {

    private var _paths:Array<Path>;

    private var _source:Junction;
    private var _target:Junction;
    private var _map:MapData;
    private var _inc:Int = 0;
    private var _result:Path;

    public function new() {
        _paths = new Array<Path>();
    }

    public function getPath(fromStation:BikeStation, toStation:BikeStation, map:MapData):Path {
        trace(fromStation.id + ' to ' + toStation.id);
        _map = map;
        _source = getJunctionByStation(fromStation);
        _target = getJunctionByStation(toStation);

        var p = new Path();
        p.push(_source);
        _paths.push(p);
        var startDate = Date.now();
        find();
        trace('end finding : ' + (Date.now().getTime() - startDate.getTime() ));
        return _result;
    }

    private function getJunctionByStation(station:BikeStation):Junction {
        var result:Junction = null;
        for (i in 0..._map.roads.length) {
            var j = _map.roads[i];
            if (j.x == station.position.x && j.y == station.position.y) {
                result = j;
                break;
            }
        }
        return result;
    }

    private function find():Void {
        var result:Bool = false;
        _inc++;
        var paths = _paths.copy();
        for (i in 0...paths.length) {
            if (checkPath(paths[i])) {
                result = true;
                break;
            }
        }
        if (!result && _inc < 50) {
            find();
        }
    }

    private function checkPath(target:Path):Bool {
        var result:Bool = false;
        var currentJunction = target.getLastItem();
        for (i in 0...currentJunction.links.length) {
            var nextJunction = currentJunction.links[i];
            if (nextJunction.id == _target.id) {
                result = true;
                var p:Path = target.copy();
                p.push(nextJunction);
                _result = p;
                break;
            } else if ( !Path.contains(nextJunction, _paths) ) {
                var p:Path = target.copy();
                p.push(nextJunction);
                _paths.push(p);
            }
        }
        _paths.remove(target);
        return result;
    }

    private function checkPathDirection(currentJunction:Junction):Bool{
        var result:Bool = true;
        if( _inc > 2){
           if( _source.x < _target.x && currentJunction.x< _source.x){
               result = false;
           } else if(_source.x > _target.x && currentJunction.x> _target.x) {
               result = false;
           }
        }
        return result;
    }
}
