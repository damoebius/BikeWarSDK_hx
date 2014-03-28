package com.tamina.bikewar.data;

import org.tamina.utils.UID;
/**
 * Model : IA
 */
class Player {
	

	/**
	 * le nom du robot
	 * @internal
	 */
	public var name:String;
	/**
	 * identifiant unique
	 * @internal
	 */
	public var id:String;
	/**
	 * le script JS
	 * @internal
	 */
	public var script:String;

    public var color:String;
	
	/**
	 * Constructeur
	 * @param	name
	 * @param	color
	 * @param	script
	 */
	public function new(name:String = "", script:String="", color:String="")
	{
		this.name = name;
		this.script = script;
        this.color = color;
		this.id = Std.string( UID.getUID() );
	}
	
	/**
	 * @inheritDoc
	 * @param	context
	 * @return
	 */
	public function getOrders( map:MapData ):Array<Order>
	{
		var result:Array<Order> = new Array<Order>();
		return result;
	}
		
}
