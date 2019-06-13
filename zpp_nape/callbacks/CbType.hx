package zpp_nape.callbacks;
import nape.callbacks.CbType;
import nape.constraint.ConstraintList;
import nape.phys.InteractorList;
import zpp_nape.ID.ZPP_ID;
import zpp_nape.callbacks.Listener.ZPP_BodyListener;
import zpp_nape.callbacks.Listener.ZPP_ConstraintListener;
import zpp_nape.callbacks.Listener.ZPP_InteractionListener;
import zpp_nape.callbacks.Listener.ZPP_Listener;
import zpp_nape.constraint.Constraint.ZPP_Constraint;
import zpp_nape.phys.Interactor.ZPP_Interactor;
import zpp_nape.util.Lists.ZNPList_ZPP_BodyListener;
import zpp_nape.util.Lists.ZNPList_ZPP_CbSet;
import zpp_nape.util.Lists.ZNPList_ZPP_Constraint;
import zpp_nape.util.Lists.ZNPList_ZPP_ConstraintListener;
import zpp_nape.util.Lists.ZNPList_ZPP_InteractionListener;
import zpp_nape.util.Lists.ZNPList_ZPP_Interactor;
#if nape_swc@:keep #end
class ZPP_CbType{
    public var outer:CbType=null;
    public var userData:Dynamic<Dynamic>=null;
    public var id:Int=0;
    public var cbsets:ZNPList_ZPP_CbSet=null;
    public#if NAPE_NO_INLINE#else inline #end
    static function setlt(a:ZPP_CbType,b:ZPP_CbType):Bool{
        return a.id<b.id;
    }
    public var interactors:ZNPList_ZPP_Interactor;
    public var wrap_interactors:InteractorList;
    public var constraints:ZNPList_ZPP_Constraint;
    public var wrap_constraints:ConstraintList;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addConstraint(con:ZPP_Constraint){
        constraints.add(con);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addInteractor(intx:ZPP_Interactor){
        interactors.add(intx);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function remConstraint(con:ZPP_Constraint){
        constraints.remove(con);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function remInteractor(intx:ZPP_Interactor){
        interactors.remove(intx);
    }
    public var listeners:ZNPList_ZPP_InteractionListener=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addint(x:ZPP_InteractionListener):Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !listeners.has(x);
            };
            if(!res)throw "assert("+"!listeners.has(x)"+") :: "+("listener already in list");
            #end
        };
        {
            var pre=null;
            {
                var cx_ite=listeners.begin();
                while(cx_ite!=null){
                    var j=cx_ite.elem();
                    {
                        if(ZPP_Listener.setlt(x,j))break;
                        pre=cx_ite;
                    };
                    cx_ite=cx_ite.next;
                }
            };
            listeners.inlined_insert(pre,x);
        };
        invalidateint();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function removeint(x:ZPP_InteractionListener):Void{
        listeners.remove(x);
        invalidateint();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidateint():Void{
        {
            var cx_ite=cbsets.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.invalidate_listeners();
                cx_ite=cx_ite.next;
            }
        };
    }
    public var bodylisteners:ZNPList_ZPP_BodyListener=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addbody(x:ZPP_BodyListener):Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !bodylisteners.has(x);
            };
            if(!res)throw "assert("+"!bodylisteners.has(x)"+") :: "+("listener already in list");
            #end
        };
        {
            var pre=null;
            {
                var cx_ite=bodylisteners.begin();
                while(cx_ite!=null){
                    var j=cx_ite.elem();
                    {
                        if(ZPP_Listener.setlt(x,j))break;
                        pre=cx_ite;
                    };
                    cx_ite=cx_ite.next;
                }
            };
            bodylisteners.inlined_insert(pre,x);
        };
        invalidatebody();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function removebody(x:ZPP_BodyListener):Void{
        bodylisteners.remove(x);
        invalidatebody();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidatebody():Void{
        {
            var cx_ite=cbsets.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.invalidate_bodylisteners();
                cx_ite=cx_ite.next;
            }
        };
    }
    public var conlisteners:ZNPList_ZPP_ConstraintListener=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addconstraint(x:ZPP_ConstraintListener):Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !conlisteners.has(x);
            };
            if(!res)throw "assert("+"!conlisteners.has(x)"+") :: "+("listener already in list");
            #end
        };
        {
            var pre=null;
            {
                var cx_ite=conlisteners.begin();
                while(cx_ite!=null){
                    var j=cx_ite.elem();
                    {
                        if(ZPP_Listener.setlt(x,j))break;
                        pre=cx_ite;
                    };
                    cx_ite=cx_ite.next;
                }
            };
            conlisteners.inlined_insert(pre,x);
        };
        invalidateconstraint();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function removeconstraint(x:ZPP_ConstraintListener):Void{
        conlisteners.remove(x);
        invalidateconstraint();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidateconstraint():Void{
        {
            var cx_ite=cbsets.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.invalidate_conlisteners();
                cx_ite=cx_ite.next;
            }
        };
    }
    public static var ANY_SHAPE=new CbType();
    public static var ANY_BODY=new CbType();
    public static var ANY_COMPOUND=new CbType();
    public static var ANY_CONSTRAINT=new CbType();
    public function new(){
        id=ZPP_ID.CbType();
        
        listeners=new ZNPList_ZPP_InteractionListener();
        bodylisteners=new ZNPList_ZPP_BodyListener();
        conlisteners=new ZNPList_ZPP_ConstraintListener();
        constraints=new ZNPList_ZPP_Constraint();
        interactors=new ZNPList_ZPP_Interactor();
        cbsets=new ZNPList_ZPP_CbSet();
    }
}
