package zpp_nape.phys;
import nape.constraint.Constraint;
import nape.constraint.ConstraintList;
import nape.phys.Body;
import nape.phys.BodyList;
import nape.phys.Compound;
import nape.phys.CompoundList;
import zpp_nape.constraint.Constraint;
import zpp_nape.phys.Body;
import zpp_nape.phys.Interactor.ZPP_Interactor;
import zpp_nape.space.Space.ZPP_Space;
import zpp_nape.util.Lists.ZNPList_ZPP_Body;
import zpp_nape.util.Lists.ZNPList_ZPP_Compound;
import zpp_nape.util.Lists.ZNPList_ZPP_Constraint;
import zpp_nape.util.Lists.ZPP_BodyList;
import zpp_nape.util.Lists.ZPP_CompoundList;
import zpp_nape.util.Lists.ZPP_ConstraintList;
#if nape_swc@:keep #end
class ZPP_Compound extends ZPP_Interactor{
    public var outer:Compound=null;
    public var bodies:ZNPList_ZPP_Body=null;
    public var constraints:ZNPList_ZPP_Constraint=null;
    public var compounds:ZNPList_ZPP_Compound=null;
    public var wrap_bodies:BodyList=null;
    public var wrap_constraints:ConstraintList=null;
    public var wrap_compounds:CompoundList=null;
    public var depth:Int=0;
    public var compound:ZPP_Compound=null;
    public var space:ZPP_Space=null;
    public function __imutable_midstep(name:String){
        #if(!NAPE_RELEASE_BUILD)
        if(space!=null&&space.midstep)throw "Error: "+name+" cannot be set during space step()";
        #end
    }
    public function addedToSpace(){
        __iaddedToSpace();
    }
    public function removedFromSpace(){
        __iremovedFromSpace();
    }
    public function breakApart(){
        if(space!=null){
            __iremovedFromSpace();
            space.nullInteractorType(this);
        }
        if(compound!=null)compound.compounds.remove(this);
        else if(space!=null)space.compounds.remove(this);
        {
            while(!bodies.empty()){
                var b=bodies.pop_unsafe();
                {
                    if((b.compound=compound)!=null)compound.bodies.add(b);
                    else if(space!=null)space.bodies.add(b);
                    if(space!=null)space.freshInteractorType(b);
                };
            }
        };
        {
            while(!constraints.empty()){
                var c=constraints.pop_unsafe();
                {
                    if((c.compound=compound)!=null)compound.constraints.add(c);
                    else if(space!=null)space.constraints.add(c);
                };
            }
        };
        {
            while(!compounds.empty()){
                var c=compounds.pop_unsafe();
                {
                    if((c.compound=compound)!=null)compound.compounds.add(c);
                    else if(space!=null)space.compounds.add(c);
                    if(space!=null)space.freshInteractorType(c);
                };
            }
        };
        compound=null;
        space=null;
    }
    
