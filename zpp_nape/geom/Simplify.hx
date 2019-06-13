package zpp_nape.geom;
import zpp_nape.geom.GeomPoly.ZPP_GeomVert;
import zpp_nape.geom.VecMath.ZPP_VecMath;
import zpp_nape.util.Lists.ZNPList_ZPP_SimplifyP;
#if nape_swc@:keep #end
class ZPP_SimplifyV{
    public var x:Float=0.0;
    public var y:Float=0.0;
    public var next:ZPP_SimplifyV=null;
    static public var zpp_pool:ZPP_SimplifyV=null;
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
    
    public var prev:ZPP_SimplifyV=null;
    public var flag:Bool=false;
    public var forced:Bool=false;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free(){}
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public function new(){}
    public static#if NAPE_NO_INLINE#else inline #end
    function get(v:ZPP_GeomVert){
        var ret;
        {
            if(ZPP_SimplifyV.zpp_pool==null){
                ret=new ZPP_SimplifyV();
                #if NAPE_POOL_STATS ZPP_SimplifyV.POOL_TOT++;
                ZPP_SimplifyV.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_SimplifyV.zpp_pool;
                ZPP_SimplifyV.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_SimplifyV.POOL_CNT--;
                ZPP_SimplifyV.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        {
            ret.x=v.x;
            ret.y=v.y;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.x!=ret.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.x)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"v.x"+",in y: "+"v.y"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.y!=ret.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.y)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"v.x"+",in y: "+"v.y"+")");
                #end
            };
        };
        ret.flag=false;
        return ret;
    }
}
#if nape_swc@:keep #end
class ZPP_SimplifyP{
    public var next:ZPP_SimplifyP=null;
    static public var zpp_pool:ZPP_SimplifyP=null;
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
    
