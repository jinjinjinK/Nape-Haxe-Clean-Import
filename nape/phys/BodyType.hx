package nape.phys;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of rigid body types.
 */
@:final#if nape_swc@:keep #end
class BodyType{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"BodyType"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==STATIC)return"STATIC";
        else if(this==DYNAMIC)return"DYNAMIC";
        else if(this==KINEMATIC)return"KINEMATIC";
        else return "";
    }
    /**
     * Static objects are not permitted to move, and due to this several
     * optimisatinos can be made for them.
     */
    #if nape_swc@:isVar #end
    public static var STATIC(get_STATIC,never):BodyType;
    inline static function get_STATIC(){
        if(ZPP_Flags.BodyType_STATIC==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.BodyType_STATIC=new BodyType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.BodyType_STATIC;
    }
    /**
     * Standard dynamic object, this object will be effected by the physics
     * as usual.
     */
    #if nape_swc@:isVar #end
    public static var DYNAMIC(get_DYNAMIC,never):BodyType;
    inline static function get_DYNAMIC(){
        if(ZPP_Flags.BodyType_DYNAMIC==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.BodyType_DYNAMIC=new BodyType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.BodyType_DYNAMIC;
    }
    /**
     * Kinematic objects are static objects which 'are' permitted to move,
     * you have complete control over their velocity to make them move how
     * you wish and are not effected by any physics.
     */
    #if nape_swc@:isVar #end
    public static var KINEMATIC(get_KINEMATIC,never):BodyType;
    inline static function get_KINEMATIC(){
        if(ZPP_Flags.BodyType_KINEMATIC==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.BodyType_KINEMATIC=new BodyType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.BodyType_KINEMATIC;
    }
}
