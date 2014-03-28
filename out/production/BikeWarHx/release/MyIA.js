(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.indexOf = function(a,obj,i) {
	var len = a.length;
	if(i < 0) {
		i += len;
		if(i < 0) i = 0;
	}
	while(i < len) {
		if(a[i] === obj) return i;
		i++;
	}
	return -1;
};
HxOverrides.remove = function(a,obj) {
	var i = HxOverrides.indexOf(a,obj,0);
	if(i == -1) return false;
	a.splice(i,1);
	return true;
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Lambda = function() { };
Lambda.__name__ = true;
Lambda.has = function(it,elt) {
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		if(x == elt) return true;
	}
	return false;
};
Math.__name__ = true;
var WorkerIA = function(name) {
	if(name == null) name = "";
	this.name = name;
	this.debugMessage = "";
};
WorkerIA.__name__ = true;
WorkerIA.prototype = {
	getOrders: function(context) {
		var result = new Array();
		return result;
	}
	,messageHandler: function(event) {
		if(event.data != null) {
			var turnMessage = event.data;
			WorkerIA.instance.id = turnMessage.playerId;
			var orders = null;
			var msg = WorkerIA.instance.debugMessage;
			try {
				orders = WorkerIA.instance.getOrders(turnMessage.data);
			} catch( e ) {
				msg = Std.string(e);
			}
			this.postMessage(new com.tamina.bikewar.data.TurnResult(orders,msg));
		} else this.postMessage("data null");
	}
	,postMessage: function(message) {
	}
};
var MyIA = function() {
	this._turnNum = 1;
	WorkerIA.call(this);
	this._movingTruckId = new Array();
};
MyIA.__name__ = true;
MyIA.main = function() {
	WorkerIA.instance = new MyIA();
};
MyIA.__super__ = WorkerIA;
MyIA.prototype = $extend(WorkerIA.prototype,{
	getOrders: function(context) {
		var result = new Array();
		var _g1 = 0;
		var _g = context.trucks.length;
		while(_g1 < _g) {
			var i = _g1++;
			var truck = context.trucks[i];
			if(truck.owner.id == this.id && truck.currentStation != null) {
				if(Lambda.has(this._movingTruckId,truck.id)) {
					HxOverrides.remove(this._movingTruckId,truck.id);
					if(truck.currentStation.bikeNum < truck.currentStation.slotNum / 4) {
						if(truck.bikeNum > 0) result.push(new com.tamina.bikewar.data.UnLoadingOrder(truck.id,truck.currentStation.id,1));
					} else if(truck.currentStation.bikeNum > truck.currentStation.slotNum / 4 * 3) {
						if(truck.bikeNum < com.tamina.bikewar.game.Game.TRUCK_NUM_SLOT) result.push(new com.tamina.bikewar.data.LoadingOrder(truck.id,truck.currentStation.id,1));
					} else if(com.tamina.bikewar.game.GameUtils.hasStationEnoughBike(truck.currentStation)) {
						if(truck.bikeNum < com.tamina.bikewar.game.Game.TRUCK_NUM_SLOT) result.push(new com.tamina.bikewar.data.LoadingOrder(truck.id,truck.currentStation.id,1));
					}
				} else {
					this._movingTruckId.push(truck.id);
					result.push(new com.tamina.bikewar.data.MoveOrder(truck.id,context.stations[Math.round(Math.random() * context.stations.length)].id));
				}
			} else {
			}
		}
		this._turnNum++;
		return result;
	}
});
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var com = {};
com.tamina = {};
com.tamina.bikewar = {};
com.tamina.bikewar.core = {};
com.tamina.bikewar.core.PathFinder = function() {
	this._inc = 0;
	this._paths = new Array();
};
com.tamina.bikewar.core.PathFinder.__name__ = true;
com.tamina.bikewar.core.PathFinder.prototype = {
	getPath: function(fromStation,toStation,map) {
		console.log(fromStation.id + " to " + toStation.id);
		this._map = map;
		this._source = this.getJunctionByStation(fromStation);
		this._target = this.getJunctionByStation(toStation);
		var p = new com.tamina.bikewar.data.Path();
		p.push(this._source);
		this._paths.push(p);
		var startDate = new Date();
		this.find();
		console.log("end finding : " + (new Date().getTime() - startDate.getTime()));
		return this._result;
	}
	,getJunctionByStation: function(station) {
		var result = null;
		var _g1 = 0;
		var _g = this._map.roads.length;
		while(_g1 < _g) {
			var i = _g1++;
			var j = this._map.roads[i];
			if(j.x == station.position.x && j.y == station.position.y) {
				result = j;
				break;
			}
		}
		return result;
	}
	,find: function() {
		var result = false;
		this._inc++;
		var paths = this._paths.slice();
		var _g1 = 0;
		var _g = paths.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.checkPath(paths[i])) {
				result = true;
				break;
			}
		}
		if(!result && this._inc < 50) this.find();
	}
	,checkPath: function(target) {
		var result = false;
		var currentJunction = target.getLastItem();
		var _g1 = 0;
		var _g = currentJunction.links.length;
		while(_g1 < _g) {
			var i = _g1++;
			var nextJunction = currentJunction.links[i];
			if(nextJunction.id == this._target.id) {
				result = true;
				var p = target.copy();
				p.push(nextJunction);
				this._result = p;
				break;
			} else if(!com.tamina.bikewar.data.Path.contains(nextJunction,this._paths)) {
				var p1 = target.copy();
				p1.push(nextJunction);
				this._paths.push(p1);
			}
		}
		HxOverrides.remove(this._paths,target);
		return result;
	}
	,checkPathDirection: function(currentJunction) {
		var result = true;
		if(this._inc > 2) {
			if(this._source.x < this._target.x && currentJunction.x < this._source.x) result = false; else if(this._source.x > this._target.x && currentJunction.x > this._target.x) result = false;
		}
		return result;
	}
};
com.tamina.bikewar.data = {};
com.tamina.bikewar.data.BikeStation = function() {
	this.name = "";
	this.profile = new Array();
	this.id = org.tamina.utils.UID.getUID();
};
com.tamina.bikewar.data.BikeStation.__name__ = true;
com.tamina.bikewar.data.Order = function(truckId,targetStationId,type) {
	this.truckId = truckId;
	this.targetStationId = targetStationId;
	this.type = type;
};
com.tamina.bikewar.data.Order.__name__ = true;
com.tamina.bikewar.data.LoadingOrder = function(truckId,targetStationId,bikeNum) {
	this.bikeNum = 0;
	com.tamina.bikewar.data.Order.call(this,truckId,targetStationId,com.tamina.bikewar.data.OrderType.LOAD);
	this.bikeNum = bikeNum;
};
com.tamina.bikewar.data.LoadingOrder.__name__ = true;
com.tamina.bikewar.data.LoadingOrder.__super__ = com.tamina.bikewar.data.Order;
com.tamina.bikewar.data.LoadingOrder.prototype = $extend(com.tamina.bikewar.data.Order.prototype,{
});
com.tamina.bikewar.data.MapData = function() {
	this.players = new Array();
	this.stations = new Array();
	this.trucks = new Array();
	this.roads = new Array();
};
com.tamina.bikewar.data.MapData.__name__ = true;
com.tamina.bikewar.data.MoveOrder = function(truckId,targetStationId) {
	com.tamina.bikewar.data.Order.call(this,truckId,targetStationId,com.tamina.bikewar.data.OrderType.MOVE);
};
com.tamina.bikewar.data.MoveOrder.__name__ = true;
com.tamina.bikewar.data.MoveOrder.__super__ = com.tamina.bikewar.data.Order;
com.tamina.bikewar.data.MoveOrder.prototype = $extend(com.tamina.bikewar.data.Order.prototype,{
});
com.tamina.bikewar.data.OrderType = function() { };
com.tamina.bikewar.data.OrderType.__name__ = true;
com.tamina.bikewar.data.Path = function(content) {
	if(content == null) this._content = new Array(); else this._content = content;
};
com.tamina.bikewar.data.Path.__name__ = true;
com.tamina.bikewar.data.Path.contains = function(item,list) {
	var result = false;
	var _g1 = 0;
	var _g = list.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(list[i].hasItem(item)) {
			result = true;
			break;
		}
	}
	return result;
};
com.tamina.bikewar.data.Path.prototype = {
	getLastItem: function() {
		return this._content[this._content.length - 1];
	}
	,hasItem: function(item) {
		var result = false;
		var _g1 = 0;
		var _g = this._content.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(item.id == this._content[i].id) {
				result = true;
				break;
			}
		}
		return result;
	}
	,getGuide: function() {
		var result = new Array();
		var _g1 = 0;
		var _g = this._content.length;
		while(_g1 < _g) {
			var i = _g1++;
			result.push(this._content[i].x - 8);
			result.push(this._content[i].y - 8);
		}
		return result;
	}
	,getItemAt: function(index) {
		return this._content[index];
	}
	,push: function(item) {
		this._content.push(item);
	}
	,remove: function(item) {
		return HxOverrides.remove(this._content,item);
	}
	,copy: function() {
		return new com.tamina.bikewar.data.Path(this._content.slice());
	}
	,get_length: function() {
		return this._content.length;
	}
};
com.tamina.bikewar.data.Player = function(name,script,color) {
	if(color == null) color = "";
	if(script == null) script = "";
	if(name == null) name = "";
	this.name = name;
	this.script = script;
	this.color = color;
	this.id = Std.string(org.tamina.utils.UID.getUID());
};
com.tamina.bikewar.data.Player.__name__ = true;
com.tamina.bikewar.data.Player.prototype = {
	getOrders: function(map) {
		var result = new Array();
		return result;
	}
};
com.tamina.bikewar.data._Trend = {};
com.tamina.bikewar.data._Trend.Trend_Impl_ = function() { };
com.tamina.bikewar.data._Trend.Trend_Impl_.__name__ = true;
com.tamina.bikewar.data.Truck = function(owner,currentStation) {
	this.id = org.tamina.utils.UID.getUID();
	this.owner = owner;
	this.currentStation = currentStation;
	this.position = currentStation.position;
	this.bikeNum = 0;
};
com.tamina.bikewar.data.Truck.__name__ = true;
com.tamina.bikewar.data.TurnMessage = function(playerId,data) {
	this.playerId = playerId;
	this.data = data;
};
com.tamina.bikewar.data.TurnMessage.__name__ = true;
com.tamina.bikewar.data.TurnResult = function(orders,message) {
	if(message == null) message = "";
	this.orders = orders;
	this.consoleMessage = message;
	this.error = "";
};
com.tamina.bikewar.data.TurnResult.__name__ = true;
com.tamina.bikewar.data.UnLoadingOrder = function(truckId,targetStationId,bikeNum) {
	this.bikeNum = 0;
	com.tamina.bikewar.data.Order.call(this,truckId,targetStationId,com.tamina.bikewar.data.OrderType.UNLOAD);
	this.bikeNum = bikeNum;
};
com.tamina.bikewar.data.UnLoadingOrder.__name__ = true;
com.tamina.bikewar.data.UnLoadingOrder.__super__ = com.tamina.bikewar.data.Order;
com.tamina.bikewar.data.UnLoadingOrder.prototype = $extend(com.tamina.bikewar.data.Order.prototype,{
});
com.tamina.bikewar.game = {};
com.tamina.bikewar.game.Game = function() { };
com.tamina.bikewar.game.Game.__name__ = true;
com.tamina.bikewar.game.Game.get_START_POINTS = function() {
	var result = new Array();
	result.push(new org.tamina.geom.Point(100,100));
	result.push(new org.tamina.geom.Point(100,500));
	return result;
};
com.tamina.bikewar.game.GameUtils = function() { };
com.tamina.bikewar.game.GameUtils.__name__ = true;
com.tamina.bikewar.game.GameUtils.getTravelDuration = function(source,target) {
	var result = 1000;
	result = Math.ceil(com.tamina.bikewar.game.GameUtils.getDistanceBetween(source.position,target.position) / com.tamina.bikewar.game.Game.TRUCK_SPEED);
	console.log(result);
	return result;
};
com.tamina.bikewar.game.GameUtils.getDistanceBetween = function(p1,p2) {
	return Math.sqrt(Math.pow(p2.x - p1.x,2) + Math.pow(p2.y - p1.y,2));
};
com.tamina.bikewar.game.GameUtils.hasStationEnoughBike = function(station) {
	return station.bikeNum > station.slotNum / 4 && station.bikeNum < station.slotNum / 4 * 3;
};
com.tamina.bikewar.game.GameUtils.getPath = function(fromStation,toStation,map) {
	var p = new com.tamina.bikewar.core.PathFinder();
	return p.getPath(fromStation,toStation,map);
};
com.tamina.bikewar.game.GameUtils.getCurrentRoundedDate = function() {
	var now = new Date();
	var minutes = now.getMinutes();
	minutes = Math.floor(minutes * 4 / 60) * 15;
	console.log(now.getMinutes());
	console.log(minutes);
	var t = now.getTime() - (now.getMinutes() - minutes) * 1000 * 60 - now.getSeconds() * 1000;
	var d = new Date();
	d.setTime(t);
	return d;
};
com.tamina.bikewar.game.GameUtils.getBikeStationTrend = function(target,time) {
	var currentIndex = time.getHours() * 4 + Math.floor(time.getMinutes() * 4 / 60);
	var nextIndex = currentIndex + 1;
	if(nextIndex + 1 > target.profile.length) nextIndex = 0;
	return target.profile[nextIndex] - target.profile[currentIndex];
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
var org = {};
org.tamina = {};
org.tamina.geom = {};
org.tamina.geom.Point = function(x,y) {
	if(y == null) y = 0;
	if(x == null) x = 0;
	this.x = x;
	this.y = y;
};
org.tamina.geom.Point.__name__ = true;
org.tamina.geom.Junction = function(x,y,id) {
	if(id == null) id = "";
	if(y == null) y = 0;
	if(x == null) x = 0;
	org.tamina.geom.Point.call(this,x,y);
	this.links = new Array();
	this.id = id;
};
org.tamina.geom.Junction.__name__ = true;
org.tamina.geom.Junction.__super__ = org.tamina.geom.Point;
org.tamina.geom.Junction.prototype = $extend(org.tamina.geom.Point.prototype,{
});
org.tamina.utils = {};
org.tamina.utils.UID = function() { };
org.tamina.utils.UID.__name__ = true;
org.tamina.utils.UID.getUID = function() {
	var result = new Date().getTime();
	if(result <= org.tamina.utils.UID._lastUID) result = org.tamina.utils.UID._lastUID + 1;
	org.tamina.utils.UID._lastUID = result;
	return result;
};
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
Math.NaN = Number.NaN;
Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
Math.isFinite = function(i) {
	return isFinite(i);
};
Math.isNaN = function(i1) {
	return isNaN(i1);
};
onmessage = WorkerIA.prototype.messageHandler;
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = ["Date"];
com.tamina.bikewar.data.OrderType.MOVE = "move";
com.tamina.bikewar.data.OrderType.LOAD = "load";
com.tamina.bikewar.data.OrderType.UNLOAD = "unload";
com.tamina.bikewar.data.OrderType.NONE = "none";
com.tamina.bikewar.data._Trend.Trend_Impl_.DECREASE = -1;
com.tamina.bikewar.data._Trend.Trend_Impl_.INCREASE = 1;
com.tamina.bikewar.data._Trend.Trend_Impl_.STABLE = 0;
com.tamina.bikewar.game.Game.GAME_MAX_NUM_TURN = 500;
com.tamina.bikewar.game.Game.GAME_SPEED = 1000;
com.tamina.bikewar.game.Game.TRUCK_SPEED = 60;
com.tamina.bikewar.game.Game.TRUCK_NUM_SLOT = 10;
com.tamina.bikewar.game.Game.MAX_TURN_DURATION = 1000;
com.tamina.bikewar.game.Game.TURN_TIME = 450000;
org.tamina.utils.UID._lastUID = 0;
MyIA.main();
})();
