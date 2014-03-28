package com.tamina.bikewar.data;
import org.tamina.geom.Point;
import org.tamina.utils.UID;

/**
 * Camion
 * @class Truck
 */
class Truck {

    /**
	 * L'Id du camion
	 * @property id
	 * @type Float
	 */
    public var id:Float;

/**
	 * Le proprietaire du camion
	 * @property owner
	 * @type Player
	 */
    public var owner:Player;

/**
	 * Le nombre de vélo embarqué
	 * @property bikeNum
	 * @type Int
	 */
    public var bikeNum:Int;

/**
	 * La position du camion
	 * @property position
	 * @type Point
	 */
    public var position:Point;

    /**
	 * Si il s'y trouve, la station actuelle.
	 * @property currentStation
	 * @type BikeStation
	 */
    public var currentStation:BikeStation;

    public function new(owner:Player,currentStation:BikeStation) {
        this.id = UID.getUID();
        this.owner = owner;
        this.currentStation = currentStation;
        this.position = currentStation.position;
        this.bikeNum = 0;
    }
}
