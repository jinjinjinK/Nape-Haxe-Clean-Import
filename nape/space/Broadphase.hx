package nape.space;
import zpp_nape.space.Broadphase;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of available broadphase collision types that Spaces may use.
 */
@:final#if nape_swc@:keep #end
class Broadphase{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"Broadphase"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==DYNAMIC_AABB_TREE)return"DYNAMIC_AABB_TREE";
        else if(this==SWEEP_AND_PRUNE)return"SWEEP_AND_PRUNE";
        else return "";
    }
    /**
     * Dynamic AABB Tree broadphase.
     * <br/><br/>
     * This broadphase uses a pair of binary trees with objects inserted based
     * on containment of their AABB.
     * <br/><br/>
     * This is a general purpose broadphase which does not suffer for objects
     * of varying sizes, or objects moving very quickly and is well set for such
     * acts as ray casting and spatial queries like objectsInAABB of the Space type.
     * <br/><br/>
     * This is the default broadphase nape will use.
     */
    #if nape_swc@:isVar #end
    public static var DYNAMIC_AABB_TREE(get_DYNAMIC_AABB_TREE,never):Broadphase;
    inline static function get_DYNAMIC_AABB_TREE(){
        if(ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE=new Broadphase();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE;
    }
    /**
     * Sweep and prune broadphase.
     * <br/><br/>
     * This is a very simple broadphase using the x-axis to keep objects
     * sorted by their minimum x coordinate.
     * <br/><br/>
     * Performance of this broadphase is generally good and in some circumstances
     * superior to the DYNAMIC_AABB_TREE broadphase.
     * <br/><br/>
     * This broadphase will however be much slower for things such as ray casts and
     * spatial queries like objectsInAABB on the Space type.
     * Also in cases where lots of objects are moving very quickly or when there is a
     * large variety in the size of objects.
     * <br/><br/>
     * Due to the simplicity of this broadphase, it serves as a good test should you
     * ever feel there might be something going wrong with the DYNAMIC_AABB_TREE
     * broadphase type.
     */
    #if nape_swc@:isVar #end
    public static var SWEEP_AND_PRUNE(get_SWEEP_AND_PRUNE,never):Broadphase;
    inline static function get_SWEEP_AND_PRUNE(){
        if(ZPP_Flags.Broadphase_SWEEP_AND_PRUNE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.Broadphase_SWEEP_AND_PRUNE=new Broadphase();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.Broadphase_SWEEP_AND_PRUNE;
    }
}
