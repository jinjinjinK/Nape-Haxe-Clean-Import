package nape.geom;
/**
 * For 'flash' targets only.
 * <br/><br/>
 * Iso-functions for MarchingSquares must be given
 * as an object implementing this IsoFunction interface. This is for
 * reasons of avoiding excessive memory allocations that occur through
 * automatic boxing of arguments/return values when using function values.
 * <br/>
 * Since iso-functions may be called 10,000's of times per-invocation of
 * marching-squares, this can quickly accumulate into a lot of GC activity.
 */
#if flash interface IsoFunction{
    /**
     * iso-function implementation.
     * <br/><br/>
     * @param x The x-value of point.
     * @param y The y-value of point.
     * @return The value of iso-function for input point.
     */
    public function iso(x:Float,y:Float):Float;
}
#end
/**
 * Typedef defining iso-function type for MarchingSquares.
 * <code>
 * typedef IsoFunctionDef = #if flash IsoFunction #else Float-&gt;Float-&gt;Float #end;
 * </code>
 */
typedef IsoFunctionDef=#if flash IsoFunction#else Float->Float->Float #end;
