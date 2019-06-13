package nape.geom;
import nape.geom.Vec2;
import zpp_nape.geom.GeomPoly.ZPP_GeomVertexIterator;
import zpp_nape.geom.Vec2;
/**
 * Haxe compatible iterator over vertices of GeomPoly.
 * <br/><br/>
 * Vec2's intrinsically tied to the vertices are exposed through
 * the iterator which does not modify the state of the polygon.
 */
#if nape_swc@:keep #end
class GeomVertexIterator{
    /**
     * @private
     */
    public var zpp_inner:ZPP_GeomVertexIterator;
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_GeomVertexIterator.internal){
            throw "Error: Cannot instantiate GeomVertexIterator";
        }
        #end
    }
    /**
     * Check if there are any vertices remaining.
     *
     * @return True if there are more vertices to iterate over.
     */
    public function hasNext():Bool{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner==null){
            throw "Error: Iterator has been disposed";
        }
        #end
        var ret=zpp_inner.ptr!=zpp_inner.start||zpp_inner.first;
        zpp_inner.first=false;
        if(!ret){
            {
                var o=zpp_inner;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        o!=null;
                    };
                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_GeomVertexIterator"+", in obj: "+"zpp_inner"+")");
                    #end
                };
                o.free();
                o.next=ZPP_GeomVertexIterator.zpp_pool;
                ZPP_GeomVertexIterator.zpp_pool=o;
                #if NAPE_POOL_STATS ZPP_GeomVertexIterator.POOL_CNT++;
                ZPP_GeomVertexIterator.POOL_SUB++;
                #end
            };
        }
        return ret;
    }
    /**
     * Return next vertex in list.
     * <br/><br/>
     * The vertex is represented by an intrinsically linked Vec2
     * unique to that vertex, which cannot be diposed of.
     *
     * @return The next vertex in iteration.
     */
    public function next():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner==null){
            throw "Error: Iterator has been disposed";
        }
        #end
        var ret=zpp_inner.ptr.wrapper();
        zpp_inner.ptr=if(zpp_inner.forward)zpp_inner.ptr.next else zpp_inner.ptr.prev;
        return ret;
    }
}
