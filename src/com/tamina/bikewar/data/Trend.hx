package com.tamina.bikewar.data;

/**
 * Tendance d'une Station
 * @class Trend
 */
@:enum abstract Trend(Int) from Int to Int {

    /**
	 * Décroissante
	 * @property DECREASE
	 * @type Int
	 * @default -1
	 * @static
	 */
     var DECREASE = -1;

    /**
	 * Croissante
	 * @property INCREASE
	 * @type Int
	 * @default 1
	 * @static
	 */
     var INCREASE = 1;

    /**
	 * Stable
	 * @property STABLE
	 * @type Int
	 * @default 0
	 * @static
	 */
     var STABLE = 0;
}