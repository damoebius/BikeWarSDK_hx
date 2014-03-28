package com.tamina.bikewar.data;

/**
 * @internal
 * @author David Mouton
 */

import com.tamina.bikewar.data.Player;

class BattleResult
{
	inline public static var NONE:Int = 0;
	inline public static var LOOSE:Int = 1;
	inline public static var WIN:Int = 2;
	
	public var errorCode:Int;
	public var message:String;
	public var numTurn:Int;
	public var winner:Player;

    private var _playerList:Array<PlayerResult>;
	
	public function new(playerResults:Array<PlayerResult>, numTurn:Int = 0, winner:Player = null, message:String = null, errorCode:Int = 0 )
	{
		this._playerList = playerResults;
		this.numTurn = numTurn;
		this.winner = winner;
		this.message = message;
		this.errorCode = errorCode;
	}
	
}