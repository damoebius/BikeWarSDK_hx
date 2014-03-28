package com.tamina.bikewar.data;

/**
 * Enumeration des types d'ordres
 * @class OrderType
 */
class OrderType {

    /**
	 * Ordre de déplacement
	 * @property MOVE
	 * @type String
	 */
    public static var MOVE:String = "move";

/**
	 * Ordre de chargement de vélo
	 * @property LOAD
	 * @type String
	 */
    public static var LOAD:String = "load";

/**
	 * Ordre de déchargement de vélo
	 * @property UNLOAD
	 * @type String
	 */
    public static var UNLOAD:String = "unload";

/**
	 * Ordre de rien du tout
	 * @property NONE
	 * @type String
	 */
    public static var NONE:String = "none";
}