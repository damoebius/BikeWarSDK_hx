package com.tamina.bikewar.data;


class TurnMessage 
{

	public var playerId:String;
	public var data:MapData;
	
	public function new(playerId:String, data:MapData)
	{
		this.playerId = playerId;
		this.data = data;
	}
	
}