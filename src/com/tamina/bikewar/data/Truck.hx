package com.tamina.bikewar.data;
import org.tamina.geom.Point;
import org.tamina.utils.UID;
class Truck {

    public var id:Float;
    public var owner:Player;
    public var bikeNum:Int;
    public var position:Point;
    public var currentStation:BikeStation;

    public function new(owner:Player,currentStation:BikeStation) {
        this.id = UID.getUID();
        this.owner = owner;
        this.currentStation = currentStation;
        this.position = currentStation.position;
        this.bikeNum = 0;
    }
}
