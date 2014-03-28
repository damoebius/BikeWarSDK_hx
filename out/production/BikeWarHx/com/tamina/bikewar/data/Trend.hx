package com.tamina.bikewar.data;
enum Trend {
     DECREASE;
     INCREASE;
     STABLE;
}

class Trends {
    public static function fromInt(value:Int):Trend {
        var result:Trend = Trend.STABLE;
        if( value > 0) {
            result = Trend.INCREASE;
        } else if(value == 0){
            result = Trend.STABLE;
        } else {
            result = Trend.DECREASE;
        }
        return result;
    }
}