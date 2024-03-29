package nape.geom;
import nape.geom.AABB;
import nape.geom.GeomPolyList;
import nape.geom.IsoFunction.IsoFunctionDef;
import nape.geom.Vec2;
import zpp_nape.geom.AABB;
import zpp_nape.geom.MarchingSquares;
import zpp_nape.geom.Vec2;
/**
 * Iso-surface extraction into polygons.
 * <br/><br/>
 * This class, with only one static method provides an interface to
 * an algorithm which will, when given a function mapping each point
 * in a given AABB to a scalar value extract approximated polygons
 * which represent the region of the AABB where the function returns
 * a negative value.
 * <br/><br/>
 * This function could be a mathematical function like the equation of
 * a circle: <code> function (x, y) return (x*x + y*y) - r*r </code>
 * <br/>
 * Or something more practical like the biased alpha value interpolated
 * from a Bitmap:
 * <pre>
 * function (x, y) {
 *    var ix = if (x < 0) 0 else if (x >= bitmap.width - 1) bitmap.width - 2 else Std.int(x);
 *    var iy = if (y < 0) 0 else if (y >= bitmap.height - 1) bitmap.height - 2 else Std.int(y);
 *    var fx = x - ix;
 *    var fy = y - iy;
 *    var gx = 1 - fx;
 *    var gy = 1 - fy;
 *
 *    var a00 = bitmap.getPixel32(ix, iy) >>> 24;
 *    var a01 = bitmap.getPixel32(ix, iy + 1) >>> 24;
 *    var a10 = bitmap.getPixel32(ix + 1, iy) >>> 24;
 *    var a11 = bitmap.getPixel32(ix + 1, iy + 1) >>> 24;
 *
 *    return 0x80 - (gx*gy*a00 + fx*gy*a10 + gx*fy*a01 + fx*fy*a11);
 * }
 * </pre>
 * For 'flash', we must wrap this in an IsoFunction interface to be used
 * by MarchingSquares for performance reasons:
 * <pre>
 * class BitmapIsoFunction implements nape.geom.IsoFunction {
 *     public function iso(x:Float, y:Float):Float {
 *         ...
 *     }
 * }
 * </pre>
 * This function is converted into a set of polygons by sampling along regular
 * grid points, and then recursively interpolating along cell edges based on
 * the function provided to find the point in space along that edge where the
 * function is approximately 0.
 * <br/><br/>
 * From this we generate polygons in each grid cell, which are then by default
 * combined into larger, weakly simply polygons suitable for use in the
 * decomposition routines of GeomPoly like convexDecomposition!
 * <br/><br/>
 * The runtime of the algorithm is O(N+K) for N number of cells and K number
 * of output vertices (A final pass is made to remove unnecessary vertices).
 */
@:final#if nape_swc@:keep #end
class MarchingSquares{
    /**
     * Execute marching squares algorithm over region of space.
     * <br/><br/>
     * We can, optionally provide a subgrid argument which, when non null
     * will invoke this algorithm seperately on each subgrid cell of the region
     * in space, instead of on the entire region at once. This can be very useful
     * as shown in the DestructibleTerrain demo where regions of a terrain are
     * recomputed with marching squares without needing to regenerate the whole
     * of the terrain.
     *
     * @param iso The iso-function defining the regions where polygons should
     *            be extracted, a negative return indicates a region to be extracted.
     *            This function need not be continuous, but if it is continuous
     *            then more accurate results will be given for the same input
     *            parameters.
     * @param bounds The AABB representing the region of space to be converted.
     *               The arguments to the iso-function will be in the same region.
     * @param cellsize The dimensions of each cell used individual polygon extraction.
     *                 Smaller cells will give more accurate results at a greater
     *                 cost permitting smaller features to be extracted.
     * @param quality This is the number of recursive interpolations which will be
     *                performed along cell edges. If the iso-function is not
     *                continuous, then this value should be increased to get better
     *                accuracy. (default 2)
     * @param subgrid When supplied, the region of space will be first subdivided
     *                into cells with these given dimensions, and each cell treated
     *                as a seperate invocation of this method, this value should
     *                obviously be greater than cellsize or it would be a bit
     *                pointless. (default null)
     * @param combine When True, the polygons generated in each cell of the grid
     *                will be combined into the largest possible weakly-simple
     *                polygons representing the same area. These polygons will
     *                always be suitable for decomposition in Nape. (default true)
     * @param output When supplied, GeomPoly will be inserted into the list (via add)
     *               instead of creating a new GeomPolyList object.
     * @return A list of GeomPoly representing the results of the extraction.
     * @throws # If iso, bounds or cellsize argument is null.
     * @throws # If cellsize is disposed, or its components have 0, or negative values.
     * @throws # If quality is less than 0.
     * @throws # If subgrid is not null, but is disposed or has zero or negative
     *           component values.
     */
    static public function run(iso:IsoFunctionDef,bounds:AABB,cellsize:Vec2,quality:Int=2,subgrid:Vec2=null,combine:Bool=true,output:GeomPolyList=null){
        {
            #if(!NAPE_RELEASE_BUILD)
            if(cellsize!=null&&cellsize.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        {
            #if(!NAPE_RELEASE_BUILD)
            if(subgrid!=null&&subgrid.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        #if(!NAPE_RELEASE_BUILD)
        if(iso==null){
            throw "Error: MarchingSquares requires an iso function to operate";
        }
        if(bounds==null){
            throw "Error: MarchingSquares requires an AABB to define bounds of surface extraction";
        }
        if(cellsize==null){
            throw "Error: MarchingSquares requires a Vec2 to define cell size for surface extraction";
        }
        if(cellsize.x<=0||cellsize.y<=0){
            throw "Error: MarchingSquares cannot operate with non-positive cell dimensions";
        }
        if(quality<0){
            throw "Error: MarchingSquares cannot use a negative quality value for interpolation";
        }
        if(subgrid!=null&&(subgrid.x<=0||subgrid.y<=0)){
            throw "Error: MarchingSquares cannot with non-positive sub-grid dimensions";
        }
        #end
        var ret=(output!=null?output:new GeomPolyList());
        if(subgrid==null){
            ZPP_MarchingSquares.run(iso,bounds.x,bounds.y,bounds.max.x,bounds.max.y,cellsize,quality,combine,ret);
        }
        else{
            var xp=bounds.width/subgrid.x;
            var yp=bounds.height/subgrid.y;
            var xn:Int=(#if flash9 untyped __int__(xp)#else Std.int(xp)#end);
            var yn:Int=(#if flash9 untyped __int__(yp)#else Std.int(yp)#end);
            if(xn!=xp)xn++;
            if(yn!=yp)yn++;
            for(x in 0...xn){
                var x0=bounds.x+subgrid.x*x;
                var x1=if(x==xn-1)bounds.max.x else(x0+subgrid.x);
                for(y in 0...yn){
                    var y0=bounds.y+subgrid.y*y;
                    var y1=if(y==yn-1)bounds.max.y else(y0+subgrid.y);
                    ZPP_MarchingSquares.run(iso,x0,y0,x1,y1,cellsize,quality,combine,ret);
                }
            }
        }
        ({
            if(({
                cellsize.zpp_inner.weak;
            })){
                cellsize.dispose();
                true;
            }
            else{
                false;
            }
        });
        if(subgrid!=null){
            ({
                if(({
                    subgrid.zpp_inner.weak;
                })){
                    subgrid.dispose();
                    true;
                }
                else{
                    false;
                }
            });
        }
        return ret;
    }
}