    public var min:ZPP_SimplifyV=null;
    public var max:ZPP_SimplifyV=null;
    public function new(){}
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free(){
        min=max=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public static#if NAPE_NO_INLINE#else inline #end
    function get(min:ZPP_SimplifyV,max:ZPP_SimplifyV){
        var ret;
        {
            if(ZPP_SimplifyP.zpp_pool==null){
                ret=new ZPP_SimplifyP();
                #if NAPE_POOL_STATS ZPP_SimplifyP.POOL_TOT++;
                ZPP_SimplifyP.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_SimplifyP.zpp_pool;
                ZPP_SimplifyP.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_SimplifyP.POOL_CNT--;
                ZPP_SimplifyP.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        ret.min=min;
        ret.max=max;
        return ret;
    }
}
#if nape_swc@:keep #end
class ZPP_Simplify{
    public static#if NAPE_NO_INLINE#else inline #end
    function lessval(a:ZPP_SimplifyV,b:ZPP_SimplifyV){
        return(a.x-b.x)+(a.y-b.y);
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function less(a:ZPP_SimplifyV,b:ZPP_SimplifyV){
        return lessval(a,b)<0.0;
    }
    public static function distance(v:ZPP_SimplifyV,a:ZPP_SimplifyV,b:ZPP_SimplifyV){
        var nx:Float=0.0;
        var ny:Float=0.0;
        {
            nx=b.x-a.x;
            ny=b.y-a.y;
        };
        var cx:Float=0.0;
        var cy:Float=0.0;
        {
            cx=v.x-a.x;
            cy=v.y-a.y;
        };
        var den=(nx*nx+ny*ny);
        if(den==0.0)return(cx*cx+cy*cy);
        else{
            var t=(cx*nx+cy*ny)/(nx*nx+ny*ny);
            if(t<=0)return(cx*cx+cy*cy);
            else if(t>=1)return ZPP_VecMath.vec_dsq(v.x,v.y,b.x,b.y);
            else{
                {
                    var t=(t);
                    {
                        #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                        var res={
                            !((t!=t));
                        };
                        if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_subeq(in a: "+"c"+",in b: "+"n"+",in s: "+"t"+")");
                        #end
                    };
                    cx-=nx*t;
                    cy-=ny*t;
                };
                return(cx*cx+cy*cy);
            }
        }
    }
    static var stack:ZNPList_ZPP_SimplifyP=null;
    public static function simplify(P:ZPP_GeomVert,epsilon:Float){
        var ret:ZPP_SimplifyV=null;
        var min:ZPP_SimplifyV=null;
        var max:ZPP_SimplifyV=null;
        epsilon*=epsilon;
        if(stack==null){
            stack=new ZNPList_ZPP_SimplifyP();
        }
        var pre:ZPP_SimplifyV=null;
        var fst:ZPP_SimplifyV=null;
        var cur:ZPP_GeomVert=P;
        do{
            var v=ZPP_SimplifyV.get(cur);
            v.forced=cur.forced;
            if(v.forced){
                v.flag=true;
                if(pre!=null)stack.add(ZPP_SimplifyP.get(pre,v));
                else fst=v;
                pre=v;
            }
            ret={
                var obj=v;
                if(ret==null)ret=obj.prev=obj.next=obj;
                else{
                    obj.prev=ret;
                    obj.next=ret.next;
                    ret.next.prev=obj;
                    ret.next=obj;
                }
                obj;
            };
            if(min==null){
                min=ret;
                max=ret;
            }
            else{
                if(less(ret,min))min=ret;
                if(less(max,ret))max=ret;
            }
            cur=cur.next;
        }
        while(cur!=P);
        if(stack.empty()){
            if(fst==null){
                min.flag=max.flag=true;
                stack.add(ZPP_SimplifyP.get(min,max));
                stack.add(ZPP_SimplifyP.get(max,min));
            }
            else{
                var d1=lessval(min,fst);
                if(d1<0)d1=-d1;
                var d2=lessval(max,fst);
                if(d2<0)d2=-d2;
                if(d1>d2){
                    min.flag=fst.flag=true;
                    stack.add(ZPP_SimplifyP.get(min,fst));
                    stack.add(ZPP_SimplifyP.get(fst,min));
                }
                else{
                    max.flag=fst.flag=true;
                    stack.add(ZPP_SimplifyP.get(max,fst));
                    stack.add(ZPP_SimplifyP.get(fst,max));
                }
            }
        }
        else stack.add(ZPP_SimplifyP.get(pre,fst));
        while(!stack.empty()){
            var cur=stack.pop_unsafe();
            var min=cur.min;
            var max=cur.max;
            {
                var o=cur;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        o!=null;
                    };
                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_SimplifyP"+", in obj: "+"cur"+")");
                    #end
                };
                o.free();
                o.next=ZPP_SimplifyP.zpp_pool;
                ZPP_SimplifyP.zpp_pool=o;
                #if NAPE_POOL_STATS ZPP_SimplifyP.POOL_CNT++;
                ZPP_SimplifyP.POOL_SUB++;
                #end
            };
            var dmax=epsilon;
            var dv:ZPP_SimplifyV=null;
            var ite=min.next;
            while(ite!=max){
                var dist=distance(ite,min,max);
                if(dist>dmax){
                    dmax=dist;
                    dv=ite;
                }
                ite=ite.next;
            }
            if(dv!=null){
                dv.flag=true;
                stack.add(ZPP_SimplifyP.get(min,dv));
                stack.add(ZPP_SimplifyP.get(dv,max));
            }
        }
        var retp:ZPP_GeomVert=null;
        while(ret!=null){
            if(ret.flag){
                retp={
                    var obj=ZPP_GeomVert.get(ret.x,ret.y);
                    if(retp==null)retp=obj.prev=obj.next=obj;
                    else{
                        obj.prev=retp;
                        obj.next=retp.next;
                        retp.next.prev=obj;
                        retp.next=obj;
                    }
                    obj;
                };
                retp.forced=ret.forced;
            }
            ret={
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !(ret==null);
                    };
                    if(!res)throw "assert("+"!(ret==null)"+") :: "+("can't pop from empty list herpaderp");
                    #end
                };
                if((ret!=null&&ret.prev==ret)){
                    ret.next=ret.prev=null;
                    {
                        var o=ret;
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                o!=null;
                            };
                            if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_SimplifyV"+", in obj: "+"ret"+")");
                            #end
                        };
                        o.free();
                        o.next=ZPP_SimplifyV.zpp_pool;
                        ZPP_SimplifyV.zpp_pool=o;
                        #if NAPE_POOL_STATS ZPP_SimplifyV.POOL_CNT++;
                        ZPP_SimplifyV.POOL_SUB++;
                        #end
                    };
                    ret=null;
                }
                else{
                    var retnodes=ret.next;
                    ret.prev.next=ret.next;
                    ret.next.prev=ret.prev;
                    ret.next=ret.prev=null;
                    {
                        var o=ret;
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                o!=null;
                            };
                            if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_SimplifyV"+", in obj: "+"ret"+")");
                            #end
                        };
                        o.free();
                        o.next=ZPP_SimplifyV.zpp_pool;
                        ZPP_SimplifyV.zpp_pool=o;
                        #if NAPE_POOL_STATS ZPP_SimplifyV.POOL_CNT++;
                        ZPP_SimplifyV.POOL_SUB++;
                        #end
                    };
                    ret=null;
                    retnodes;
                }
            };
        }
        return retp;
    }
}
