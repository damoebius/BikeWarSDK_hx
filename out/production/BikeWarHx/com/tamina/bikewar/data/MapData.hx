package com.tamina.bikewar.data;
import org.tamina.geom.Junction;

/**
 * La Map
 * <br/> Contient l'ensemble des données de la partie
 * @class MapData
 * @constructor
 */
class MapData {

    /**
	 * La liste des joueurs
	 * @property players
	 * @type Array<Player>
	 */
    public var players:Array<Player>;

    /**
	 * La liste des stations de vélo
	 * @property stations
	 * @type Array<BikeStation>
	 */
    public var stations:Array<BikeStation>;

    /**
	 * La liste des camions
	 * @property trucks
	 * @type Array<Truck>
	 */
    public var trucks:Array<Truck>;

    /**
	 * La date courante
	 * @property currentTime
	 * @type Date
	 */
    public var currentTime:Date;

    /**
	 * La liste des routes
	 * @property roads
	 * @type Array<Junction>
	 */
    public var roads:Array<Junction>;

    public function new() {
        players = new Array<Player>();
        stations = new Array<BikeStation>();
        trucks = new Array<Truck>();
        roads = new Array<Junction>();
    }
}
