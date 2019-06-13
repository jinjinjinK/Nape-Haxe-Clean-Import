package zpp_nape;
import nape.callbacks.CbType;
import nape.callbacks.Listener;
import nape.constraint.Constraint;
import nape.dynamics.InteractionGroup;
import nape.phys.Interactor;
import nape.space.Space;
import zpp_nape.callbacks.CbSet;
import zpp_nape.callbacks.CbType;
import zpp_nape.callbacks.Listener;
import zpp_nape.constraint.Constraint;
import zpp_nape.dynamics.InteractionGroup;
import zpp_nape.phys.Interactor;
import zpp_nape.space.Space;
#if nape_swc@:keep #end
class ZPP_ID{
    
    public static var _Constraint:Int=0;
    public static function Constraint(){
        return _Constraint++;
    }
    public static var _Interactor:Int=0;
    public static function Interactor(){
        return _Interactor++;
    }
    public static var _CbType:Int=0;
    public static function CbType(){
        return _CbType++;
    }
    public static var _CbSet:Int=0;
    public static function CbSet(){
        return _CbSet++;
    }
    public static var _Listener:Int=0;
    public static function Listener(){
        return _Listener++;
    }
    public static var _ZPP_SimpleVert:Int=0;
    public static function ZPP_SimpleVert(){
        return _ZPP_SimpleVert++;
    }
    public static var _ZPP_SimpleSeg:Int=0;
    public static function ZPP_SimpleSeg(){
        return _ZPP_SimpleSeg++;
    }
    public static var _Space:Int=0;
    public static function Space(){
        return _Space++;
    }
    public static var _InteractionGroup:Int=0;
    public static function InteractionGroup(){
        return _InteractionGroup++;
    }
}
