package com.tamina.bikewar.game;
import com.tamina.bikewar.data.Path;
import com.tamina.bikewar.core.PathFinder;
import com.tamina.bikewar.data.MapData;
import org.tamina.geom.Junction;
import com.tamina.bikewar.data.Truck;
import org.tamina.geom.Point;
import com.tamina.bikewar.data.BikeStation;
import com.tamina.bikewar.data.Trend;

/**
 * Classe utilitaire
 * @class GameUtils
 */
class GameUtils {

    /**
	 * Indique le nombre de tour necessaire à un camion pour rejoindre une station
	 * @method getTravelDuration
	 * @param	source {Truck} le camion
	 * @param   target {BikeStation} la station de destination
	 * @return	result {Int} le nombre de tour
	 * @static
	 */
    public static function getTravelDuration(source:Truck, target:BikeStation):Int{
        var result:Int = 1000;
        result = Math.ceil( getDistanceBetween( source.position, target.position) / Game.TRUCK_SPEED);
        trace(result);
        return result;
    }

    /**
	 * Détermine la distance qui sépare deux Points en pixel
	 * @method getDistanceBetween
	 * @param	p1 {Point} le point d'origine
	 * @param   p2 {Point} le point de destination
	 * @return	result {Int} le nombre de pixel
	 * @static
	 */
    public static function getDistanceBetween( p1:Point, p2:Point ):Float
    {
        return Math.sqrt( Math.pow( ( p2.x - p1.x ), 2 ) + Math.pow( ( p2.y - p1.y ), 2 ) );
    }

/**
	 * Si la station se trouve dans sa zone optimale
	 * @method hasStationEnoughBike
	 * @param	station {BikeStation} la station
	 * @return	result {Bool}
	 * @static
	 */
    public static function hasStationEnoughBike(station:BikeStation):Bool{
        return (station.bikeNum > station.slotNum/4 && station.bikeNum < station.slotNum/4*3);
    }

    /**
	 * Récupere le chemin le plus court entre deux stations
	 * @method getPath
	 * @param	fromStation {BikeStation} la station d'origine
	 * @param   toStation {BikeStation} la station de destination
	 * @param   map {MapData} la map
	 * @return	result {Path} le chemin
	 * @static
	 */
    public static function getPath(fromStation:BikeStation,toStation:BikeStation, map:MapData):Path{
        var p = new PathFinder();
        return p.getPath(fromStation,toStation,map);
    }

    public static function getCurrentRoundedDate():Date{
        var now = Date.now();
        var minutes = now.getMinutes();
        minutes = Math.floor(  minutes * 4 / 60 ) * 15;
        trace(now.getMinutes());
        trace(minutes);
        return Date.fromTime(  now.getTime() - (now.getMinutes() - minutes)*1000*60 - now.getSeconds()*1000);
    }

     /**
	 * Indique la tendance d'une station à un instant particulier
	 * @method getBikeStationTrend
	 * @param	target {BikeStation} la station
	 * @param   time {Date} l'heure de la journée
	 * @return	result {Trend} la tendance
	 * @static
	 */
    public static function getBikeStationTrend(target:BikeStation, time:Date ):Trend{
        var currentIndex:Int = time.getHours() * 4 +  Math.floor(  time.getMinutes() * 4 / 60 ) ;
        var nextIndex:Int = currentIndex + 1;
        if(nextIndex + 1 > target.profile.length){
            nextIndex = 0;
        }
        return target.profile[nextIndex] - target.profile[currentIndex];
    }

}
