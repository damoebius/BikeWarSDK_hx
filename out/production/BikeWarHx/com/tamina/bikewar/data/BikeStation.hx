package com.tamina.bikewar.data;
import org.tamina.geom.Junction;
import org.tamina.geom.Point;
import org.tamina.utils.UID;

/**
 * Station de Vélo
 * @class BikeStation
 * @constructor
 */
class BikeStation {

/**
	 * L'id de la station
	 * @property id
	 * @type Float
	 */
    public var id:Float;

/**
	 * Le nombre de vélo
	 * @property bikeNum
	 * @type Int
	 */
    public var bikeNum:Int;

/**
	 * Le nombre d'emplacement pour vélo
	 * @property slotNum
	 * @type Int
	 */
    public var slotNum:Int;

/**
	 * La position de la station sur la Map
	 * @property position
	 * @type Junction
	 */
    public var position:Junction;

/**
	 * Le proprietaire
	 * @property owner
	 * @type Player
	 */
    public var owner:Player;

/**
	 * Le profil de la station.
	 * @property profile le nombre moyen de vélo en station entre 00h00 et 23h45, toutes les 15 minutes.
	 * @type Array<Int>
	 */
    public var profile:Array<Int>;

/**
	 * Le nom de la station
	 * @property name
	 * @type String
	 */
    public var name:String = '';

    public function new() {
        profile = new Array<Int>();
        this.id = UID.getUID();
    }

}
