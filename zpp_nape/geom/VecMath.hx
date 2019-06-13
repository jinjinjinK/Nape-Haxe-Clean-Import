package zpp_nape.geom;
import zpp_nape.util.Math.ZPP_Math;
#if nape_swc@:keep #end
class ZPP_VecMath{
    public static#if NAPE_NO_INLINE#else inline #end
    function vec_dsq(ax:Float,ay:Float,bx:Float,by:Float):Float{
        var dx:Float=0.0;
        var dy:Float=0.0;
        {
            dx=ax-bx;
            dy=ay-by;
        };
        return(dx*dx+dy*dy);
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function vec_distance(ax:Float,ay:Float,bx:Float,by:Float):Float{
        var dx:Float=0.0;
        var dy:Float=0.0;
        {
            dx=ax-bx;
            dy=ay-by;
        };
        return ZPP_Math.sqrt((dx*dx+dy*dy));
    }
}
