package zpp_nape.util;
import nape.geom.GeomPoly;
import nape.geom.Vec2;
import nape.geom.Vec3;
import zpp_nape.geom.GeomPoly;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.Vec3;
#if nape_swc@:keep #end
class ZPP_PubPool{
    
    public static var poolGeomPoly:GeomPoly=null;
    #if(!NAPE_RELEASE_BUILD)
    public static var nextGeomPoly:GeomPoly=null;
    #end
    public static var poolVec2:Vec2=null;
    #if(!NAPE_RELEASE_BUILD)
    public static var nextVec2:Vec2=null;
    #end
    public static var poolVec3:Vec3=null;
    #if(!NAPE_RELEASE_BUILD)
    public static var nextVec3:Vec3=null;
    #end
}
#if NAPE_POOL_STATS#if nape_swc@:keep #end
class ZPP_POOL_STATS{
    public static function pad(s:String,l:Int):String{
        var ret=s;
        while(ret.length<l)ret+=" ";
        return ret;
    }
    public static function dump():String{
        var ret="";
        ret+=pad("",30)+" #"+"Inuse/"+"Free  (+"+"Alloc("+"Heap )/-"+"Freed)\n";
        
        {
            if(ZNPNode_ZPP_CbType.POOL_TOT!=0||ZNPNode_ZPP_CbType.POOL_CNT!=0||ZNPNode_ZPP_CbType.POOL_ADD!=0||ZNPNode_ZPP_CbType.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_CbType",30)+" #"+pad(Std.string(ZNPNode_ZPP_CbType.POOL_TOT-ZNPNode_ZPP_CbType.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_CbType.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_CbType.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_CbType.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_CbType.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_CbType.POOL_ADD=ZNPNode_ZPP_CbType.POOL_SUB=ZNPNode_ZPP_CbType.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_CallbackSet.POOL_TOT!=0||ZNPNode_ZPP_CallbackSet.POOL_CNT!=0||ZNPNode_ZPP_CallbackSet.POOL_ADD!=0||ZNPNode_ZPP_CallbackSet.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_CallbackSet",30)+" #"+pad(Std.string(ZNPNode_ZPP_CallbackSet.POOL_TOT-ZNPNode_ZPP_CallbackSet.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_CallbackSet.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_CallbackSet.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_CallbackSet.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_CallbackSet.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_CallbackSet.POOL_ADD=ZNPNode_ZPP_CallbackSet.POOL_SUB=ZNPNode_ZPP_CallbackSet.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Material.POOL_TOT!=0||ZPP_Material.POOL_CNT!=0||ZPP_Material.POOL_ADD!=0||ZPP_Material.POOL_SUB!=0)ret+=pad("ZPP_Material",30)+" #"+pad(Std.string(ZPP_Material.POOL_TOT-ZPP_Material.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Material.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Material.POOL_ADD),5)+"("+pad(Std.string(ZPP_Material.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Material.POOL_SUB),5)+")\n";
            ZPP_Material.POOL_ADD=ZPP_Material.POOL_SUB=ZPP_Material.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Shape.POOL_TOT!=0||ZNPNode_ZPP_Shape.POOL_CNT!=0||ZNPNode_ZPP_Shape.POOL_ADD!=0||ZNPNode_ZPP_Shape.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Shape",30)+" #"+pad(Std.string(ZNPNode_ZPP_Shape.POOL_TOT-ZNPNode_ZPP_Shape.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Shape.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Shape.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Shape.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Shape.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Shape.POOL_ADD=ZNPNode_ZPP_Shape.POOL_SUB=ZNPNode_ZPP_Shape.POOL_ADDNEW=0;
        }
        {
            if(ZPP_FluidProperties.POOL_TOT!=0||ZPP_FluidProperties.POOL_CNT!=0||ZPP_FluidProperties.POOL_ADD!=0||ZPP_FluidProperties.POOL_SUB!=0)ret+=pad("ZPP_FluidProperties",30)+" #"+pad(Std.string(ZPP_FluidProperties.POOL_TOT-ZPP_FluidProperties.POOL_CNT),5)+"/"+pad(Std.string(ZPP_FluidProperties.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_FluidProperties.POOL_ADD),5)+"("+pad(Std.string(ZPP_FluidProperties.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_FluidProperties.POOL_SUB),5)+")\n";
            ZPP_FluidProperties.POOL_ADD=ZPP_FluidProperties.POOL_SUB=ZPP_FluidProperties.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Body.POOL_TOT!=0||ZNPNode_ZPP_Body.POOL_CNT!=0||ZNPNode_ZPP_Body.POOL_ADD!=0||ZNPNode_ZPP_Body.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Body",30)+" #"+pad(Std.string(ZNPNode_ZPP_Body.POOL_TOT-ZNPNode_ZPP_Body.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Body.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Body.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Body.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Body.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Body.POOL_ADD=ZNPNode_ZPP_Body.POOL_SUB=ZNPNode_ZPP_Body.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Constraint.POOL_TOT!=0||ZNPNode_ZPP_Constraint.POOL_CNT!=0||ZNPNode_ZPP_Constraint.POOL_ADD!=0||ZNPNode_ZPP_Constraint.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Constraint",30)+" #"+pad(Std.string(ZNPNode_ZPP_Constraint.POOL_TOT-ZNPNode_ZPP_Constraint.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Constraint.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Constraint.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Constraint.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Constraint.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Constraint.POOL_ADD=ZNPNode_ZPP_Constraint.POOL_SUB=ZNPNode_ZPP_Constraint.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Compound.POOL_TOT!=0||ZNPNode_ZPP_Compound.POOL_CNT!=0||ZNPNode_ZPP_Compound.POOL_ADD!=0||ZNPNode_ZPP_Compound.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Compound",30)+" #"+pad(Std.string(ZNPNode_ZPP_Compound.POOL_TOT-ZNPNode_ZPP_Compound.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Compound.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Compound.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Compound.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Compound.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Compound.POOL_ADD=ZNPNode_ZPP_Compound.POOL_SUB=ZNPNode_ZPP_Compound.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Arbiter.POOL_TOT!=0||ZNPNode_ZPP_Arbiter.POOL_CNT!=0||ZNPNode_ZPP_Arbiter.POOL_ADD!=0||ZNPNode_ZPP_Arbiter.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Arbiter",30)+" #"+pad(Std.string(ZNPNode_ZPP_Arbiter.POOL_TOT-ZNPNode_ZPP_Arbiter.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Arbiter.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Arbiter.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Arbiter.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Arbiter.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Arbiter.POOL_ADD=ZNPNode_ZPP_Arbiter.POOL_SUB=ZNPNode_ZPP_Arbiter.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Set_ZPP_Body.POOL_TOT!=0||ZPP_Set_ZPP_Body.POOL_CNT!=0||ZPP_Set_ZPP_Body.POOL_ADD!=0||ZPP_Set_ZPP_Body.POOL_SUB!=0)ret+=pad("ZPP_Set_ZPP_Body",30)+" #"+pad(Std.string(ZPP_Set_ZPP_Body.POOL_TOT-ZPP_Set_ZPP_Body.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Set_ZPP_Body.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Set_ZPP_Body.POOL_ADD),5)+"("+pad(Std.string(ZPP_Set_ZPP_Body.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Set_ZPP_Body.POOL_SUB),5)+")\n";
            ZPP_Set_ZPP_Body.POOL_ADD=ZPP_Set_ZPP_Body.POOL_SUB=ZPP_Set_ZPP_Body.POOL_ADDNEW=0;
        }
        {
            if(ZPP_CbSetPair.POOL_TOT!=0||ZPP_CbSetPair.POOL_CNT!=0||ZPP_CbSetPair.POOL_ADD!=0||ZPP_CbSetPair.POOL_SUB!=0)ret+=pad("ZPP_CbSetPair",30)+" #"+pad(Std.string(ZPP_CbSetPair.POOL_TOT-ZPP_CbSetPair.POOL_CNT),5)+"/"+pad(Std.string(ZPP_CbSetPair.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_CbSetPair.POOL_ADD),5)+"("+pad(Std.string(ZPP_CbSetPair.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_CbSetPair.POOL_SUB),5)+")\n";
            ZPP_CbSetPair.POOL_ADD=ZPP_CbSetPair.POOL_SUB=ZPP_CbSetPair.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_InteractionListener.POOL_TOT!=0||ZNPNode_ZPP_InteractionListener.POOL_CNT!=0||ZNPNode_ZPP_InteractionListener.POOL_ADD!=0||ZNPNode_ZPP_InteractionListener.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_InteractionListener",30)+" #"+pad(Std.string(ZNPNode_ZPP_InteractionListener.POOL_TOT-ZNPNode_ZPP_InteractionListener.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_InteractionListener.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_InteractionListener.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_InteractionListener.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_InteractionListener.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_InteractionListener.POOL_ADD=ZNPNode_ZPP_InteractionListener.POOL_SUB=ZNPNode_ZPP_InteractionListener.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_CbSet.POOL_TOT!=0||ZNPNode_ZPP_CbSet.POOL_CNT!=0||ZNPNode_ZPP_CbSet.POOL_ADD!=0||ZNPNode_ZPP_CbSet.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_CbSet",30)+" #"+pad(Std.string(ZNPNode_ZPP_CbSet.POOL_TOT-ZNPNode_ZPP_CbSet.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_CbSet.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_CbSet.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_CbSet.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_CbSet.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_CbSet.POOL_ADD=ZNPNode_ZPP_CbSet.POOL_SUB=ZNPNode_ZPP_CbSet.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Interactor.POOL_TOT!=0||ZNPNode_ZPP_Interactor.POOL_CNT!=0||ZNPNode_ZPP_Interactor.POOL_ADD!=0||ZNPNode_ZPP_Interactor.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Interactor",30)+" #"+pad(Std.string(ZNPNode_ZPP_Interactor.POOL_TOT-ZNPNode_ZPP_Interactor.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Interactor.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Interactor.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Interactor.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Interactor.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Interactor.POOL_ADD=ZNPNode_ZPP_Interactor.POOL_SUB=ZNPNode_ZPP_Interactor.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_BodyListener.POOL_TOT!=0||ZNPNode_ZPP_BodyListener.POOL_CNT!=0||ZNPNode_ZPP_BodyListener.POOL_ADD!=0||ZNPNode_ZPP_BodyListener.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_BodyListener",30)+" #"+pad(Std.string(ZNPNode_ZPP_BodyListener.POOL_TOT-ZNPNode_ZPP_BodyListener.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_BodyListener.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_BodyListener.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_BodyListener.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_BodyListener.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_BodyListener.POOL_ADD=ZNPNode_ZPP_BodyListener.POOL_SUB=ZNPNode_ZPP_BodyListener.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Callback.POOL_TOT!=0||ZPP_Callback.POOL_CNT!=0||ZPP_Callback.POOL_ADD!=0||ZPP_Callback.POOL_SUB!=0)ret+=pad("ZPP_Callback",30)+" #"+pad(Std.string(ZPP_Callback.POOL_TOT-ZPP_Callback.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Callback.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Callback.POOL_ADD),5)+"("+pad(Std.string(ZPP_Callback.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Callback.POOL_SUB),5)+")\n";
            ZPP_Callback.POOL_ADD=ZPP_Callback.POOL_SUB=ZPP_Callback.POOL_ADDNEW=0;
        }
        {
            if(ZPP_CbSet.POOL_TOT!=0||ZPP_CbSet.POOL_CNT!=0||ZPP_CbSet.POOL_ADD!=0||ZPP_CbSet.POOL_SUB!=0)ret+=pad("ZPP_CbSet",30)+" #"+pad(Std.string(ZPP_CbSet.POOL_TOT-ZPP_CbSet.POOL_CNT),5)+"/"+pad(Std.string(ZPP_CbSet.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_CbSet.POOL_ADD),5)+"("+pad(Std.string(ZPP_CbSet.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_CbSet.POOL_SUB),5)+")\n";
            ZPP_CbSet.POOL_ADD=ZPP_CbSet.POOL_SUB=ZPP_CbSet.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_CbSetPair.POOL_TOT!=0||ZNPNode_ZPP_CbSetPair.POOL_CNT!=0||ZNPNode_ZPP_CbSetPair.POOL_ADD!=0||ZNPNode_ZPP_CbSetPair.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_CbSetPair",30)+" #"+pad(Std.string(ZNPNode_ZPP_CbSetPair.POOL_TOT-ZNPNode_ZPP_CbSetPair.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_CbSetPair.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_CbSetPair.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_CbSetPair.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_CbSetPair.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_CbSetPair.POOL_ADD=ZNPNode_ZPP_CbSetPair.POOL_SUB=ZNPNode_ZPP_CbSetPair.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_ConstraintListener.POOL_TOT!=0||ZNPNode_ZPP_ConstraintListener.POOL_CNT!=0||ZNPNode_ZPP_ConstraintListener.POOL_ADD!=0||ZNPNode_ZPP_ConstraintListener.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_ConstraintListener",30)+" #"+pad(Std.string(ZNPNode_ZPP_ConstraintListener.POOL_TOT-ZNPNode_ZPP_ConstraintListener.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_ConstraintListener.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_ConstraintListener.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_ConstraintListener.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_ConstraintListener.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_ConstraintListener.POOL_ADD=ZNPNode_ZPP_ConstraintListener.POOL_SUB=ZNPNode_ZPP_ConstraintListener.POOL_ADDNEW=0;
        }
        {
            if(ZPP_GeomVert.POOL_TOT!=0||ZPP_GeomVert.POOL_CNT!=0||ZPP_GeomVert.POOL_ADD!=0||ZPP_GeomVert.POOL_SUB!=0)ret+=pad("ZPP_GeomVert",30)+" #"+pad(Std.string(ZPP_GeomVert.POOL_TOT-ZPP_GeomVert.POOL_CNT),5)+"/"+pad(Std.string(ZPP_GeomVert.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_GeomVert.POOL_ADD),5)+"("+pad(Std.string(ZPP_GeomVert.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_GeomVert.POOL_SUB),5)+")\n";
            ZPP_GeomVert.POOL_ADD=ZPP_GeomVert.POOL_SUB=ZPP_GeomVert.POOL_ADDNEW=0;
        }
        {
            if(ZPP_GeomVertexIterator.POOL_TOT!=0||ZPP_GeomVertexIterator.POOL_CNT!=0||ZPP_GeomVertexIterator.POOL_ADD!=0||ZPP_GeomVertexIterator.POOL_SUB!=0)ret+=pad("ZPP_GeomVertexIterator",30)+" #"+pad(Std.string(ZPP_GeomVertexIterator.POOL_TOT-ZPP_GeomVertexIterator.POOL_CNT),5)+"/"+pad(Std.string(ZPP_GeomVertexIterator.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_GeomVertexIterator.POOL_ADD),5)+"("+pad(Std.string(ZPP_GeomVertexIterator.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_GeomVertexIterator.POOL_SUB),5)+")\n";
            ZPP_GeomVertexIterator.POOL_ADD=ZPP_GeomVertexIterator.POOL_SUB=ZPP_GeomVertexIterator.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Mat23.POOL_TOT!=0||ZPP_Mat23.POOL_CNT!=0||ZPP_Mat23.POOL_ADD!=0||ZPP_Mat23.POOL_SUB!=0)ret+=pad("ZPP_Mat23",30)+" #"+pad(Std.string(ZPP_Mat23.POOL_TOT-ZPP_Mat23.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Mat23.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Mat23.POOL_ADD),5)+"("+pad(Std.string(ZPP_Mat23.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Mat23.POOL_SUB),5)+")\n";
            ZPP_Mat23.POOL_ADD=ZPP_Mat23.POOL_SUB=ZPP_Mat23.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Set_ZPP_CbSetPair.POOL_TOT!=0||ZPP_Set_ZPP_CbSetPair.POOL_CNT!=0||ZPP_Set_ZPP_CbSetPair.POOL_ADD!=0||ZPP_Set_ZPP_CbSetPair.POOL_SUB!=0)ret+=pad("ZPP_Set_ZPP_CbSetPair",30)+" #"+pad(Std.string(ZPP_Set_ZPP_CbSetPair.POOL_TOT-ZPP_Set_ZPP_CbSetPair.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Set_ZPP_CbSetPair.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Set_ZPP_CbSetPair.POOL_ADD),5)+"("+pad(Std.string(ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Set_ZPP_CbSetPair.POOL_SUB),5)+")\n";
            ZPP_Set_ZPP_CbSetPair.POOL_ADD=ZPP_Set_ZPP_CbSetPair.POOL_SUB=ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW=0;
        }
        {
            if(ZPP_CutVert.POOL_TOT!=0||ZPP_CutVert.POOL_CNT!=0||ZPP_CutVert.POOL_ADD!=0||ZPP_CutVert.POOL_SUB!=0)ret+=pad("ZPP_CutVert",30)+" #"+pad(Std.string(ZPP_CutVert.POOL_TOT-ZPP_CutVert.POOL_CNT),5)+"/"+pad(Std.string(ZPP_CutVert.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_CutVert.POOL_ADD),5)+"("+pad(Std.string(ZPP_CutVert.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_CutVert.POOL_SUB),5)+")\n";
            ZPP_CutVert.POOL_ADD=ZPP_CutVert.POOL_SUB=ZPP_CutVert.POOL_ADDNEW=0;
        }
        {
            if(ZPP_CutInt.POOL_TOT!=0||ZPP_CutInt.POOL_CNT!=0||ZPP_CutInt.POOL_ADD!=0||ZPP_CutInt.POOL_SUB!=0)ret+=pad("ZPP_CutInt",30)+" #"+pad(Std.string(ZPP_CutInt.POOL_TOT-ZPP_CutInt.POOL_CNT),5)+"/"+pad(Std.string(ZPP_CutInt.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_CutInt.POOL_ADD),5)+"("+pad(Std.string(ZPP_CutInt.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_CutInt.POOL_SUB),5)+")\n";
            ZPP_CutInt.POOL_ADD=ZPP_CutInt.POOL_SUB=ZPP_CutInt.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_CutInt.POOL_TOT!=0||ZNPNode_ZPP_CutInt.POOL_CNT!=0||ZNPNode_ZPP_CutInt.POOL_ADD!=0||ZNPNode_ZPP_CutInt.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_CutInt",30)+" #"+pad(Std.string(ZNPNode_ZPP_CutInt.POOL_TOT-ZNPNode_ZPP_CutInt.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_CutInt.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_CutInt.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_CutInt.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_CutInt.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_CutInt.POOL_ADD=ZNPNode_ZPP_CutInt.POOL_SUB=ZNPNode_ZPP_CutInt.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_CutVert.POOL_TOT!=0||ZNPNode_ZPP_CutVert.POOL_CNT!=0||ZNPNode_ZPP_CutVert.POOL_ADD!=0||ZNPNode_ZPP_CutVert.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_CutVert",30)+" #"+pad(Std.string(ZNPNode_ZPP_CutVert.POOL_TOT-ZNPNode_ZPP_CutVert.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_CutVert.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_CutVert.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_CutVert.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_CutVert.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_CutVert.POOL_ADD=ZNPNode_ZPP_CutVert.POOL_SUB=ZNPNode_ZPP_CutVert.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Vec2.POOL_TOT!=0||ZPP_Vec2.POOL_CNT!=0||ZPP_Vec2.POOL_ADD!=0||ZPP_Vec2.POOL_SUB!=0)ret+=pad("ZPP_Vec2",30)+" #"+pad(Std.string(ZPP_Vec2.POOL_TOT-ZPP_Vec2.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Vec2.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Vec2.POOL_ADD),5)+"("+pad(Std.string(ZPP_Vec2.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Vec2.POOL_SUB),5)+")\n";
            ZPP_Vec2.POOL_ADD=ZPP_Vec2.POOL_SUB=ZPP_Vec2.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_PartitionVertex.POOL_TOT!=0||ZNPNode_ZPP_PartitionVertex.POOL_CNT!=0||ZNPNode_ZPP_PartitionVertex.POOL_ADD!=0||ZNPNode_ZPP_PartitionVertex.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_PartitionVertex",30)+" #"+pad(Std.string(ZNPNode_ZPP_PartitionVertex.POOL_TOT-ZNPNode_ZPP_PartitionVertex.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_PartitionVertex.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_PartitionVertex.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_PartitionVertex.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_PartitionVertex.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_PartitionVertex.POOL_ADD=ZNPNode_ZPP_PartitionVertex.POOL_SUB=ZNPNode_ZPP_PartitionVertex.POOL_ADDNEW=0;
        }
        {
            if(ZPP_PartitionVertex.POOL_TOT!=0||ZPP_PartitionVertex.POOL_CNT!=0||ZPP_PartitionVertex.POOL_ADD!=0||ZPP_PartitionVertex.POOL_SUB!=0)ret+=pad("ZPP_PartitionVertex",30)+" #"+pad(Std.string(ZPP_PartitionVertex.POOL_TOT-ZPP_PartitionVertex.POOL_CNT),5)+"/"+pad(Std.string(ZPP_PartitionVertex.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_PartitionVertex.POOL_ADD),5)+"("+pad(Std.string(ZPP_PartitionVertex.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_PartitionVertex.POOL_SUB),5)+")\n";
            ZPP_PartitionVertex.POOL_ADD=ZPP_PartitionVertex.POOL_SUB=ZPP_PartitionVertex.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Set_ZPP_PartitionVertex.POOL_TOT!=0||ZPP_Set_ZPP_PartitionVertex.POOL_CNT!=0||ZPP_Set_ZPP_PartitionVertex.POOL_ADD!=0||ZPP_Set_ZPP_PartitionVertex.POOL_SUB!=0)ret+=pad("ZPP_Set_ZPP_PartitionVertex",30)+" #"+pad(Std.string(ZPP_Set_ZPP_PartitionVertex.POOL_TOT-ZPP_Set_ZPP_PartitionVertex.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Set_ZPP_PartitionVertex.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Set_ZPP_PartitionVertex.POOL_ADD),5)+"("+pad(Std.string(ZPP_Set_ZPP_PartitionVertex.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Set_ZPP_PartitionVertex.POOL_SUB),5)+")\n";
            ZPP_Set_ZPP_PartitionVertex.POOL_ADD=ZPP_Set_ZPP_PartitionVertex.POOL_SUB=ZPP_Set_ZPP_PartitionVertex.POOL_ADDNEW=0;
        }
        {
            if(ZPP_SimplifyV.POOL_TOT!=0||ZPP_SimplifyV.POOL_CNT!=0||ZPP_SimplifyV.POOL_ADD!=0||ZPP_SimplifyV.POOL_SUB!=0)ret+=pad("ZPP_SimplifyV",30)+" #"+pad(Std.string(ZPP_SimplifyV.POOL_TOT-ZPP_SimplifyV.POOL_CNT),5)+"/"+pad(Std.string(ZPP_SimplifyV.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_SimplifyV.POOL_ADD),5)+"("+pad(Std.string(ZPP_SimplifyV.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_SimplifyV.POOL_SUB),5)+")\n";
            ZPP_SimplifyV.POOL_ADD=ZPP_SimplifyV.POOL_SUB=ZPP_SimplifyV.POOL_ADDNEW=0;
        }
        {
            if(ZPP_SimplifyP.POOL_TOT!=0||ZPP_SimplifyP.POOL_CNT!=0||ZPP_SimplifyP.POOL_ADD!=0||ZPP_SimplifyP.POOL_SUB!=0)ret+=pad("ZPP_SimplifyP",30)+" #"+pad(Std.string(ZPP_SimplifyP.POOL_TOT-ZPP_SimplifyP.POOL_CNT),5)+"/"+pad(Std.string(ZPP_SimplifyP.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_SimplifyP.POOL_ADD),5)+"("+pad(Std.string(ZPP_SimplifyP.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_SimplifyP.POOL_SUB),5)+")\n";
            ZPP_SimplifyP.POOL_ADD=ZPP_SimplifyP.POOL_SUB=ZPP_SimplifyP.POOL_ADDNEW=0;
        }
        {
            if(ZPP_PartitionedPoly.POOL_TOT!=0||ZPP_PartitionedPoly.POOL_CNT!=0||ZPP_PartitionedPoly.POOL_ADD!=0||ZPP_PartitionedPoly.POOL_SUB!=0)ret+=pad("ZPP_PartitionedPoly",30)+" #"+pad(Std.string(ZPP_PartitionedPoly.POOL_TOT-ZPP_PartitionedPoly.POOL_CNT),5)+"/"+pad(Std.string(ZPP_PartitionedPoly.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_PartitionedPoly.POOL_ADD),5)+"("+pad(Std.string(ZPP_PartitionedPoly.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_PartitionedPoly.POOL_SUB),5)+")\n";
            ZPP_PartitionedPoly.POOL_ADD=ZPP_PartitionedPoly.POOL_SUB=ZPP_PartitionedPoly.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_SimplifyP.POOL_TOT!=0||ZNPNode_ZPP_SimplifyP.POOL_CNT!=0||ZNPNode_ZPP_SimplifyP.POOL_ADD!=0||ZNPNode_ZPP_SimplifyP.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_SimplifyP",30)+" #"+pad(Std.string(ZNPNode_ZPP_SimplifyP.POOL_TOT-ZNPNode_ZPP_SimplifyP.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_SimplifyP.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_SimplifyP.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_SimplifyP.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_SimplifyP.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_SimplifyP.POOL_ADD=ZNPNode_ZPP_SimplifyP.POOL_SUB=ZNPNode_ZPP_SimplifyP.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_PartitionedPoly.POOL_TOT!=0||ZNPNode_ZPP_PartitionedPoly.POOL_CNT!=0||ZNPNode_ZPP_PartitionedPoly.POOL_ADD!=0||ZNPNode_ZPP_PartitionedPoly.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_PartitionedPoly",30)+" #"+pad(Std.string(ZNPNode_ZPP_PartitionedPoly.POOL_TOT-ZNPNode_ZPP_PartitionedPoly.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_PartitionedPoly.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_PartitionedPoly.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_PartitionedPoly.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_PartitionedPoly.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_PartitionedPoly.POOL_ADD=ZNPNode_ZPP_PartitionedPoly.POOL_SUB=ZNPNode_ZPP_PartitionedPoly.POOL_ADDNEW=0;
        }
        {
            if(ZPP_PartitionPair.POOL_TOT!=0||ZPP_PartitionPair.POOL_CNT!=0||ZPP_PartitionPair.POOL_ADD!=0||ZPP_PartitionPair.POOL_SUB!=0)ret+=pad("ZPP_PartitionPair",30)+" #"+pad(Std.string(ZPP_PartitionPair.POOL_TOT-ZPP_PartitionPair.POOL_CNT),5)+"/"+pad(Std.string(ZPP_PartitionPair.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_PartitionPair.POOL_ADD),5)+"("+pad(Std.string(ZPP_PartitionPair.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_PartitionPair.POOL_SUB),5)+")\n";
            ZPP_PartitionPair.POOL_ADD=ZPP_PartitionPair.POOL_SUB=ZPP_PartitionPair.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Set_ZPP_PartitionPair.POOL_TOT!=0||ZPP_Set_ZPP_PartitionPair.POOL_CNT!=0||ZPP_Set_ZPP_PartitionPair.POOL_ADD!=0||ZPP_Set_ZPP_PartitionPair.POOL_SUB!=0)ret+=pad("ZPP_Set_ZPP_PartitionPair",30)+" #"+pad(Std.string(ZPP_Set_ZPP_PartitionPair.POOL_TOT-ZPP_Set_ZPP_PartitionPair.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Set_ZPP_PartitionPair.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Set_ZPP_PartitionPair.POOL_ADD),5)+"("+pad(Std.string(ZPP_Set_ZPP_PartitionPair.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Set_ZPP_PartitionPair.POOL_SUB),5)+")\n";
            ZPP_Set_ZPP_PartitionPair.POOL_ADD=ZPP_Set_ZPP_PartitionPair.POOL_SUB=ZPP_Set_ZPP_PartitionPair.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_GeomVert.POOL_TOT!=0||ZNPNode_ZPP_GeomVert.POOL_CNT!=0||ZNPNode_ZPP_GeomVert.POOL_ADD!=0||ZNPNode_ZPP_GeomVert.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_GeomVert",30)+" #"+pad(Std.string(ZNPNode_ZPP_GeomVert.POOL_TOT-ZNPNode_ZPP_GeomVert.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_GeomVert.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_GeomVert.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_GeomVert.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_GeomVert.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_GeomVert.POOL_ADD=ZNPNode_ZPP_GeomVert.POOL_SUB=ZNPNode_ZPP_GeomVert.POOL_ADDNEW=0;
        }
        {
            if(ZPP_AABB.POOL_TOT!=0||ZPP_AABB.POOL_CNT!=0||ZPP_AABB.POOL_ADD!=0||ZPP_AABB.POOL_SUB!=0)ret+=pad("ZPP_AABB",30)+" #"+pad(Std.string(ZPP_AABB.POOL_TOT-ZPP_AABB.POOL_CNT),5)+"/"+pad(Std.string(ZPP_AABB.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_AABB.POOL_ADD),5)+"("+pad(Std.string(ZPP_AABB.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_AABB.POOL_SUB),5)+")\n";
            ZPP_AABB.POOL_ADD=ZPP_AABB.POOL_SUB=ZPP_AABB.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Set_ZPP_SimpleVert.POOL_TOT!=0||ZPP_Set_ZPP_SimpleVert.POOL_CNT!=0||ZPP_Set_ZPP_SimpleVert.POOL_ADD!=0||ZPP_Set_ZPP_SimpleVert.POOL_SUB!=0)ret+=pad("ZPP_Set_ZPP_SimpleVert",30)+" #"+pad(Std.string(ZPP_Set_ZPP_SimpleVert.POOL_TOT-ZPP_Set_ZPP_SimpleVert.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Set_ZPP_SimpleVert.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Set_ZPP_SimpleVert.POOL_ADD),5)+"("+pad(Std.string(ZPP_Set_ZPP_SimpleVert.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Set_ZPP_SimpleVert.POOL_SUB),5)+")\n";
            ZPP_Set_ZPP_SimpleVert.POOL_ADD=ZPP_Set_ZPP_SimpleVert.POOL_SUB=ZPP_Set_ZPP_SimpleVert.POOL_ADDNEW=0;
        }
        {
            if(ZPP_SimpleVert.POOL_TOT!=0||ZPP_SimpleVert.POOL_CNT!=0||ZPP_SimpleVert.POOL_ADD!=0||ZPP_SimpleVert.POOL_SUB!=0)ret+=pad("ZPP_SimpleVert",30)+" #"+pad(Std.string(ZPP_SimpleVert.POOL_TOT-ZPP_SimpleVert.POOL_CNT),5)+"/"+pad(Std.string(ZPP_SimpleVert.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_SimpleVert.POOL_ADD),5)+"("+pad(Std.string(ZPP_SimpleVert.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_SimpleVert.POOL_SUB),5)+")\n";
            ZPP_SimpleVert.POOL_ADD=ZPP_SimpleVert.POOL_SUB=ZPP_SimpleVert.POOL_ADDNEW=0;
        }
        {
            if(ZPP_SimpleSeg.POOL_TOT!=0||ZPP_SimpleSeg.POOL_CNT!=0||ZPP_SimpleSeg.POOL_ADD!=0||ZPP_SimpleSeg.POOL_SUB!=0)ret+=pad("ZPP_SimpleSeg",30)+" #"+pad(Std.string(ZPP_SimpleSeg.POOL_TOT-ZPP_SimpleSeg.POOL_CNT),5)+"/"+pad(Std.string(ZPP_SimpleSeg.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_SimpleSeg.POOL_ADD),5)+"("+pad(Std.string(ZPP_SimpleSeg.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_SimpleSeg.POOL_SUB),5)+")\n";
            ZPP_SimpleSeg.POOL_ADD=ZPP_SimpleSeg.POOL_SUB=ZPP_SimpleSeg.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Set_ZPP_SimpleSeg.POOL_TOT!=0||ZPP_Set_ZPP_SimpleSeg.POOL_CNT!=0||ZPP_Set_ZPP_SimpleSeg.POOL_ADD!=0||ZPP_Set_ZPP_SimpleSeg.POOL_SUB!=0)ret+=pad("ZPP_Set_ZPP_SimpleSeg",30)+" #"+pad(Std.string(ZPP_Set_ZPP_SimpleSeg.POOL_TOT-ZPP_Set_ZPP_SimpleSeg.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Set_ZPP_SimpleSeg.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Set_ZPP_SimpleSeg.POOL_ADD),5)+"("+pad(Std.string(ZPP_Set_ZPP_SimpleSeg.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Set_ZPP_SimpleSeg.POOL_SUB),5)+")\n";
            ZPP_Set_ZPP_SimpleSeg.POOL_ADD=ZPP_Set_ZPP_SimpleSeg.POOL_SUB=ZPP_Set_ZPP_SimpleSeg.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Set_ZPP_SimpleEvent.POOL_TOT!=0||ZPP_Set_ZPP_SimpleEvent.POOL_CNT!=0||ZPP_Set_ZPP_SimpleEvent.POOL_ADD!=0||ZPP_Set_ZPP_SimpleEvent.POOL_SUB!=0)ret+=pad("ZPP_Set_ZPP_SimpleEvent",30)+" #"+pad(Std.string(ZPP_Set_ZPP_SimpleEvent.POOL_TOT-ZPP_Set_ZPP_SimpleEvent.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Set_ZPP_SimpleEvent.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Set_ZPP_SimpleEvent.POOL_ADD),5)+"("+pad(Std.string(ZPP_Set_ZPP_SimpleEvent.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Set_ZPP_SimpleEvent.POOL_SUB),5)+")\n";
            ZPP_Set_ZPP_SimpleEvent.POOL_ADD=ZPP_Set_ZPP_SimpleEvent.POOL_SUB=ZPP_Set_ZPP_SimpleEvent.POOL_ADDNEW=0;
        }
        {
            if(ZPP_SimpleEvent.POOL_TOT!=0||ZPP_SimpleEvent.POOL_CNT!=0||ZPP_SimpleEvent.POOL_ADD!=0||ZPP_SimpleEvent.POOL_SUB!=0)ret+=pad("ZPP_SimpleEvent",30)+" #"+pad(Std.string(ZPP_SimpleEvent.POOL_TOT-ZPP_SimpleEvent.POOL_CNT),5)+"/"+pad(Std.string(ZPP_SimpleEvent.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_SimpleEvent.POOL_ADD),5)+"("+pad(Std.string(ZPP_SimpleEvent.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_SimpleEvent.POOL_SUB),5)+")\n";
            ZPP_SimpleEvent.POOL_ADD=ZPP_SimpleEvent.POOL_SUB=ZPP_SimpleEvent.POOL_ADDNEW=0;
        }
        {
            if(Hashable2_Boolfalse.POOL_TOT!=0||Hashable2_Boolfalse.POOL_CNT!=0||Hashable2_Boolfalse.POOL_ADD!=0||Hashable2_Boolfalse.POOL_SUB!=0)ret+=pad("Hashable2_Boolfalse",30)+" #"+pad(Std.string(Hashable2_Boolfalse.POOL_TOT-Hashable2_Boolfalse.POOL_CNT),5)+"/"+pad(Std.string(Hashable2_Boolfalse.POOL_CNT),5)+" (+"+pad(Std.string(Hashable2_Boolfalse.POOL_ADD),5)+"("+pad(Std.string(Hashable2_Boolfalse.POOL_ADDNEW),5)+")/-"+pad(Std.string(Hashable2_Boolfalse.POOL_SUB),5)+")\n";
            Hashable2_Boolfalse.POOL_ADD=Hashable2_Boolfalse.POOL_SUB=Hashable2_Boolfalse.POOL_ADDNEW=0;
        }
        {
            if(ZPP_ToiEvent.POOL_TOT!=0||ZPP_ToiEvent.POOL_CNT!=0||ZPP_ToiEvent.POOL_ADD!=0||ZPP_ToiEvent.POOL_SUB!=0)ret+=pad("ZPP_ToiEvent",30)+" #"+pad(Std.string(ZPP_ToiEvent.POOL_TOT-ZPP_ToiEvent.POOL_CNT),5)+"/"+pad(Std.string(ZPP_ToiEvent.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_ToiEvent.POOL_ADD),5)+"("+pad(Std.string(ZPP_ToiEvent.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_ToiEvent.POOL_SUB),5)+")\n";
            ZPP_ToiEvent.POOL_ADD=ZPP_ToiEvent.POOL_SUB=ZPP_ToiEvent.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_SimpleVert.POOL_TOT!=0||ZNPNode_ZPP_SimpleVert.POOL_CNT!=0||ZNPNode_ZPP_SimpleVert.POOL_ADD!=0||ZNPNode_ZPP_SimpleVert.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_SimpleVert",30)+" #"+pad(Std.string(ZNPNode_ZPP_SimpleVert.POOL_TOT-ZNPNode_ZPP_SimpleVert.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_SimpleVert.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_SimpleVert.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_SimpleVert.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_SimpleVert.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_SimpleVert.POOL_ADD=ZNPNode_ZPP_SimpleVert.POOL_SUB=ZNPNode_ZPP_SimpleVert.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_SimpleEvent.POOL_TOT!=0||ZNPNode_ZPP_SimpleEvent.POOL_CNT!=0||ZNPNode_ZPP_SimpleEvent.POOL_ADD!=0||ZNPNode_ZPP_SimpleEvent.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_SimpleEvent",30)+" #"+pad(Std.string(ZNPNode_ZPP_SimpleEvent.POOL_TOT-ZNPNode_ZPP_SimpleEvent.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_SimpleEvent.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_SimpleEvent.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_SimpleEvent.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_SimpleEvent.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_SimpleEvent.POOL_ADD=ZNPNode_ZPP_SimpleEvent.POOL_SUB=ZNPNode_ZPP_SimpleEvent.POOL_ADDNEW=0;
        }
        {
            if(ZPP_MarchSpan.POOL_TOT!=0||ZPP_MarchSpan.POOL_CNT!=0||ZPP_MarchSpan.POOL_ADD!=0||ZPP_MarchSpan.POOL_SUB!=0)ret+=pad("ZPP_MarchSpan",30)+" #"+pad(Std.string(ZPP_MarchSpan.POOL_TOT-ZPP_MarchSpan.POOL_CNT),5)+"/"+pad(Std.string(ZPP_MarchSpan.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_MarchSpan.POOL_ADD),5)+"("+pad(Std.string(ZPP_MarchSpan.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_MarchSpan.POOL_SUB),5)+")\n";
            ZPP_MarchSpan.POOL_ADD=ZPP_MarchSpan.POOL_SUB=ZPP_MarchSpan.POOL_ADDNEW=0;
        }
        {
            if(ZPP_MarchPair.POOL_TOT!=0||ZPP_MarchPair.POOL_CNT!=0||ZPP_MarchPair.POOL_ADD!=0||ZPP_MarchPair.POOL_SUB!=0)ret+=pad("ZPP_MarchPair",30)+" #"+pad(Std.string(ZPP_MarchPair.POOL_TOT-ZPP_MarchPair.POOL_CNT),5)+"/"+pad(Std.string(ZPP_MarchPair.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_MarchPair.POOL_ADD),5)+"("+pad(Std.string(ZPP_MarchPair.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_MarchPair.POOL_SUB),5)+")\n";
            ZPP_MarchPair.POOL_ADD=ZPP_MarchPair.POOL_SUB=ZPP_MarchPair.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Vec2.POOL_TOT!=0||ZNPNode_ZPP_Vec2.POOL_CNT!=0||ZNPNode_ZPP_Vec2.POOL_ADD!=0||ZNPNode_ZPP_Vec2.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Vec2",30)+" #"+pad(Std.string(ZNPNode_ZPP_Vec2.POOL_TOT-ZNPNode_ZPP_Vec2.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Vec2.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Vec2.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Vec2.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Vec2.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Vec2.POOL_ADD=ZNPNode_ZPP_Vec2.POOL_SUB=ZNPNode_ZPP_Vec2.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Edge.POOL_TOT!=0||ZPP_Edge.POOL_CNT!=0||ZPP_Edge.POOL_ADD!=0||ZPP_Edge.POOL_SUB!=0)ret+=pad("ZPP_Edge",30)+" #"+pad(Std.string(ZPP_Edge.POOL_TOT-ZPP_Edge.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Edge.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Edge.POOL_ADD),5)+"("+pad(Std.string(ZPP_Edge.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Edge.POOL_SUB),5)+")\n";
            ZPP_Edge.POOL_ADD=ZPP_Edge.POOL_SUB=ZPP_Edge.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_AABBPair.POOL_TOT!=0||ZNPNode_ZPP_AABBPair.POOL_CNT!=0||ZNPNode_ZPP_AABBPair.POOL_ADD!=0||ZNPNode_ZPP_AABBPair.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_AABBPair",30)+" #"+pad(Std.string(ZNPNode_ZPP_AABBPair.POOL_TOT-ZNPNode_ZPP_AABBPair.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_AABBPair.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_AABBPair.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_AABBPair.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_AABBPair.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_AABBPair.POOL_ADD=ZNPNode_ZPP_AABBPair.POOL_SUB=ZNPNode_ZPP_AABBPair.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Edge.POOL_TOT!=0||ZNPNode_ZPP_Edge.POOL_CNT!=0||ZNPNode_ZPP_Edge.POOL_ADD!=0||ZNPNode_ZPP_Edge.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Edge",30)+" #"+pad(Std.string(ZNPNode_ZPP_Edge.POOL_TOT-ZNPNode_ZPP_Edge.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Edge.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Edge.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Edge.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Edge.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Edge.POOL_ADD=ZNPNode_ZPP_Edge.POOL_SUB=ZNPNode_ZPP_Edge.POOL_ADDNEW=0;
        }
        {
            if(ZPP_SweepData.POOL_TOT!=0||ZPP_SweepData.POOL_CNT!=0||ZPP_SweepData.POOL_ADD!=0||ZPP_SweepData.POOL_SUB!=0)ret+=pad("ZPP_SweepData",30)+" #"+pad(Std.string(ZPP_SweepData.POOL_TOT-ZPP_SweepData.POOL_CNT),5)+"/"+pad(Std.string(ZPP_SweepData.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_SweepData.POOL_ADD),5)+"("+pad(Std.string(ZPP_SweepData.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_SweepData.POOL_SUB),5)+")\n";
            ZPP_SweepData.POOL_ADD=ZPP_SweepData.POOL_SUB=ZPP_SweepData.POOL_ADDNEW=0;
        }
        {
            if(ZPP_AABBNode.POOL_TOT!=0||ZPP_AABBNode.POOL_CNT!=0||ZPP_AABBNode.POOL_ADD!=0||ZPP_AABBNode.POOL_SUB!=0)ret+=pad("ZPP_AABBNode",30)+" #"+pad(Std.string(ZPP_AABBNode.POOL_TOT-ZPP_AABBNode.POOL_CNT),5)+"/"+pad(Std.string(ZPP_AABBNode.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_AABBNode.POOL_ADD),5)+"("+pad(Std.string(ZPP_AABBNode.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_AABBNode.POOL_SUB),5)+")\n";
            ZPP_AABBNode.POOL_ADD=ZPP_AABBNode.POOL_SUB=ZPP_AABBNode.POOL_ADDNEW=0;
        }
        {
            if(ZPP_AABBPair.POOL_TOT!=0||ZPP_AABBPair.POOL_CNT!=0||ZPP_AABBPair.POOL_ADD!=0||ZPP_AABBPair.POOL_SUB!=0)ret+=pad("ZPP_AABBPair",30)+" #"+pad(Std.string(ZPP_AABBPair.POOL_TOT-ZPP_AABBPair.POOL_CNT),5)+"/"+pad(Std.string(ZPP_AABBPair.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_AABBPair.POOL_ADD),5)+"("+pad(Std.string(ZPP_AABBPair.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_AABBPair.POOL_SUB),5)+")\n";
            ZPP_AABBPair.POOL_ADD=ZPP_AABBPair.POOL_SUB=ZPP_AABBPair.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_AABBNode.POOL_TOT!=0||ZNPNode_ZPP_AABBNode.POOL_CNT!=0||ZNPNode_ZPP_AABBNode.POOL_ADD!=0||ZNPNode_ZPP_AABBNode.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_AABBNode",30)+" #"+pad(Std.string(ZNPNode_ZPP_AABBNode.POOL_TOT-ZNPNode_ZPP_AABBNode.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_AABBNode.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_AABBNode.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_AABBNode.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_AABBNode.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_AABBNode.POOL_ADD=ZNPNode_ZPP_AABBNode.POOL_SUB=ZNPNode_ZPP_AABBNode.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Contact.POOL_TOT!=0||ZPP_Contact.POOL_CNT!=0||ZPP_Contact.POOL_ADD!=0||ZPP_Contact.POOL_SUB!=0)ret+=pad("ZPP_Contact",30)+" #"+pad(Std.string(ZPP_Contact.POOL_TOT-ZPP_Contact.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Contact.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Contact.POOL_ADD),5)+"("+pad(Std.string(ZPP_Contact.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Contact.POOL_SUB),5)+")\n";
            ZPP_Contact.POOL_ADD=ZPP_Contact.POOL_SUB=ZPP_Contact.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Component.POOL_TOT!=0||ZNPNode_ZPP_Component.POOL_CNT!=0||ZNPNode_ZPP_Component.POOL_ADD!=0||ZNPNode_ZPP_Component.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Component",30)+" #"+pad(Std.string(ZNPNode_ZPP_Component.POOL_TOT-ZNPNode_ZPP_Component.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Component.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Component.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Component.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Component.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Component.POOL_ADD=ZNPNode_ZPP_Component.POOL_SUB=ZNPNode_ZPP_Component.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Island.POOL_TOT!=0||ZPP_Island.POOL_CNT!=0||ZPP_Island.POOL_ADD!=0||ZPP_Island.POOL_SUB!=0)ret+=pad("ZPP_Island",30)+" #"+pad(Std.string(ZPP_Island.POOL_TOT-ZPP_Island.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Island.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Island.POOL_ADD),5)+"("+pad(Std.string(ZPP_Island.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Island.POOL_SUB),5)+")\n";
            ZPP_Island.POOL_ADD=ZPP_Island.POOL_SUB=ZPP_Island.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Component.POOL_TOT!=0||ZPP_Component.POOL_CNT!=0||ZPP_Component.POOL_ADD!=0||ZPP_Component.POOL_SUB!=0)ret+=pad("ZPP_Component",30)+" #"+pad(Std.string(ZPP_Component.POOL_TOT-ZPP_Component.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Component.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Component.POOL_ADD),5)+"("+pad(Std.string(ZPP_Component.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Component.POOL_SUB),5)+")\n";
            ZPP_Component.POOL_ADD=ZPP_Component.POOL_SUB=ZPP_Component.POOL_ADDNEW=0;
        }
        {
            if(ZPP_CallbackSet.POOL_TOT!=0||ZPP_CallbackSet.POOL_CNT!=0||ZPP_CallbackSet.POOL_ADD!=0||ZPP_CallbackSet.POOL_SUB!=0)ret+=pad("ZPP_CallbackSet",30)+" #"+pad(Std.string(ZPP_CallbackSet.POOL_TOT-ZPP_CallbackSet.POOL_CNT),5)+"/"+pad(Std.string(ZPP_CallbackSet.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_CallbackSet.POOL_ADD),5)+"("+pad(Std.string(ZPP_CallbackSet.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_CallbackSet.POOL_SUB),5)+")\n";
            ZPP_CallbackSet.POOL_ADD=ZPP_CallbackSet.POOL_SUB=ZPP_CallbackSet.POOL_ADDNEW=0;
        }
        {
            if(ZPP_SensorArbiter.POOL_TOT!=0||ZPP_SensorArbiter.POOL_CNT!=0||ZPP_SensorArbiter.POOL_ADD!=0||ZPP_SensorArbiter.POOL_SUB!=0)ret+=pad("ZPP_SensorArbiter",30)+" #"+pad(Std.string(ZPP_SensorArbiter.POOL_TOT-ZPP_SensorArbiter.POOL_CNT),5)+"/"+pad(Std.string(ZPP_SensorArbiter.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_SensorArbiter.POOL_ADD),5)+"("+pad(Std.string(ZPP_SensorArbiter.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_SensorArbiter.POOL_SUB),5)+")\n";
            ZPP_SensorArbiter.POOL_ADD=ZPP_SensorArbiter.POOL_SUB=ZPP_SensorArbiter.POOL_ADDNEW=0;
        }
        {
            if(ZPP_FluidArbiter.POOL_TOT!=0||ZPP_FluidArbiter.POOL_CNT!=0||ZPP_FluidArbiter.POOL_ADD!=0||ZPP_FluidArbiter.POOL_SUB!=0)ret+=pad("ZPP_FluidArbiter",30)+" #"+pad(Std.string(ZPP_FluidArbiter.POOL_TOT-ZPP_FluidArbiter.POOL_CNT),5)+"/"+pad(Std.string(ZPP_FluidArbiter.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_FluidArbiter.POOL_ADD),5)+"("+pad(Std.string(ZPP_FluidArbiter.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_FluidArbiter.POOL_SUB),5)+")\n";
            ZPP_FluidArbiter.POOL_ADD=ZPP_FluidArbiter.POOL_SUB=ZPP_FluidArbiter.POOL_ADDNEW=0;
        }
        {
            if(ZPP_Set_ZPP_CbSet.POOL_TOT!=0||ZPP_Set_ZPP_CbSet.POOL_CNT!=0||ZPP_Set_ZPP_CbSet.POOL_ADD!=0||ZPP_Set_ZPP_CbSet.POOL_SUB!=0)ret+=pad("ZPP_Set_ZPP_CbSet",30)+" #"+pad(Std.string(ZPP_Set_ZPP_CbSet.POOL_TOT-ZPP_Set_ZPP_CbSet.POOL_CNT),5)+"/"+pad(Std.string(ZPP_Set_ZPP_CbSet.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_Set_ZPP_CbSet.POOL_ADD),5)+"("+pad(Std.string(ZPP_Set_ZPP_CbSet.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_Set_ZPP_CbSet.POOL_SUB),5)+")\n";
            ZPP_Set_ZPP_CbSet.POOL_ADD=ZPP_Set_ZPP_CbSet.POOL_SUB=ZPP_Set_ZPP_CbSet.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_FluidArbiter.POOL_TOT!=0||ZNPNode_ZPP_FluidArbiter.POOL_CNT!=0||ZNPNode_ZPP_FluidArbiter.POOL_ADD!=0||ZNPNode_ZPP_FluidArbiter.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_FluidArbiter",30)+" #"+pad(Std.string(ZNPNode_ZPP_FluidArbiter.POOL_TOT-ZNPNode_ZPP_FluidArbiter.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_FluidArbiter.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_FluidArbiter.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_FluidArbiter.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_FluidArbiter.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_FluidArbiter.POOL_ADD=ZNPNode_ZPP_FluidArbiter.POOL_SUB=ZNPNode_ZPP_FluidArbiter.POOL_ADDNEW=0;
        }
        {
            if(ZPP_ColArbiter.POOL_TOT!=0||ZPP_ColArbiter.POOL_CNT!=0||ZPP_ColArbiter.POOL_ADD!=0||ZPP_ColArbiter.POOL_SUB!=0)ret+=pad("ZPP_ColArbiter",30)+" #"+pad(Std.string(ZPP_ColArbiter.POOL_TOT-ZPP_ColArbiter.POOL_CNT),5)+"/"+pad(Std.string(ZPP_ColArbiter.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_ColArbiter.POOL_ADD),5)+"("+pad(Std.string(ZPP_ColArbiter.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_ColArbiter.POOL_SUB),5)+")\n";
            ZPP_ColArbiter.POOL_ADD=ZPP_ColArbiter.POOL_SUB=ZPP_ColArbiter.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_SensorArbiter.POOL_TOT!=0||ZNPNode_ZPP_SensorArbiter.POOL_CNT!=0||ZNPNode_ZPP_SensorArbiter.POOL_ADD!=0||ZNPNode_ZPP_SensorArbiter.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_SensorArbiter",30)+" #"+pad(Std.string(ZNPNode_ZPP_SensorArbiter.POOL_TOT-ZNPNode_ZPP_SensorArbiter.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_SensorArbiter.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_SensorArbiter.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_SensorArbiter.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_SensorArbiter.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_SensorArbiter.POOL_ADD=ZNPNode_ZPP_SensorArbiter.POOL_SUB=ZNPNode_ZPP_SensorArbiter.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_Listener.POOL_TOT!=0||ZNPNode_ZPP_Listener.POOL_CNT!=0||ZNPNode_ZPP_Listener.POOL_ADD!=0||ZNPNode_ZPP_Listener.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_Listener",30)+" #"+pad(Std.string(ZNPNode_ZPP_Listener.POOL_TOT-ZNPNode_ZPP_Listener.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_Listener.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_Listener.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_Listener.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_Listener.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_Listener.POOL_ADD=ZNPNode_ZPP_Listener.POOL_SUB=ZNPNode_ZPP_Listener.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_ColArbiter.POOL_TOT!=0||ZNPNode_ZPP_ColArbiter.POOL_CNT!=0||ZNPNode_ZPP_ColArbiter.POOL_ADD!=0||ZNPNode_ZPP_ColArbiter.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_ColArbiter",30)+" #"+pad(Std.string(ZNPNode_ZPP_ColArbiter.POOL_TOT-ZNPNode_ZPP_ColArbiter.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_ColArbiter.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_ColArbiter.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_ColArbiter.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_ColArbiter.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_ColArbiter.POOL_ADD=ZNPNode_ZPP_ColArbiter.POOL_SUB=ZNPNode_ZPP_ColArbiter.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_InteractionGroup.POOL_TOT!=0||ZNPNode_ZPP_InteractionGroup.POOL_CNT!=0||ZNPNode_ZPP_InteractionGroup.POOL_ADD!=0||ZNPNode_ZPP_InteractionGroup.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_InteractionGroup",30)+" #"+pad(Std.string(ZNPNode_ZPP_InteractionGroup.POOL_TOT-ZNPNode_ZPP_InteractionGroup.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_InteractionGroup.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_InteractionGroup.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_InteractionGroup.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_InteractionGroup.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_InteractionGroup.POOL_ADD=ZNPNode_ZPP_InteractionGroup.POOL_SUB=ZNPNode_ZPP_InteractionGroup.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_ToiEvent.POOL_TOT!=0||ZNPNode_ZPP_ToiEvent.POOL_CNT!=0||ZNPNode_ZPP_ToiEvent.POOL_ADD!=0||ZNPNode_ZPP_ToiEvent.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_ToiEvent",30)+" #"+pad(Std.string(ZNPNode_ZPP_ToiEvent.POOL_TOT-ZNPNode_ZPP_ToiEvent.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_ToiEvent.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_ToiEvent.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_ToiEvent.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_ToiEvent.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_ToiEvent.POOL_ADD=ZNPNode_ZPP_ToiEvent.POOL_SUB=ZNPNode_ZPP_ToiEvent.POOL_ADDNEW=0;
        }
        {
            if(ZPP_InteractionFilter.POOL_TOT!=0||ZPP_InteractionFilter.POOL_CNT!=0||ZPP_InteractionFilter.POOL_ADD!=0||ZPP_InteractionFilter.POOL_SUB!=0)ret+=pad("ZPP_InteractionFilter",30)+" #"+pad(Std.string(ZPP_InteractionFilter.POOL_TOT-ZPP_InteractionFilter.POOL_CNT),5)+"/"+pad(Std.string(ZPP_InteractionFilter.POOL_CNT),5)+" (+"+pad(Std.string(ZPP_InteractionFilter.POOL_ADD),5)+"("+pad(Std.string(ZPP_InteractionFilter.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZPP_InteractionFilter.POOL_SUB),5)+")\n";
            ZPP_InteractionFilter.POOL_ADD=ZPP_InteractionFilter.POOL_SUB=ZPP_InteractionFilter.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ConvexResult.POOL_TOT!=0||ZNPNode_ConvexResult.POOL_CNT!=0||ZNPNode_ConvexResult.POOL_ADD!=0||ZNPNode_ConvexResult.POOL_SUB!=0)ret+=pad("ZNPNode_ConvexResult",30)+" #"+pad(Std.string(ZNPNode_ConvexResult.POOL_TOT-ZNPNode_ConvexResult.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ConvexResult.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ConvexResult.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ConvexResult.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ConvexResult.POOL_SUB),5)+")\n";
            ZNPNode_ConvexResult.POOL_ADD=ZNPNode_ConvexResult.POOL_SUB=ZNPNode_ConvexResult.POOL_ADDNEW=0;
        }
        {
            if(GeomPoly.POOL_TOT!=0||GeomPoly.POOL_CNT!=0||GeomPoly.POOL_ADD!=0||GeomPoly.POOL_SUB!=0)ret+=pad("GeomPoly",30)+" #"+pad(Std.string(GeomPoly.POOL_TOT-GeomPoly.POOL_CNT),5)+"/"+pad(Std.string(GeomPoly.POOL_CNT),5)+" (+"+pad(Std.string(GeomPoly.POOL_ADD),5)+"("+pad(Std.string(GeomPoly.POOL_ADDNEW),5)+")/-"+pad(Std.string(GeomPoly.POOL_SUB),5)+")\n";
            GeomPoly.POOL_ADD=GeomPoly.POOL_SUB=GeomPoly.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_ZPP_GeomPoly.POOL_TOT!=0||ZNPNode_ZPP_GeomPoly.POOL_CNT!=0||ZNPNode_ZPP_GeomPoly.POOL_ADD!=0||ZNPNode_ZPP_GeomPoly.POOL_SUB!=0)ret+=pad("ZNPNode_ZPP_GeomPoly",30)+" #"+pad(Std.string(ZNPNode_ZPP_GeomPoly.POOL_TOT-ZNPNode_ZPP_GeomPoly.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_ZPP_GeomPoly.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_ZPP_GeomPoly.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_ZPP_GeomPoly.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_ZPP_GeomPoly.POOL_SUB),5)+")\n";
            ZNPNode_ZPP_GeomPoly.POOL_ADD=ZNPNode_ZPP_GeomPoly.POOL_SUB=ZNPNode_ZPP_GeomPoly.POOL_ADDNEW=0;
        }
        {
            if(ZNPNode_RayResult.POOL_TOT!=0||ZNPNode_RayResult.POOL_CNT!=0||ZNPNode_RayResult.POOL_ADD!=0||ZNPNode_RayResult.POOL_SUB!=0)ret+=pad("ZNPNode_RayResult",30)+" #"+pad(Std.string(ZNPNode_RayResult.POOL_TOT-ZNPNode_RayResult.POOL_CNT),5)+"/"+pad(Std.string(ZNPNode_RayResult.POOL_CNT),5)+" (+"+pad(Std.string(ZNPNode_RayResult.POOL_ADD),5)+"("+pad(Std.string(ZNPNode_RayResult.POOL_ADDNEW),5)+")/-"+pad(Std.string(ZNPNode_RayResult.POOL_SUB),5)+")\n";
            ZNPNode_RayResult.POOL_ADD=ZNPNode_RayResult.POOL_SUB=ZNPNode_RayResult.POOL_ADDNEW=0;
        }
        {
            if(Vec2.POOL_TOT!=0||Vec2.POOL_CNT!=0||Vec2.POOL_ADD!=0||Vec2.POOL_SUB!=0)ret+=pad("Vec2",30)+" #"+pad(Std.string(Vec2.POOL_TOT-Vec2.POOL_CNT),5)+"/"+pad(Std.string(Vec2.POOL_CNT),5)+" (+"+pad(Std.string(Vec2.POOL_ADD),5)+"("+pad(Std.string(Vec2.POOL_ADDNEW),5)+")/-"+pad(Std.string(Vec2.POOL_SUB),5)+")\n";
            Vec2.POOL_ADD=Vec2.POOL_SUB=Vec2.POOL_ADDNEW=0;
        }
        {
            if(Vec3.POOL_TOT!=0||Vec3.POOL_CNT!=0||Vec3.POOL_ADD!=0||Vec3.POOL_SUB!=0)ret+=pad("Vec3",30)+" #"+pad(Std.string(Vec3.POOL_TOT-Vec3.POOL_CNT),5)+"/"+pad(Std.string(Vec3.POOL_CNT),5)+" (+"+pad(Std.string(Vec3.POOL_ADD),5)+"("+pad(Std.string(Vec3.POOL_ADDNEW),5)+")/-"+pad(Std.string(Vec3.POOL_SUB),5)+")\n";
            Vec3.POOL_ADD=Vec3.POOL_SUB=Vec3.POOL_ADDNEW=0;
        }
        return ret;
    }
}
#end
