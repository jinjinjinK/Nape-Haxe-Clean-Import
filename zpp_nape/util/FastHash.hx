package zpp_nape.util;
import nape.TArray;
import nape.util.Debug;
import zpp_nape.util.Debug;

#if nape_swc@:keep #end
#if nape_swc@:keep #end
class Hashable2_Boolfalse{
    public var value:Bool=false;
    public var next:Hashable2_Boolfalse=null;
    static public var zpp_pool:Hashable2_Boolfalse=null;
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
    
    public var hnext:Hashable2_Boolfalse=null;
    public var id:Int=0;
    public var di:Int=0;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free(){}
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    function new(){}
    public static#if NAPE_NO_INLINE#else inline #end
    function get(id:Int,di:Int,val:Bool){
        var ret=getpersist(id,di);
        ret.value=val;
        return ret;
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function getpersist(id:Int,di:Int){
        var ret;
        {
            if(Hashable2_Boolfalse.zpp_pool==null){
                ret=new Hashable2_Boolfalse();
                #if NAPE_POOL_STATS Hashable2_Boolfalse.POOL_TOT++;
                Hashable2_Boolfalse.POOL_ADDNEW++;
                #end
            }
            else{
                ret=Hashable2_Boolfalse.zpp_pool;
                Hashable2_Boolfalse.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS Hashable2_Boolfalse.POOL_CNT--;
                Hashable2_Boolfalse.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        ret.id=id;
        ret.di=di;
        return ret;
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function ordered_get(id:Int,di:Int,val:Bool){
        return if(id<=di)get(id,di,val)else get(di,id,val);
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function ordered_get_persist(id:Int,di:Int){
        return if(id<=di)getpersist(id,di);
        else getpersist(di,id);
    }
}

#if nape_swc@:keep #end
#if nape_swc@:keep #end
class FastHash2_Hashable2_Boolfalse{
    public var table:TArray<Hashable2_Boolfalse>=null;
    public var cnt:Int=0;
    public function new(){
        cnt=0;
        #if flash10 table=new flash.Vector<Hashable2_Boolfalse>(0x100000,true);
        #else table=new Array<Hashable2_Boolfalse>();
        for(i in 0...(0x100000))table.push(null);
        #end
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function empty(){
        return cnt==0;
    }
    public function clear(){
        {
            for(i in 0...this.table.length){
                var n=this.table[i];
                if(n==null)continue;
                while(n!=null){
                    var t=n.hnext;
                    n.hnext=null;
                    (n);
                    n=t;
                }
                this.table[i]=null;
            }
        };
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function get(id:Int,di:Int):Hashable2_Boolfalse{
        var n=table[hash(id,di)];
        if(n==null)return null;
        else if(n.id==id&&n.di==di)return n;
        else{
            do n=n.hnext while(n!=null&&(n.id!=id||n.di!=di));
            return n;
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function ordered_get(id:Int,di:Int){
        if(id>di){
            var t=id;
            id=di;
            di=t;
        }
        return get(id,di);
    }
    public function has(id:Int,di:Int):Bool{
        var n=table[hash(id,di)];
        if(n==null)return false;
        else if(n.id==id&&n.di==di)return true;
        else{
            do n=n.hnext while(n!=null&&(n.id!=id||n.di!=di));
            return n!=null;
        }
    }
    public function maybeAdd(arb:Hashable2_Boolfalse){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                arb!=null;
            };
            if(!res)throw "assert("+"arb!=null"+") :: "+("cannot add null to hash2");
            #end
        };
        var h=hash(arb.id,arb.di);
        var n=table[h];
        var cont=true;
        if(n==null){
            table[h]=arb;
            arb.hnext=null;
        }
        else{
            #if NAPE_ASSERT var nor=n;
            while(n!=null){
                if(n.id==arb.id&&n.di==arb.di){
                    cont=false;
                    break;
                }
                n=n.hnext;
            }
            n=nor;
            #end
            if(cont){
                arb.hnext=n.hnext;
                n.hnext=arb;
            }
        }
        if(cont)cnt++;
    }
    public function add(arb:Hashable2_Boolfalse){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                arb!=null;
            };
            if(!res)throw "assert("+"arb!=null"+") :: "+("cannot add null to hash2");
            #end
        };
        var h=hash(arb.id,arb.di);
        var n=table[h];
        if(n==null){
            table[h]=arb;
            arb.hnext=null;
        }
        else{
            #if NAPE_ASSERT var nor=n;
            while(n!=null){
                if(n.id==arb.id&&n.di==arb.di)throw "ASSERTION: FastHash2("+"Hashable2_Boolfalse"+") already cotnains object with ids";
                n=n.hnext;
            }
            n=nor;
            #end
            arb.hnext=n.hnext;
            n.hnext=arb;
            #if NAPE_TIMES Debug.HASH++;
            #end
        }
        #if NAPE_TIMES Debug.HASHT++;
        #end
        cnt++;
    }
    public function remove(arb:Hashable2_Boolfalse){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                arb!=null;
            };
            if(!res)throw "assert("+"arb!=null"+") :: "+("cannot remove null from hash2");
            #end
        };
        var h=hash(arb.id,arb.di);
        var n=table[h];
        if(n==arb)table[h]=n.hnext;
        else if(n!=null){
            var pre:Hashable2_Boolfalse;
            do{
                pre=n;
                n=n.hnext;
            }
            while(n!=null&&n!=arb);
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    n!=null;
                };
                if(!res)throw "assert("+"n!=null"+") :: "+("object doesn't exist in hash2");
                #end
            };
            pre.hnext=n.hnext;
        }
        arb.hnext=null;
        cnt--;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function hash(id:Int,di:Int){
        return((id*106039)+di)&0xfffff;
    }
}
