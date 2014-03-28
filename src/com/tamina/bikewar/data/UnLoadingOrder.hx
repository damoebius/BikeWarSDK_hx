package com.tamina.bikewar.data;

/**
 * Ordre de déchargement des vélos
 * @class UnLoadingOrder
* @constructor
* @param	truckId  {Float} L'id du camion concerné par cet ordre
* @param	targetStationId {Float} La station ciblée
* @param	bikeNum {Int} Le nombre de vélo à décharger
 */
class UnLoadingOrder extends Order {

    /**
	 * Le nombre de vélo à décharger
	 * @property bikeNum
	 * @type Int
	 */
    public var bikeNum:Int = 0;

    public function new(truckId:Float, targetStationId:Float, bikeNum:Int) {
        super(truckId, targetStationId, OrderType.UNLOAD);
        this.bikeNum = bikeNum;
    }
}
