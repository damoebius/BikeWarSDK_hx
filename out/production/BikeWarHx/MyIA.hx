package ;


import com.tamina.bikewar.game.GameUtils;
import com.tamina.bikewar.data.UnLoadingOrder;
import com.tamina.bikewar.game.Game;
import com.tamina.bikewar.data.LoadingOrder;
import com.tamina.bikewar.data.MoveOrder;
import com.tamina.bikewar.data.Order;
import com.tamina.bikewar.data.MapData;

/**
 * BikeWar Haxe SDK
 * <br/>http://www.codeofwar.net
 * <br/>MyIA est une IA de test prête à l'emploi mais pas très futée
 * @module BikeWarSDK
 * @class MyIA
 * @requires taminahx https://github.com/damoebius/taminahx
 *
 */
class MyIA extends WorkerIA {

    public static function main():Void {
        WorkerIA.instance = new MyIA();
    }

    private var _turnNum:Int = 1;
    private var _movingTruckId:Array<Float>;


     /**
	 * Cette méthode est appelée par le système tout les tours
	 * @method getOrders
	 * @param	context {MapData} l'ensemble des données de la partie
	 * @return	result {Array<Order>} la liste des ordres à exécuter ce tour
	 */
    override public function getOrders(context:MapData):Array<Order> {
        var result:Array<Order> = new Array<Order>();
        for (i in 0...context.trucks.length) {
            var truck = context.trucks[i];
            if (truck.owner.id == this.id && truck.currentStation != null) {
                if (Lambda.has(_movingTruckId, truck.id)) {
                    _movingTruckId.remove(truck.id);
                    if ( truck.currentStation.bikeNum < truck.currentStation.slotNum/4) {
                      if(truck.bikeNum > 0){
                          result.push(new UnLoadingOrder(truck.id, truck.currentStation.id, 1));
                      }
                    } else if(truck.currentStation.bikeNum > truck.currentStation.slotNum/4*3){
                        if(truck.bikeNum < Game.TRUCK_NUM_SLOT){
                            result.push(new LoadingOrder(truck.id, truck.currentStation.id, 1));
                        }
                    } else if(GameUtils.hasStationEnoughBike(truck.currentStation)){
                        if(truck.bikeNum < Game.TRUCK_NUM_SLOT){
                            result.push(new LoadingOrder(truck.id, truck.currentStation.id, 1));
                        }
                    }
                } else {
                    _movingTruckId.push(truck.id);
                    result.push(new MoveOrder( truck.id, context.stations[ Math.round(Math.random() * context.stations.length)].id ));
                }

            }  else {
                //debugMessage = "travelling...";
            }

        }
        _turnNum++;
        return result;
    }

    public function new() {
        super();
        _movingTruckId = new Array<Float>();
    }


}