    private function bodies_adder(x:Body){
        {}
        if(x.zpp_inner.compound!=this){
            if(x.zpp_inner.compound!=null)x.zpp_inner.compound.wrap_bodies.remove(x);
            else if(x.zpp_inner.space!=null)x.zpp_inner.space.wrap_bodies.remove(x);
            x.zpp_inner.compound=this;
            {};
            if(space!=null)space.addBody(x.zpp_inner);
            return true;
        }
        else return false;
    }
    private function bodies_subber(x:Body){
        x.zpp_inner.compound=null;
        {};
        if(space!=null)space.remBody(x.zpp_inner);
    }
    #if(!NAPE_RELEASE_BUILD)
    private function bodies_modifiable(){
        immutable_midstep("Compound::"+"bodies");
    }
    #end
    private function constraints_adder(x:Constraint){
        {}
        if(x.zpp_inner.compound!=this){
            if(x.zpp_inner.compound!=null)x.zpp_inner.compound.wrap_constraints.remove(x);
            else if(x.zpp_inner.space!=null)x.zpp_inner.space.wrap_constraints.remove(x);
            x.zpp_inner.compound=this;
            {};
            if(space!=null)space.addConstraint(x.zpp_inner);
            return true;
        }
        else return false;
    }
    private function constraints_subber(x:Constraint){
        x.zpp_inner.compound=null;
        {};
        if(space!=null)space.remConstraint(x.zpp_inner);
    }
    #if(!NAPE_RELEASE_BUILD)
    private function constraints_modifiable(){
        immutable_midstep("Compound::"+"constraints");
    }
    #end
    private function compounds_adder(x:Compound){
        #if(!NAPE_RELEASE_BUILD)
        var cur=this;
        while(cur!=null&&cur!=x.zpp_inner)cur=cur.compound;
        if(cur==x.zpp_inner){
            throw "Error: Assignment would cause a cycle in the Compound tree: assigning "+x.toString()+".compound = "+outer.toString();
            return false;
        }
        #end
        if(x.zpp_inner.compound!=this){
            if(x.zpp_inner.compound!=null)x.zpp_inner.compound.wrap_compounds.remove(x);
            else if(x.zpp_inner.space!=null)x.zpp_inner.space.wrap_compounds.remove(x);
            x.zpp_inner.compound=this;
            x.zpp_inner.depth=depth+1;
            if(space!=null)space.addCompound(x.zpp_inner);
            return true;
        }
        else return false;
    }
    private function compounds_subber(x:Compound){
        x.zpp_inner.compound=null;
        x.zpp_inner.depth=1;
        if(space!=null)space.remCompound(x.zpp_inner);
    }
    #if(!NAPE_RELEASE_BUILD)
    private function compounds_modifiable(){
        immutable_midstep("Compound::"+"compounds");
    }
    #end
    public function new(){
        super();
        icompound=this;
        depth=1;
        var me=this;
        bodies=new ZNPList_ZPP_Body();
        wrap_bodies=ZPP_BodyList.get(bodies);
        wrap_bodies.zpp_inner.adder=bodies_adder;
        wrap_bodies.zpp_inner.subber=bodies_subber;
        #if(!NAPE_RELEASE_BUILD)
        wrap_bodies.zpp_inner._modifiable=bodies_modifiable;
        #end
        constraints=new ZNPList_ZPP_Constraint();
        wrap_constraints=ZPP_ConstraintList.get(constraints);
        wrap_constraints.zpp_inner.adder=constraints_adder;
        wrap_constraints.zpp_inner.subber=constraints_subber;
        #if(!NAPE_RELEASE_BUILD)
        wrap_constraints.zpp_inner._modifiable=constraints_modifiable;
        #end
        compounds=new ZNPList_ZPP_Compound();
        wrap_compounds=ZPP_CompoundList.get(compounds);
        wrap_compounds.zpp_inner.adder=compounds_adder;
        wrap_compounds.zpp_inner.subber=compounds_subber;
        #if(!NAPE_RELEASE_BUILD)
        wrap_compounds.zpp_inner._modifiable=compounds_modifiable;
        #end
    }
    public function copy(dict:Array<ZPP_CopyHelper>=null,todo:Array<ZPP_CopyHelper>=null):Compound{
        var root=dict==null;
        if(dict==null)dict=new Array<ZPP_CopyHelper>();
        if(todo==null)todo=new Array<ZPP_CopyHelper>();
        var ret=new Compound();
        {
            var cx_ite=compounds.begin();
            while(cx_ite!=null){
                var c=cx_ite.elem();
                {
                    var cc=c.copy(dict,todo);
                    cc.compound=ret;
                };
                cx_ite=cx_ite.next;
            }
        };
        {
            var cx_ite=bodies.begin();
            while(cx_ite!=null){
                var b=cx_ite.elem();
                {
                    var bc=b.outer.copy();
                    dict.push(ZPP_CopyHelper.dict(b.id,bc));
                    bc.compound=ret;
                };
                cx_ite=cx_ite.next;
            }
        };
        {
            var cx_ite=constraints.begin();
            while(cx_ite!=null){
                var c=cx_ite.elem();
                {
                    var cc=c.copy(dict,todo);
                    cc.compound=ret;
                };
                cx_ite=cx_ite.next;
            }
        };
        if(root){
            while(todo.length>0){
                var xcb=todo.pop();
                for(idc in dict){
                    if(idc.id==xcb.id){
                        xcb.cb(idc.bc);
                        break;
                    }
                }
            }
        }
        copyto(ret);
        return ret;
    }
}
