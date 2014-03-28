package com.tamina.bikewar.data;

/**
 * @internal
 * @author David Mouton
 */

class TurnMessage 
{

	public var playerId:String;
	public var data:MapData;
	
	/**
	 * Constructeur
	 * @param	playerId
	 * @param	data
	 */
	public function new(playerId:String, data:MapData)
	{
		this.playerId = playerId;
		this.data = data;
	}
	
}