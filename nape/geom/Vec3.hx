package nape.geom;
import nape.geom.Vec2;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.Vec3;
import zpp_nape.util.Math;
import zpp_nape.util.Pool.ZPP_PubPool;
/**
 * A 3 dimensional vector object.
 * <br/><br/>
 * In many instances a Vec3 will be accessible from Nape which is marked
 * as immutable, these cases will be documented and modifying such a Vec3
 * will result in an error.
 */
@:final#if nape_swc@:keep #end
class Vec3{
    /**
     * @private
     */
    public var zpp_inner:ZPP_Vec3=null;
    /**
     * @private
     */
    public var zpp_pool:Vec3=null;
    #if(!NAPE_RELEASE_BUILD)
    /**
     * @private
     */
    public var zpp_disp:Bool;
    #end
    #if NAPE_POOL_STATS 
    /**
     * @private
     */
    static public var POOL_CNT:Int=0;
    /**
     * @private
     */
    static public var POOL_TOT:Int=0;
    /**
     * @private
     */
    static public var POOL_ADD:Int=0;
    /**
     * @private
     */
    static public var POOL_ADDNEW:Int=0;
    /**
     * @private
     */
    static public var POOL_SUB:Int=0;
    #end
    
    /**
     * The x component of Vec3.
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var x(get_x,set_x):Float;
    inline function get_x():Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        zpp_inner.validate();
        return zpp_inner.x;
    }
    inline function set_x(x:Float):Float{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner.immutable){
                throw "Error: Vec3 is immutable";
            }
            #end
            zpp_inner.x=x;
        }
        return get_x();
    }
    /**
     * The y component of Vec3.
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var y(get_y,set_y):Float;
    inline function get_y():Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        zpp_inner.validate();
        return zpp_inner.y;
    }
    inline function set_y(y:Float):Float{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner.immutable){
                throw "Error: Vec3 is immutable";
            }
            #end
            zpp_inner.y=y;
        }
        return get_y();
    }
    /**
     * The z component of Vec3.
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var z(get_z,set_z):Float;
    inline function get_z():Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        zpp_inner.validate();
        return zpp_inner.z;
    }
    inline function set_z(z:Float):Float{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner.immutable){
                throw "Error: Vec3 is immutable";
            }
            #end
            zpp_inner.z=z;
        }
        return get_z();
    }
    /**
     * Allocate a Vec3 from the global object pool.
     * <br/><br/>
     * Use of this method should always be preferred to the constructor.
     *
     * @param x The x component of Vec3. (default 0)
     * @param y The y component of Vec3. (default 0)
     * @param z The z component of Vec3. (default 0)
     * @return A Vec3 allocated from global object pool with given components.
     */
    public static function get(x:Float=0,y:Float=0,z:Float=0):Vec3{
        var ret;
        {
            if(ZPP_PubPool.poolVec3==null){
                ret=new Vec3();
                #if NAPE_POOL_STATS Vec3.POOL_TOT++;
                Vec3.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_PubPool.poolVec3;
                ZPP_PubPool.poolVec3=ret.zpp_pool;
                ret.zpp_pool=null;
                #if(!NAPE_RELEASE_BUILD)
                ret.zpp_disp=false;
                if(ret==ZPP_PubPool.nextVec3)ZPP_PubPool.nextVec3=null;
                #end
                #if NAPE_POOL_STATS Vec3.POOL_CNT--;
                Vec3.POOL_ADD++;
                #end
            }
        };
        ret.setxyz(x,y,z);
        ret.zpp_inner.immutable=false;
        ret.zpp_inner._validate=null;
        return ret;
    }
    /**
     * Construct a new Vec3.
     * <br/><br/>
     * This method should not generally be used with preference for the
     * static get method which will make use of the global object pool.
     *
     * @param x The x component of Vec3. (default 0)
     * @param y The y component of Vec3. (default 0)
     * @param z The z component of Vec3. (default 0)
     * @return A newly constructed Vec3 with given components.
     */
    public function new(x:Float=0,y:Float=0,z:Float=0){
        zpp_inner=new ZPP_Vec3();
        zpp_inner.outer=this;
        {
            {
                this.x=x;
                this.y=y;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((this.x!=this.x));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(this.x)"+") :: "+("vec_set(in n: "+"this."+",in x: "+"x"+",in y: "+"y"+")");
                    #end
                };
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((this.y!=this.y));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(this.y)"+") :: "+("vec_set(in n: "+"this."+",in x: "+"x"+",in y: "+"y"+")");
                    #end
                };
            };
            this.z=z;
        };
    }
    /**
     * Produce a copy of this Vec3.
     *
     * @return The copy of this Vec3.
     * @throws # If this Vec3 has been disposed of.
    public function copy():Vec3{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        return Vec3.get(x,y,z);
    }
    /**
     * Release Vec3 object to global object pool.
     *
     * @throws # If this Vec3 has already been disposed of.
     * @throws # If this Vec3 is immutable.
     */
    public function dispose():Void{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.immutable){
            throw "Error: This Vec3 is not disposable";
        }
        #end
        {
            var o=this;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("PublicFree(in T: "+"Vec3"+", in obj: "+"this"+")");
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            o.zpp_pool=null;
            if(ZPP_PubPool.nextVec3!=null)ZPP_PubPool.nextVec3.zpp_pool=o;
            else ZPP_PubPool.poolVec3=o;
            ZPP_PubPool.nextVec3=o;
            #end
            #if NAPE_RELEASE_BUILD 
            o.zpp_pool=ZPP_PubPool.poolVec3;
            ZPP_PubPool.poolVec3=o;
            #end
            #if NAPE_POOL_STATS Vec3.POOL_CNT++;
            Vec3.POOL_SUB++;
            #end
            #if(!NAPE_RELEASE_BUILD)
            o.zpp_disp=true;
            #end
        };
    }
    /**
     * Length of Vec3.
     * <br/><br/>
     * This value may also be set to any value including negatives, though
     * an error will be thrown if length of the Vec3 is already 0 as such
     * a scaling would be undefined. As well as if this Vec3 has been disposed
     * of, or is immutable.
     *
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var length(get_length,set_length):Float;
    inline function get_length():Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        return Math.sqrt(((this.x*this.x+this.y*this.y)+this.z*this.z));
    }
    inline function set_length(length:Float):Float{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if((length!=length)){
                throw "Error: Vec3::length cannot be NaN";
            }
            if(((this.x*this.x+this.y*this.y)+this.z*this.z)==0){
                throw "Error: Cannot set length of a zero vector";
            }
            #end
            {
                var t=((length/this.length));
                {
                    var t=(t);
                    {
                        #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                        var res={
                            !((t!=t));
                        };
                        if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_muleq(in a: "+"this."+",in s: "+"t"+")");
                        #end
                    };
                    this.x*=t;
                    this.y*=t;
                };
                this.z*=t;
            };
        }
        return get_length();
    }
    /**
     * Compute squared length of Vec3.
     *
     * @return The squared length of this Vec3.
     * @throws # If the Vec3 has been disposed of.
     */
    #if nape_swc@:keep #end
    public function lsq():Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        return((this.x*this.x+this.y*this.y)+this.z*this.z);
    }
    /**
     * Set values of this Vec3 from another.
     *
     * @param vector The vector to set values from.
     * @return A reference to this Vec3.
     * @throws # If the vector argument is null.
     * @throws # If this, or the vector argument are disposed of.
     * @throws # If this Vec3 is immutable.
     */
    public function set(vector:Vec3):Vec3{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        {
            #if(!NAPE_RELEASE_BUILD)
            if(vector!=null&&vector.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        #if(!NAPE_RELEASE_BUILD)
        if(vector==null){
            throw "Error: Cannot assign null Vec3";
        }
        #end
        return setxyz(vector.x,vector.y,vector.z);
    }
    /**
     * Set values of this Vec3 from numbers.
     *
     * @param x The new x component value for this vector.
     * @param y The new y component value for this vector.
     * @param z The new z component value for this vector.
     * @return A reference to this Vec3.
     * @throws # If this Vec3 has been disposed of.
     * @throws # If this Vec3 is immutable.
     */
    public function setxyz(x:Float,y:Float,z:Float):Vec3{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        {
            {
                this.x=x;
                this.y=y;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((this.x!=this.x));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(this.x)"+") :: "+("vec_set(in n: "+"this."+",in x: "+"x"+",in y: "+"y"+")");
                    #end
                };
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((this.y!=this.y));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(this.y)"+") :: "+("vec_set(in n: "+"this."+",in x: "+"x"+",in y: "+"y"+")");
                    #end
                };
            };
            this.z=z;
        };
        return this;
    }
    /**
     * Produce copy of the xy components of Vec3.
     * <br/><br/>
     * This function will return a new Vec2 completely seperate
     * from this Vec3 with values equal to the xy components of
     * this Vec3.
     *
     * @param weak If true, then the allocated Vec2 will be weak
     *             so that when used as an argument to a Nape
     *             function it will be automatically released back
     *             to the global object pool. (default false)
     * @return An allocated Vec2 representing the xy components of
     *         this vector.
     */
    public function xy(weak:Bool=false):Vec2{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        return Vec2.get(x,y,weak);
    }
    /**
     * @private
     */
    @:keep public function toString():String{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(this!=null&&this.zpp_disp)throw "Error: "+"Vec3"+" has been disposed and cannot be used!";
            #end
        };
        return "{ x: "+x+" y: "+y+" z: "+z+" }";
    }
}
