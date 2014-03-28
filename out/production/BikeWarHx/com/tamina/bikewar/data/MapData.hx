package com.tamina.bikewar.data;
import org.tamina.geom.Junction;

/**
 * La Map
 * <br/> Contient l'ensemble des données de la partie
 * @class MapData
 * @constructor
 */
class MapData {

    public var players:Array<Player>;
    public var stations:Array<BikeStation>;
    public var trucks:Array<Truck>;
    public var currentTime:Date;
    public var roads:Array<Junction>;

    public function new() {
        players = new Array<Player>();
        stations = new Array<BikeStation>();
        trucks = new Array<Truck>();
        roads = new Array<Junction>();
    }
}
