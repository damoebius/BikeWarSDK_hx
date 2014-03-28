package com.tamina.bikewar.data;

/**
 * Classe de base des Ordres à éxécuter par le systeme
 * @class Order
 */
class Order {

/**
	 * L'id du camion concerné par cet ordre
	 * @property truckId
	 * @type Float
	 * @static
	 */
    public var truckId:Float;

/**
	 * La station concernée par cet ordre
	 * @property targetStationId
	 * @type Float
	 * @static
	 */
    public var targetStationId:Float;

/**
	 * Le type d'ordre cet ordre. Voir {{#crossLink "OrderType"}} OrderType {{/crossLink}}
	 * @property type
	 * @type String
	 * @static
	 */
    public var type:String;

    public function new(truckId:Float, targetStationId:Float, type:String) {
        this.truckId = truckId;
        this.targetStationId = targetStationId;
        this.type = type;
    }
}
