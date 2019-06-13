package nape.shape;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of validation results for a Polygon.
 */
@:final#if nape_swc@:keep #end
class ValidationResult{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"ValidationResult"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==VALID)return"VALID";
        else if(this==DEGENERATE)return"DEGENERATE";
        else if(this==CONCAVE)return"CONCAVE";
        else if(this==SELF_INTERSECTING)return"SELF_INTERSECTING";
        else return "";
    }
    /**
     * Denotes polygon is valid for simulation in Nape.
     */
    #if nape_swc@:isVar #end
    public static var VALID(get_VALID,never):ValidationResult;
    inline static function get_VALID(){
        if(ZPP_Flags.ValidationResult_VALID==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ValidationResult_VALID=new ValidationResult();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ValidationResult_VALID;
    }
    /**
     * Denotes polygon is degenerate (has zero area).
     */
    #if nape_swc@:isVar #end
    public static var DEGENERATE(get_DEGENERATE,never):ValidationResult;
    inline static function get_DEGENERATE(){
        if(ZPP_Flags.ValidationResult_DEGENERATE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ValidationResult_DEGENERATE=new ValidationResult();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ValidationResult_DEGENERATE;
    }
    /**
     * Denotes polygon is concave.
     */
    #if nape_swc@:isVar #end
    public static var CONCAVE(get_CONCAVE,never):ValidationResult;
    inline static function get_CONCAVE(){
        if(ZPP_Flags.ValidationResult_CONCAVE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ValidationResult_CONCAVE=new ValidationResult();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ValidationResult_CONCAVE;
    }
    /**
     * Denotes polygon is self-intersecting.
     */
    #if nape_swc@:isVar #end
    public static var SELF_INTERSECTING(get_SELF_INTERSECTING,never):ValidationResult;
    inline static function get_SELF_INTERSECTING(){
        if(ZPP_Flags.ValidationResult_SELF_INTERSECTING==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ValidationResult_SELF_INTERSECTING=new ValidationResult();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ValidationResult_SELF_INTERSECTING;
    }
}
