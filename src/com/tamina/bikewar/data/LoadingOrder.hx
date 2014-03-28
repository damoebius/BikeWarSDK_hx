package com.tamina.bikewar.data;

/**
 * Ordre de chargement
 * @class MoveOrder
* @constructor
* @param	truckId  {Float} L'id du camion concerné par cet ordre
* @param	targetStationId {Float} La station de destination
* @param	bikeNum {Int} Le nombre de vélo à charger
 */
class LoadingOrder extends Order {

/**
	 * Le nombre de vélo à charger
	 * @property bikeNum Le nombre de vélo à charger
	 * @type Int
	 */
    public var bikeNum:Int = 0;

    public function new(truckId:Float, targetStationId:Float, bikeNum:Int) {
        super(truckId, targetStationId, OrderType.LOAD);
        this.bikeNum = bikeNum;
    }
}
