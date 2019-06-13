package nape.geom;
import zpp_nape.geom.MatMN;
 /**
 * A general MxN dimensional matrix.
 * <br/><br/>
 * This object is not often used in Nape :)
 */
@:final#if nape_swc@:keep #end
class MatMN{
    /**
     * @private
     */
    public var zpp_inner:ZPP_MatMN=null;
    /**
     * The number of rows in the matrix.
     */
    #if nape_swc@:isVar #end
    public var rows(get_rows,never):Int;
    inline function get_rows():Int{
        return zpp_inner.m;
    }
    /**
     * The number of columns in the matrix.
     */
    #if nape_swc@:isVar #end
    public var cols(get_cols,never):Int;
    inline function get_cols():Int{
        return zpp_inner.n;
    }
    /**
     * Access element at index.
     *
     * @param row The row of the matrix to access.
     * @param col the column of the matrix to access.
     * @return The element at given (row,col) index.
     * @throws # If access is out of range.
     */
    #if NAPE_NO_INLINE#else inline #end
    public function x(row:Int,col:Int):Float{
        #if(!NAPE_RELEASE_BUILD)
        if(row<0||col<0||row>=rows||col>=cols){
            throw "Error: MatMN indices out of range";
        }
        #end
        return zpp_inner.x[(row*cols)+col];
    }
    /**
     * Set element at index.
     *
     * @param row The row of the matrix to set.
     * @param col The column of the matrix to set.
     * @param x The value to set at given (row,col) index.
     * @return The value of matrix at given index after set. (Always
     *         equal to the x parameter)
     * @throws # If index is out of range.
     */
    #if NAPE_NO_INLINE#else inline #end
    public function setx(row:Int,col:Int,x:Float):Float{
        #if(!NAPE_RELEASE_BUILD)
        if(row<0||col<0||row>=rows||col>=cols){
            throw "Error: MatMN indices out of range";
        }
        #end
        return zpp_inner.x[(row*cols)+col]=x;
    }
    /**
     * Construct a new Matrix.
     *
     * @param rows The number of rows in matrix.
     * @param cols The number of columns in matrix.
     * @return The constructed Matrix.
     * @throws # If rows or columns is negative or 0.
     */
    #if flib@:keep function flibopts_0(){}
    #end
    public function new(rows:Int,cols:Int){
        #if(!NAPE_RELEASE_BUILD)
        if(rows<=0||cols<=0){
            throw "Error: MatMN::dimensions cannot be < 1";
        }
        #end
        zpp_inner=new ZPP_MatMN(rows,cols);
        zpp_inner.outer=this;
    }
    /**
     * @private
     */
    @:keep public function toString(){
        var ret="{ ";
        var fst=true;
        for(i in 0...rows){
            if(!fst)ret+="; ";
            fst=false;
            for(j in 0...cols)ret+=x(i,j)+" ";
        }
        ret+="}";
        return ret;
    }
    /**
     * Transpose matrix, returning a new Matrix.
     *
     * @return The transposed matrix.
     */
    public function transpose():MatMN{
        var ret=new MatMN(cols,rows);
        for(i in 0...rows){
            for(j in 0...cols)ret.setx(j,i,x(i,j));
        }
        return ret;
    }
    /**
     * Multiple this matrix with another.
     * <br/><br/>
     * This operation is only valid if the number of columns
     * in this matrix, is equal to the number of rows in the input
     * matrix.
     * <br/>
     * The result of the multiplication is returned as a new matrix.
     *
     * @param matrix The matrix to multiple with.
     * @return The result of the multiplication
     * @throws If matrix dimensions are not compatible.
     */
    public function mul(matrix:MatMN):MatMN{
        var y=matrix;
        #if(!NAPE_RELEASE_BUILD)
        if(cols!=y.rows){
            throw "Error: Matrix dimensions aren't compatible";
        }
        #end
        var ret=new MatMN(rows,y.cols);
        for(i in 0...rows){
            for(j in 0...y.cols){
                var v=0.0;
                for(k in 0...cols)v+=x(i,k)*y.x(k,j);
                ret.setx(i,j,v);
            }
        }
        return ret;
    }
}
