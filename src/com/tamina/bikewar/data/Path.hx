package com.tamina.bikewar.data;
import org.tamina.geom.Junction;

/**
 * Un Chemin, ensemble de Junction
 * @class Path
 * @constructor
 */
class Path {

    /**
	 * La longueur du Path, le nombre de Junction
	 * @property length
	 * @type Int
	 */
    public var length(get, null):Int;

    private var _content:Array<Junction>;

    public function new(?content:Array<Junction>) {
        if (content == null) {
            _content = new Array<Junction>();
        } else {
            _content = content;
        }
    }

/**
	 * une Junction est présente dans une liste de Path
	 * @method contains
	 * @param	item {Junction} la Junction ciblée
	 * @param   list {Array<Path>} la liste de Path à vérifier
	 * @return	{Bool}
	 * @static
	 */
    public static function contains(item:Junction, list:Array<Path>):Bool{
        var result:Bool = false;
        for(i in 0...list.length){
            if( list[i].hasItem(item)){
                result = true;
                break;
            }
        }
        return result;
    }

    /**
	 * Retourne le dernier élement du Path
	 * @method getLastItem
	 * @return	result {Junction}
	 */
    public function getLastItem():Junction {
        return _content[_content.length - 1];
    }

    /**
	 * Si une Junction est présente dans le Path
	 * @method hasItem
	 * @param	item {Junction} la Junction ciblée
	 * @return	result {Junction}
	 */
    public function hasItem(item:Junction):Bool {
        var result = false;
        for (i in 0..._content.length) {
            if (item.id == _content[i].id) {
                result = true;
                break;
            }
        }
        return result;
    }


    public function getGuide():Array<Float>{
        var result = new Array<Float>();
        for(i in 0..._content.length){
            result.push(_content[i].x - 8);
            result.push(_content[i].y - 8);
        }
        return result;
    }

    /**
	 * Retourne la Junction à l'index indiqué
	 * @method getItemAt
	 * @param	index {Int}
	 * @return	result {Junction}
	 */
    public function getItemAt(index:Int):Junction {
        return _content[index];
    }

    /**
	 * Ajoute une Junction
	 * @method push
	 * @param	item {Junction}
	 */
    public function push(item:Junction):Void {
        _content.push(item);
    }

    /**
	 * Supprime une Junction
	 * @method remove
	 * @param	item {Junction}
	 */
    public function remove(item:Junction):Bool {
        return _content.remove(item);
    }

    /**
	 * Duplique le Path
	 * @method copy
	 * @return {Path}
	 */
    public function copy():Path {
        return new Path(_content.copy());
    }

    private function get_length():Int {
        return _content.length;
    }
}
