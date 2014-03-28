package com.tamina.bikewar.data;

class PlayerResult {

    public var player:Player;
    public var score:Int;

    public function new(player:Player) {
        this.player = player;
        this.score = 0;
    }
}
