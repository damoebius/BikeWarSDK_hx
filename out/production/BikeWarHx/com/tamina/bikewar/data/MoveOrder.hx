package com.tamina.bikewar.data;

/**
 * Ordre de déplacement
 * @class MoveOrder
* @constructor
* @param	truckId  {Float} L'id du camion concerné par cet ordre
* @param	targetStationId {Float} La station de destination
 */
class MoveOrder extends Order {

    public function new(truckId:Float, targetStationId:Float) {
        super(truckId, targetStationId, OrderType.MOVE);
    }
}
