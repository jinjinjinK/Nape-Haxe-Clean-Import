package zpp_nape.geom;
import nape.geom.Vec2;
#if nape_swc@:keep #end
class ZPP_Vec2{
    public var _invalidate:Null<ZPP_Vec2->Void>=null;
    public var _validate:Null<Void->Void>=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function validate():Void{
        if(_validate!=null){
            _validate();
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidate():Void{
        if(_invalidate!=null){
            _invalidate(this);
        }
    }
    public var _immutable:Bool=false;
    public var _isimmutable:Null<Void->Void>=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function immutable():Void{
        #if(!NAPE_RELEASE_BUILD)
        if(_immutable){
            throw "Error: Vec2 is immutable";
        }
        if(_isimmutable!=null){
            _isimmutable();
        }
        #end
    }
    public var outer:Null<Vec2>=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function wrapper():Vec2{
        if(outer==null){
            outer=new Vec2();
            {
                var o=outer.zpp_inner;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        o!=null;
                    };
                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Vec2"+", in obj: "+"outer.zpp_inner"+")");
                    #end
                };
                o.free();
                o.next=ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool=o;
                #if NAPE_POOL_STATS ZPP_Vec2.POOL_CNT++;
                ZPP_Vec2.POOL_SUB++;
                #end
            };
            outer.zpp_inner=this;
        }
        return outer;
    }
    public var weak:Bool=false;
    static public var zpp_pool:ZPP_Vec2=null;
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
    
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free():Void{
        if(outer!=null){
            outer.zpp_inner=null;
            outer=null;
        }
        _isimmutable=null;
        _validate=null;
        _invalidate=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc():Void{
        weak=false;
    }
    public var next:ZPP_Vec2=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function elem():ZPP_Vec2{
        return this;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function begin():ZPP_Vec2{
        return next;
    }
    public var _inuse:Bool=false;
    public var modified:Bool=false;
    public var pushmod:Bool=false;
    public var length:Int=0;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function setbegin(i:ZPP_Vec2):Void{
        next=i;
        modified=true;
        pushmod=true;
    }
    public function add(o:ZPP_Vec2):ZPP_Vec2{
        return inlined_add(o);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_add(o:ZPP_Vec2):ZPP_Vec2{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                o!=null&&!has(o);
            };
            if(!res)throw "assert("+"o!=null&&!has(o)"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] add -> o="+o);
            #end
        };
        var temp={
            o._inuse=true;
            o;
        };
        temp.next=begin();
        next=temp;
        modified=true;
        length++;
        return o;
    }
    public function addAll(x:ZPP_Vec2):Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x!=null;
            };
            if(!res)throw "assert("+"x!=null"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] addAll -> "+x);
            #end
        };
        {
            var cx_ite=x.begin();
            while(cx_ite!=null){
                var i=cx_ite.elem();
                add(i);
                cx_ite=cx_ite.next;
            }
        };
    }
    public function insert(cur:ZPP_Vec2,o:ZPP_Vec2):ZPP_Vec2{
        return inlined_insert(cur,o);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_insert(cur:ZPP_Vec2,o:ZPP_Vec2):ZPP_Vec2{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                o!=null&&!has(o);
            };
            if(!res)throw "assert("+"o!=null&&!has(o)"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] cur -> "+cur+" -> "+o);
            #end
        };
        var temp={
            o._inuse=true;
            o;
        };
        if(cur==null){
            temp.next=begin();
            next=temp;
        }
        else{
            temp.next=cur.next;
            cur.next=temp;
        }
        pushmod=modified=true;
        length++;
        return temp;
    }
    public function pop():Void{
        inlined_pop();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_pop():Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] pop");
            #end
        };
        var ret=begin();
        next=ret.next;
        {
            ret.elem()._inuse=false;
        };
        {};
        if(empty())pushmod=true;
        modified=true;
        length--;
    }
    public function pop_unsafe():ZPP_Vec2{
        return inlined_pop_unsafe();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_pop_unsafe():ZPP_Vec2{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] pop_unsafe");
            #end
        };
        var ret=front();
        pop();
        return ret;
    }
    public function remove(obj:ZPP_Vec2):Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("removed but didn't exist");
            #end
        };
        inlined_try_remove(obj);
    }
    public function try_remove(obj:ZPP_Vec2):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] remove -> "+obj);
            #end
        };
        var pre=null;
        var cur=begin();
        var ret=false;
        while(cur!=null){
            if(cur.elem()==obj){
                erase(pre);
                ret=true;
                break;
            }
            pre=cur;
            cur=cur.next;
        }
        return ret;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_remove(obj:ZPP_Vec2):Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("removed but didn't exist");
            #end
        };
        inlined_try_remove(obj);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_try_remove(obj:ZPP_Vec2):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] remove -> "+obj);
            #end
        };
        var pre=null;
        var cur=begin();
        var ret=false;
        while(cur!=null){
            if(cur.elem()==obj){
                inlined_erase(pre);
                ret=true;
                break;
            }
            pre=cur;
            cur=cur.next;
        }
        return ret;
    }
    public function erase(pre:ZPP_Vec2):ZPP_Vec2{
        return inlined_erase(pre);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_erase(pre:ZPP_Vec2):ZPP_Vec2{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] erase -> "+pre);
            #end
        };
        var old:ZPP_Vec2;
        var ret:ZPP_Vec2;
        if(pre==null){
            old=begin();
            ret=old.next;
            next=ret;
            if(empty())pushmod=true;
        }
        else{
            old=pre.next;
            ret=old.next;
            pre.next=ret;
            if(ret==null)pushmod=true;
        }
        {
            old.elem()._inuse=false;
        };
        {};
        modified=true;
        length--;
        pushmod=true;
        return ret;
    }
    public function splice(pre:ZPP_Vec2,n:Int):ZPP_Vec2{
        while(n-->0&&pre.next!=null)erase(pre);
        return pre.next;
    }
    public function clear():Void{
        inlined_clear();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_clear():Void{
        if(false){
            while(!empty())inlined_pop();
            pushmod=true;
        }
    }
    public function reverse():Void{
        var cur=begin();
        var pre=null;
        while(cur!=null){
            var nx=cur.next;
            cur.next=pre;
            next=cur;
            pre=cur;
            cur=nx;
        }
        modified=true;
        pushmod=true;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function empty():Bool{
        return begin()==null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function size():Int{
        return length;
    }
    public function has(obj:ZPP_Vec2):Bool{
        return inlined_has(obj);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_has(obj:ZPP_Vec2):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] has -> "+obj);
            #end
        };
        var ret;
        {
            ret=false;
            {
                var cx_ite=this.begin();
                while(cx_ite!=null){
                    var npite=cx_ite.elem();
                    {
                        if(npite==obj){
                            ret=true;
                            break;
                        }
                    };
                    cx_ite=cx_ite.next;
                }
            };
        };
        return ret;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function front():ZPP_Vec2{
        return begin().elem();
    }
    public function back():ZPP_Vec2{
        var ret=begin();
        var cur=ret;
        while(cur!=null){
            ret=cur;
            cur=cur.next;
        }
        return ret.elem();
    }
    public function iterator_at(ind:Int):ZPP_Vec2{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                ind>=-1&&ind<size();
            };
            if(!res)throw "assert("+"ind>=-1&&ind<size()"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] iterator_at -> "+ind);
            #end
        };
        var ret=begin();
        while(ind-->0&&ret!=null)ret=ret.next;
        return ret;
    }
    public function at(ind:Int):ZPP_Vec2{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                ind>=0&&ind<size();
            };
            if(!res)throw "assert("+"ind>=0&&ind<size()"+") :: "+("[ListMixin("+"ZPP_Vec2"+"] at -> "+ind);
            #end
        };
        var it=iterator_at(ind);
        return if(it!=null)it.elem()else null;
    }
    public var x:Float=0.0;
    public var y:Float=0.0;
    public function new(){}
    public static#if NAPE_NO_INLINE#else inline #end
    function get(x:Float,y:Float,immutable:Bool=false):ZPP_Vec2{
        var ret;
        {
            if(ZPP_Vec2.zpp_pool==null){
                ret=new ZPP_Vec2();
                #if NAPE_POOL_STATS ZPP_Vec2.POOL_TOT++;
                ZPP_Vec2.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_Vec2.POOL_CNT--;
                ZPP_Vec2.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        ret._immutable=immutable;
        {
            ret.x=x;
            ret.y=y;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.x!=ret.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.x)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"x"+",in y: "+"y"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.y!=ret.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.y)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"x"+",in y: "+"y"+")");
                #end
            };
        };
        return ret;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function copy():ZPP_Vec2{
        return get(x,y);
    }
    public function toString():String{
        return "{ x: "+x+" y: "+y+" }";
    }
}
