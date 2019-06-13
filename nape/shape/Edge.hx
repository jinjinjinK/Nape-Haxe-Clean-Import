package nape.shape;
import nape.geom.Vec2;
import nape.shape.Polygon;
import zpp_nape.geom.Vec2;
import zpp_nape.shape.Edge;
import zpp_nape.shape.Polygon;
/**
 * Edge class providing internal details of Polygon.
 */
@:final#if nape_swc@:keep #end
class Edge{
    /**
     * @private
     */
    public var zpp_inner:ZPP_Edge=null;
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Edge.internal)throw "Error: Cannot instantiate an Edge derp!";
        #end
    }
    /**
     * Reference to Polygon this Edge belongs to.
     */
    #if nape_swc@:isVar #end
    public var polygon(get_polygon,never):Polygon;
    inline function get_polygon():Polygon{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        #end
        return zpp_inner.polygon.outer_zn;
    }
    /**
     * Normal of edge in local coordinates.
     * <br/><br/>
     * This Vec2 is immutable.
     */
    #if nape_swc@:isVar #end
    public var localNormal(get_localNormal,never):Vec2;
    inline function get_localNormal():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        #end
        if(zpp_inner.wrap_lnorm==null)zpp_inner.getlnorm();
        return zpp_inner.wrap_lnorm;
    }
    /**
     * Normal of edge in world coordinates.
     * <br/><br/>
     * This Vec2 is immutable, and may be accessed even if the related Polygon
     * is not part of a Body but queries to its values will result in a debug
     * build error.
     */
    #if nape_swc@:isVar #end
    public var worldNormal(get_worldNormal,never):Vec2;
    inline function get_worldNormal():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        #end
        if(zpp_inner.wrap_gnorm==null)zpp_inner.getgnorm();
        return zpp_inner.wrap_gnorm;
    }
    /**
     * Length of edge.
     */
    #if nape_swc@:isVar #end
    public var length(get_length,never):Float;
    inline function get_length():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        #end
        zpp_inner.polygon.validate_laxi();
        return zpp_inner.length;
    }
    /**
     * Local projection of polygon onto edge axis.
     */
    #if nape_swc@:isVar #end
    public var localProjection(get_localProjection,never):Float;
    inline function get_localProjection():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        #end
        zpp_inner.polygon.validate_laxi();
        return zpp_inner.lprojection;
    }
    /**
     * World projection of polygon to edge axis.
     * <br/><br/>
     * This value can only be accessed if related Polygon is part of a Body.
     */
    #if nape_swc@:isVar #end
    public var worldProjection(get_worldProjection,never):Float;
    inline function get_worldProjection():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        if(zpp_inner.polygon.body==null)throw "Error: Edge world projection only makes sense for Polygons contained within a rigid body";
        #end
        zpp_inner.polygon.validate_gaxi();
        return zpp_inner.gprojection;
    }
    /**
     * Reference to first local vertex for edge.
     */
    #if nape_swc@:isVar #end
    public var localVertex1(get_localVertex1,never):Vec2;
    inline function get_localVertex1():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        #end
        zpp_inner.polygon.validate_laxi();
        return zpp_inner.lp0.wrapper();
    }
    /**
     * Reference to second local vertex for edge.
     */
    #if nape_swc@:isVar #end
    public var localVertex2(get_localVertex2,never):Vec2;
    inline function get_localVertex2():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        #end
        zpp_inner.polygon.validate_laxi();
        return zpp_inner.lp1.wrapper();
    }
    /**
     * Reference to first world vertex for edge.
     */
    #if nape_swc@:isVar #end
    public var worldVertex1(get_worldVertex1,never):Vec2;
    inline function get_worldVertex1():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        #end
        zpp_inner.polygon.validate_gaxi();
        return zpp_inner.gp0.wrapper();
    }
    /**
     * Reference to second world vertex for edge.
     */
    #if nape_swc@:isVar #end
    public var worldVertex2(get_worldVertex2,never):Vec2;
    inline function get_worldVertex2():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.polygon==null)throw "Error: Edge not current in use";
        #end
        zpp_inner.polygon.validate_gaxi();
        return zpp_inner.gp1.wrapper();
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(zpp_inner.polygon==null)return "Edge(object-pooled)";
        else if(zpp_inner.polygon.body==null){
            zpp_inner.polygon.validate_laxi();
            return "{ localNormal : "+("{ x: "+zpp_inner.lnormx+" y: "+zpp_inner.lnormy+" }")+" }";
        }
        else{
            zpp_inner.polygon.validate_gaxi();
            return "{ localNormal : "+("{ x: "+zpp_inner.lnormx+" y: "+zpp_inner.lnormy+" }")+" worldNormal : "+("{ x: "+zpp_inner.gnormx+" y: "+zpp_inner.gnormy+" }")+" }";
        }
    }
}
