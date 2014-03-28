package ;


import com.tamina.bikewar.data.TurnResult;
import com.tamina.bikewar.data.TurnMessage;
import com.tamina.bikewar.data.Order;
import com.tamina.bikewar.data.MapData;


/**
 * Classe de base des IA
 * @class WorkerIA
 */
class WorkerIA
{

	public static var instance:WorkerIA;

    /**
	 * L'id de l'IA
	 * @property id
	 * @type String
	 */
	public var id:String;

    /**
	 * Le nom de l'IA
	 * @property name
	 * @type String
	 */
	public var name:String;

    /**
	 * Le message à sortir dans la console à la fin du tour
	 * @property debugMessage
	 * @type String
	 */
	public var debugMessage:String;
	public var script:String;
	

	public function new(name:String = "")
	{
		this.name = name;
		this.debugMessage = "";
	}
	
	public static function __init__(){
	   untyped __js__("onmessage = WorkerIA.prototype.messageHandler");
	}

    /**
	 * Cette méthode est appelée par le système tout les tours
	 * @method getOrders
	 * @param	context {MapData} l'ensemble des données de la partie
	 * @return	result {Array<Order>} la liste des ordres à exécuter ce tour
	 */
	public function getOrders( context:MapData ):Array<Order>
	{
		var result:Array<Order> = new Array<Order>();
		return result;
	}
	
	private function messageHandler( event : Dynamic ) : Void {
		if (event.data != null) {
			var turnMessage:TurnMessage = event.data;
			instance.id = turnMessage.playerId;
            var orders:Array<Order> = null;
            var msg:String = instance.debugMessage;
            try{
                orders =  instance.getOrders( turnMessage.data );
            } catch (e:Dynamic) {
                msg = Std.string(e);
            }
			this.postMessage( new TurnResult(orders, msg) );
		} else {
			this.postMessage("data null");
		}
		
	}
	
	private function postMessage( message : Dynamic ) : Void {
		
	}
	
}