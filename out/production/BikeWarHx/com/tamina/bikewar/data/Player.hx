package com.tamina.bikewar.data;

import org.tamina.utils.UID;
/**
 * Joueur
 * @class Player
 * @constructor
 * @param	name {String}
 * @param	color {String}
 * @param	script {String}
 */
class Player {


/**
	 * Le nom de l'IA
	 * @property name
	 * @type String
	 */
    public var name:String;

    /**
	 * Id de l'IA
	 * @property id
	 * @type String
	 */
    public var id:String;

    public var script:String;

    public var color:String;

    public function new(name:String = "", script:String = "", color:String = "") {
        this.name = name;
        this.script = script;
        this.color = color;
        this.id = Std.string(UID.getUID());
    }

    public function getOrders(map:MapData):Array<Order> {
        var result:Array<Order> = new Array<Order>();
        return result;
    }

}
