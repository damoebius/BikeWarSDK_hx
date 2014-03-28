package com.tamina.bikewar.game;
import org.tamina.geom.Point;

/**
 * Constantes du jeu
 * @class Game
 */
class Game {

    /**
	 * Le nombre maximum de tour
	 * @property GAME_MAX_NUM_TURN
	 * @type Int
	 * @static
	 */
    public static var GAME_MAX_NUM_TURN:Int = 500;

    /**
	 * La vitesse d'execution d'un tour.
	 * @property GAME_SPEED
	 * @type Int
	 * @static
	 */
    public static var GAME_SPEED:Int = 1000;

/**
	 * La vitesse d'un camion
	 * @property TRUCK_SPEED
	 * @type Int
	 * @static
	 */
    public static var TRUCK_SPEED:Int = 60;

/**
	 * La capacité d'un camion
	 * @property TRUCK_NUM_SLOT
	 * @type Int
	 * @static
	 */
    public static var TRUCK_NUM_SLOT:Int = 10;

/**
	 * La durée maximale du tour d'une IA. Si l'IA dépasse cette durée, elle passe en timeout.
	 * @property MAX_TURN_DURATION
	 * @type Int
	 * @static
	 */
    public static var MAX_TURN_DURATION:Int = 1000;

/**
	 * La durée d'un tour en ms. ex 15 minutes/tours
	 * @property TURN_TIME
	 * @type Int
	 * @static
	 */
    public static var TURN_TIME:Int = 1000*30*15;

    private static function get_START_POINTS():Array<Point> {
        var result:Array<Point> = new Array<Point>();
        result.push( new Point(100,100) );
        result.push( new Point(100,500) );
        return result;
    }

    static public var START_POINTS(get_START_POINTS, null):Array<Point>;
}
