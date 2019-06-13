package zpp_nape.dynamics;
import nape.dynamics.InteractionGroup;
import nape.dynamics.InteractionGroupList;
import nape.phys.InteractorList;
import zpp_nape.phys.Interactor.ZPP_Interactor;
import zpp_nape.util.Lists.ZNPList_ZPP_InteractionGroup;
import zpp_nape.util.Lists.ZNPList_ZPP_Interactor;
#if nape_swc@:keep #end
class ZPP_InteractionGroup{
    public var outer:InteractionGroup=null;
    public var ignore:Bool=false;
    public var group:ZPP_InteractionGroup=null;
    public function setGroup(group:ZPP_InteractionGroup){
        if(this.group!=group){
            if(this.group!=null){
                this.group.remGroup(this);
                this.group.invalidate(true);
            }
            this.group=group;
            if(group!=null){
                group.addGroup(this);
                group.invalidate(true);
            }
            else this.invalidate(true);
        }
    }
    public var groups:ZNPList_ZPP_InteractionGroup=null;
    public var wrap_groups:InteractionGroupList=null;
    public var interactors:ZNPList_ZPP_Interactor=null;
    public var wrap_interactors:InteractorList=null;
    public var depth:Int=0;
    public function invalidate(force=false){
        if(!(force||ignore))return;
        {
            var cx_ite=interactors.begin();
            while(cx_ite!=null){
                var b=cx_ite.elem();
                {
                    if(b.isBody())b.ibody.wake();
                    else if(b.isShape())b.ishape.body.wake();
                    else b.icompound.wake();
                };
                cx_ite=cx_ite.next;
            }
        };
        {
            var cx_ite=groups.begin();
            while(cx_ite!=null){
                var g=cx_ite.elem();
                g.invalidate(force);
                cx_ite=cx_ite.next;
            }
        };
    }
    public static var SHAPE=1;
    public static var BODY=2;
    public function new(){
        depth=0;
        groups=new ZNPList_ZPP_InteractionGroup();
        interactors=new ZNPList_ZPP_Interactor();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addGroup(group:ZPP_InteractionGroup){
        groups.add(group);
        group.depth=depth+1;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function remGroup(group:ZPP_InteractionGroup){
        groups.remove(group);
        group.depth=0;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addInteractor(intx:ZPP_Interactor){
        interactors.add(intx);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function remInteractor(intx:ZPP_Interactor,flag:Int=-1){
        interactors.remove(intx);
    }
}
