package zpp_nape;
import nape.callbacks.CbType;
import nape.callbacks.OptionType;
import nape.geom.Vec2;
import zpp_nape.callbacks.CbType;
import zpp_nape.callbacks.OptionType;
import zpp_nape.geom.Vec2;
import zpp_nape.util.Math;
#if nape_swc@:keep #end
class ZPP_Const{
    #if flash public static#if NAPE_NO_INLINE#else inline #end
    function POSINF(){
        return 1.79e+308;
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function NEGINF(){
        return-1.79e+308;
    }
    #else public static#if NAPE_NO_INLINE#else inline #end
    function POSINF(){
        return Math.POSITIVE_INFINITY;
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function NEGINF(){
        return Math.NEGATIVE_INFINITY;
    }
    #end
    public static#if NAPE_NO_INLINE#else inline #end
    var FMAX=1e100;
    #if flash10 public static var vec2vector=Type.getClass(new flash.Vector<Vec2>());
    public static var cbtypevector=Type.getClass(new flash.Vector<CbType>());
    public static var optiontypevector=Type.getClass(new flash.Vector<OptionType>());
    #end
}
