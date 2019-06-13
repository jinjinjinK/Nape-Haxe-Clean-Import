package zpp_nape.geom;
import zpp_nape.shape.Shape.ZPP_Shape;
#if nape_swc@:keep #end
class ZPP_Geom{
    public static function validateShape(s:ZPP_Shape){
        if(s.isPolygon())s.polygon.validate_gaxi();
        s.validate_aabb();
        s.validate_worldCOM();
    }
}
