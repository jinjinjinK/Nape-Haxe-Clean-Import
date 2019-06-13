package zpp_nape.callbacks;
import zpp_nape.callbacks.CbSet.ZPP_CbSet;
import zpp_nape.callbacks.Listener.ZPP_InteractionListener;
import zpp_nape.callbacks.Listener.ZPP_Listener;
import zpp_nape.util.Lists.ZNPList_ZPP_InteractionListener;
#if nape_swc@:keep #end
class ZPP_CbSetPair{
    public var a:ZPP_CbSet=null;
    public var b:ZPP_CbSet=null;
    public var next:ZPP_CbSetPair=null;
    static public var zpp_pool:ZPP_CbSetPair=null;
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
        a=b=null;
        listeners.clear();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc():Void{
        zip_listeners=true;
    }
    public function new(){
        listeners=new ZNPList_ZPP_InteractionListener();
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function get(a:ZPP_CbSet,b:ZPP_CbSet):ZPP_CbSetPair{
        var ret;
        {
            if(ZPP_CbSetPair.zpp_pool==null){
                ret=new ZPP_CbSetPair();
                #if NAPE_POOL_STATS ZPP_CbSetPair.POOL_TOT++;
                ZPP_CbSetPair.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_CbSetPair.zpp_pool;
                ZPP_CbSetPair.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_CbSetPair.POOL_CNT--;
                ZPP_CbSetPair.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        if(ZPP_CbSet.setlt(a,b)){
            ret.a=a;
            ret.b=b;
        }
        else{
            ret.a=b;
            ret.b=a;
        }
        return ret;
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function setlt(x:ZPP_CbSetPair,y:ZPP_CbSetPair):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                (x.a==y.a)==(!ZPP_CbSet.setlt(x.a,y.a)&&!ZPP_CbSet.setlt(y.a,x.a));
            };
            if(!res)throw "assert("+"(x.a==y.a)==(!ZPP_CbSet.setlt(x.a,y.a)&&!ZPP_CbSet.setlt(y.a,x.a))"+") :: "+("Assumption that CbSet's are unique!! Aka we can compare for 'equal' CbSet with == is wrong?? :(");
            #end
        };
        return ZPP_CbSet.setlt(x.a,y.a)||(x.a==y.a&&ZPP_CbSet.setlt(x.b,y.b));
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    #if NAPE_NO_INLINE#else inline #end
    function compatible(i:ZPP_InteractionListener):Bool{
        return(i.options1.compatible(a.cbTypes)&&i.options2.compatible(b.cbTypes))||(i.options2.compatible(a.cbTypes)&&i.options1.compatible(b.cbTypes));
    }
    public var zip_listeners:Bool=false;
    public var listeners:ZNPList_ZPP_InteractionListener=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidate():Void{
        zip_listeners=true;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function validate():Void{
        if(zip_listeners){
            zip_listeners=false;
            __validate();
        }
    }
    public function __validate():Void{
        listeners.clear();
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !a.zip_listeners;
            };
            if(!res)throw "assert("+"!a.zip_listeners"+") :: "+("a.listeners not validated??");
            #end
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !b.zip_listeners;
            };
            if(!res)throw "assert("+"!b.zip_listeners"+") :: "+("b.listeners not validated??");
            #end
        };
        var aite=a.listeners.begin();
        var bite=b.listeners.begin();
        while(aite!=null&&bite!=null){
            var ax=aite.elem();
            var bx=bite.elem();
            if(ax==bx){
                if(compatible(ax)){
                    listeners.add(ax);
                }
                aite=aite.next;
                bite=bite.next;
            }
            else if(ZPP_Listener.setlt(ax,bx))aite=aite.next;
            else bite=bite.next;
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function empty_intersection():Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !zip_listeners;
            };
            if(!res)throw "assert("+"!zip_listeners"+") :: "+("not validated before empty_intersection");
            #end
        };
        return listeners.empty();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function single_intersection(i:ZPP_InteractionListener):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !zip_listeners;
            };
            if(!res)throw "assert("+"!zip_listeners"+") :: "+("not validated before single_intersection");
            #end
        };
        var ite=listeners.begin();
        return ite!=null&&ite.elem()==i&&ite.next==null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function forall(event:Int,cb:ZPP_InteractionListener->Void):Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !zip_listeners;
            };
            if(!res)throw "assert("+"!zip_listeners"+") :: "+("not validated before forall");
            #end
        };
        {
            var cx_ite=listeners.begin();
            while(cx_ite!=null){
                var x=cx_ite.elem();
                {
                    if(x.event==event)cb(x);
                };
                cx_ite=cx_ite.next;
            }
        };
    }
}
