package zpp_nape.dynamics;
import nape.dynamics.Contact;
import nape.geom.Vec2;
import zpp_nape.dynamics.Arbiter.ZPP_Arbiter;
import zpp_nape.geom.Vec2;
#if nape_swc@:keep #end
class ZPP_Contact{
    public var outer:Contact=null;
    public static var internal:Bool=false;
    public function wrapper(){
        if(outer==null){
            internal=true;
            outer=new Contact();
            internal=false;
            outer.zpp_inner=this;
        }
        return outer;
    }
    public var px:Float=0.0;
    public var py:Float=0.0;
    private function position_validate(){
        #if(!NAPE_RELEASE_BUILD)
        if(inactiveme())throw "Error: Contact not currently in use";
        #end
        {
            wrap_position.zpp_inner.x=px;
            wrap_position.zpp_inner.y=py;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_position.zpp_inner.x!=wrap_position.zpp_inner.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_position.zpp_inner.x)"+") :: "+("vec_set(in n: "+"wrap_position.zpp_inner."+",in x: "+"px"+",in y: "+"py"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_position.zpp_inner.y!=wrap_position.zpp_inner.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_position.zpp_inner.y)"+") :: "+("vec_set(in n: "+"wrap_position.zpp_inner."+",in x: "+"px"+",in y: "+"py"+")");
                #end
            };
        };
    }
    public var wrap_position:Vec2=null;
    public function getposition(){
        var me=this;
        wrap_position=Vec2.get();
        wrap_position.zpp_inner._inuse=true;
        wrap_position.zpp_inner._immutable=true;
        wrap_position.zpp_inner._validate=position_validate;
    }
    public function inactiveme(){
        return!(active&&arbiter!=null&&!arbiter.inactiveme());
    }
    public var arbiter:ZPP_Arbiter=null;
    public var inner:ZPP_IContact=null;
    public var active:Bool=false;
    public var posOnly:Bool=false;
    public var stamp:Int=0;
    public var hash:Int=0;
    public var fresh:Bool=false;
    public var dist:Float=0.0;
    public var elasticity:Float=0.0;
    public function new(){
        inner=new ZPP_IContact();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free(){
        arbiter=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    static public var zpp_pool:ZPP_Contact=null;
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
    
    public var next:ZPP_Contact=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function elem():ZPP_Contact{
        return this;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function begin():ZPP_Contact{
        return next;
    }
    public var _inuse:Bool=false;
    public var modified:Bool=false;
    public var pushmod:Bool=false;
    public var length:Int=0;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function setbegin(i:ZPP_Contact):Void{
        next=i;
        modified=true;
        pushmod=true;
    }
    public function add(o:ZPP_Contact):ZPP_Contact{
        return inlined_add(o);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_add(o:ZPP_Contact):ZPP_Contact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                o!=null&&!has(o);
            };
            if(!res)throw "assert("+"o!=null&&!has(o)"+") :: "+("[ListMixin("+"ZPP_Contact"+"] add -> o="+o);
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
    public function addAll(x:ZPP_Contact):Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x!=null;
            };
            if(!res)throw "assert("+"x!=null"+") :: "+("[ListMixin("+"ZPP_Contact"+"] addAll -> "+x);
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
    public function insert(cur:ZPP_Contact,o:ZPP_Contact):ZPP_Contact{
        return inlined_insert(cur,o);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_insert(cur:ZPP_Contact,o:ZPP_Contact):ZPP_Contact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                o!=null&&!has(o);
            };
            if(!res)throw "assert("+"o!=null&&!has(o)"+") :: "+("[ListMixin("+"ZPP_Contact"+"] cur -> "+cur+" -> "+o);
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
            if(!res)throw "assert("+"!empty()"+") :: "+("[ListMixin("+"ZPP_Contact"+"] pop");
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
    public function pop_unsafe():ZPP_Contact{
        return inlined_pop_unsafe();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_pop_unsafe():ZPP_Contact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("[ListMixin("+"ZPP_Contact"+"] pop_unsafe");
            #end
        };
        var ret=front();
        pop();
        return ret;
    }
    public function remove(obj:ZPP_Contact):Void{
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
    public function try_remove(obj:ZPP_Contact):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("[ListMixin("+"ZPP_Contact"+"] remove -> "+obj);
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
    function inlined_remove(obj:ZPP_Contact):Void{
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
    function inlined_try_remove(obj:ZPP_Contact):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("[ListMixin("+"ZPP_Contact"+"] remove -> "+obj);
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
    public function erase(pre:ZPP_Contact):ZPP_Contact{
        return inlined_erase(pre);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_erase(pre:ZPP_Contact):ZPP_Contact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("[ListMixin("+"ZPP_Contact"+"] erase -> "+pre);
            #end
        };
        var old:ZPP_Contact;
        var ret:ZPP_Contact;
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
    public function splice(pre:ZPP_Contact,n:Int):ZPP_Contact{
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
    public function has(obj:ZPP_Contact):Bool{
        return inlined_has(obj);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_has(obj:ZPP_Contact):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("[ListMixin("+"ZPP_Contact"+"] has -> "+obj);
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
    function front():ZPP_Contact{
        return begin().elem();
    }
    public function back():ZPP_Contact{
        var ret=begin();
        var cur=ret;
        while(cur!=null){
            ret=cur;
            cur=cur.next;
        }
        return ret.elem();
    }
    public function iterator_at(ind:Int):ZPP_Contact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                ind>=-1&&ind<size();
            };
            if(!res)throw "assert("+"ind>=-1&&ind<size()"+") :: "+("[ListMixin("+"ZPP_Contact"+"] iterator_at -> "+ind);
            #end
        };
        var ret=begin();
        while(ind-->0&&ret!=null)ret=ret.next;
        return ret;
    }
    public function at(ind:Int):ZPP_Contact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                ind>=0&&ind<size();
            };
            if(!res)throw "assert("+"ind>=0&&ind<size()"+") :: "+("[ListMixin("+"ZPP_Contact"+"] at -> "+ind);
            #end
        };
        var it=iterator_at(ind);
        return if(it!=null)it.elem()else null;
    }
}
#if nape_swc@:keep #end
class ZPP_IContact{
    public var r1x:Float=0.0;
    public var r1y:Float=0.0;
    public var r2x:Float=0.0;
    public var r2y:Float=0.0;
    public var nMass:Float=0.0;
    public var tMass:Float=0.0;
    public var bounce:Float=0.0;
    public var friction:Float=0.0;
    public var jnAcc:Float=0.0;
    public var jtAcc:Float=0.0;
    public var lr1x:Float=0.0;
    public var lr1y:Float=0.0;
    public var lr2x:Float=0.0;
    public var lr2y:Float=0.0;
    public function new(){}
    public var next:ZPP_IContact=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function elem():ZPP_IContact{
        return this;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function begin():ZPP_IContact{
        return next;
    }
    public var _inuse:Bool=false;
    public var modified:Bool=false;
    public var pushmod:Bool=false;
    public var length:Int=0;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function setbegin(i:ZPP_IContact):Void{
        next=i;
        modified=true;
        pushmod=true;
    }
    public function add(o:ZPP_IContact):ZPP_IContact{
        return inlined_add(o);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_add(o:ZPP_IContact):ZPP_IContact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                o!=null&&!has(o);
            };
            if(!res)throw "assert("+"o!=null&&!has(o)"+") :: "+("[ListMixin("+"ZPP_IContact"+"] add -> o="+o);
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
    public function addAll(x:ZPP_IContact):Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x!=null;
            };
            if(!res)throw "assert("+"x!=null"+") :: "+("[ListMixin("+"ZPP_IContact"+"] addAll -> "+x);
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
    public function insert(cur:ZPP_IContact,o:ZPP_IContact):ZPP_IContact{
        return inlined_insert(cur,o);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_insert(cur:ZPP_IContact,o:ZPP_IContact):ZPP_IContact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                o!=null&&!has(o);
            };
            if(!res)throw "assert("+"o!=null&&!has(o)"+") :: "+("[ListMixin("+"ZPP_IContact"+"] cur -> "+cur+" -> "+o);
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
            if(!res)throw "assert("+"!empty()"+") :: "+("[ListMixin("+"ZPP_IContact"+"] pop");
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
    public function pop_unsafe():ZPP_IContact{
        return inlined_pop_unsafe();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_pop_unsafe():ZPP_IContact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("[ListMixin("+"ZPP_IContact"+"] pop_unsafe");
            #end
        };
        var ret=front();
        pop();
        return ret;
    }
    public function remove(obj:ZPP_IContact):Void{
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
    public function try_remove(obj:ZPP_IContact):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("[ListMixin("+"ZPP_IContact"+"] remove -> "+obj);
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
    function inlined_remove(obj:ZPP_IContact):Void{
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
    function inlined_try_remove(obj:ZPP_IContact):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("[ListMixin("+"ZPP_IContact"+"] remove -> "+obj);
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
    public function erase(pre:ZPP_IContact):ZPP_IContact{
        return inlined_erase(pre);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_erase(pre:ZPP_IContact):ZPP_IContact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("[ListMixin("+"ZPP_IContact"+"] erase -> "+pre);
            #end
        };
        var old:ZPP_IContact;
        var ret:ZPP_IContact;
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
    public function splice(pre:ZPP_IContact,n:Int):ZPP_IContact{
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
    public function has(obj:ZPP_IContact):Bool{
        return inlined_has(obj);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function inlined_has(obj:ZPP_IContact):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("[ListMixin("+"ZPP_IContact"+"] has -> "+obj);
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
    function front():ZPP_IContact{
        return begin().elem();
    }
    public function back():ZPP_IContact{
        var ret=begin();
        var cur=ret;
        while(cur!=null){
            ret=cur;
            cur=cur.next;
        }
        return ret.elem();
    }
    public function iterator_at(ind:Int):ZPP_IContact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                ind>=-1&&ind<size();
            };
            if(!res)throw "assert("+"ind>=-1&&ind<size()"+") :: "+("[ListMixin("+"ZPP_IContact"+"] iterator_at -> "+ind);
            #end
        };
        var ret=begin();
        while(ind-->0&&ret!=null)ret=ret.next;
        return ret;
    }
    public function at(ind:Int):ZPP_IContact{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                ind>=0&&ind<size();
            };
            if(!res)throw "assert("+"ind>=0&&ind<size()"+") :: "+("[ListMixin("+"ZPP_IContact"+"] at -> "+ind);
            #end
        };
        var it=iterator_at(ind);
        return if(it!=null)it.elem()else null;
    }
}
