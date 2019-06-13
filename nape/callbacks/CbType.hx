package nape.callbacks;
import nape.callbacks.OptionType;
import nape.constraint.ConstraintList;
import nape.phys.InteractorList;
import zpp_nape.callbacks.CbType;
import zpp_nape.callbacks.OptionType;
import zpp_nape.util.Lists.ZPP_ConstraintList;
import zpp_nape.util.Lists.ZPP_InteractorList;
/**
 * Callback Type applied to Interactors and Constraints.
 * <br/><br/>
 * Callback types are ranged over by listeners.
 */
@:final#if nape_swc@:keep #end
class CbType{
    /**
     * @private
     */
    public var zpp_inner:ZPP_CbType=null;
    /**
     * Unique identifier for this CbType.
     */
    #if nape_swc@:isVar #end
    public var id(get_id,never):Int;
    inline function get_id():Int{
        return zpp_inner.id;
    }
    /**
     * Construct a new CbType object.
     *
     * @return A new CbType.
     */
    public function new(){
        zpp_inner=new ZPP_CbType();
        zpp_inner.outer=this;
    }
    
    /**
     * Default CbType given to all Bodys
     *
     * Due to the way the Callback system in Nape works, you can use this
     * CbType to match against 'all'
     * Bodys
     * In a Listener (Assuming you do not 'remove' this type from the object)
     */
    #if nape_swc@:isVar #end
    public static var ANY_BODY(get_ANY_BODY,never):CbType;
    inline static function get_ANY_BODY():CbType{
        return ZPP_CbType.ANY_BODY;
    }
    /**
     * Default CbType given to all Constraints
     *
     * Due to the way the Callback system in Nape works, you can use this
     * CbType to match against 'all'
     * Constraints
     * In a Listener (Assuming you do not 'remove' this type from the object)
     */
    #if nape_swc@:isVar #end
    public static var ANY_CONSTRAINT(get_ANY_CONSTRAINT,never):CbType;
    inline static function get_ANY_CONSTRAINT():CbType{
        return ZPP_CbType.ANY_CONSTRAINT;
    }
    /**
     * Default CbType given to all Shapes
     *
     * Due to the way the Callback system in Nape works, you can use this
     * CbType to match against 'all'
     * Shapes
     * In a Listener (Assuming you do not 'remove' this type from the object)
     */
    #if nape_swc@:isVar #end
    public static var ANY_SHAPE(get_ANY_SHAPE,never):CbType;
    inline static function get_ANY_SHAPE():CbType{
        return ZPP_CbType.ANY_SHAPE;
    }
    /**
     * Default CbType given to all Compounds
     *
     * Due to the way the Callback system in Nape works, you can use this
     * CbType to match against 'all'
     * Compounds
     * In a Listener (Assuming you do not 'remove' this type from the object)
     */
    #if nape_swc@:isVar #end
    public static var ANY_COMPOUND(get_ANY_COMPOUND,never):CbType;
    inline static function get_ANY_COMPOUND():CbType{
        return ZPP_CbType.ANY_COMPOUND;
    }
    /**
     * Construct OptionType with given extra includes.
     * <br/><br/>
     * Equivalent to <code>new OptionType(this).including(includes)</code>
     * <br/><br/>
     * The includes argument is typed Dynamic, and is permitted to be one of:
     * <code>CbType, CbTypeList, Array&lt;CbType&gt;, flash.Vector&lt;CbType&gt;</code>
     *
     * @param includes The CbTypes to include.
     * @return A new OptionType whose includes are equal to this CbType
     *         and all the CbTypes given as argument.
     * @throws # If includes is null.
     */
    public function including(includes:Dynamic):OptionType{
        return(new OptionType(this)).including(includes);
    }
    /**
     * Construct OptionType with given excludes.
     * <br/><br/>
     * Equivalent to <code>new OptionType(this).excluding(excludes)</code>
     * <br/><br/>
     * The excludes argument is typed Dynamic, and is permitted to be one of:
     * <code>CbType, CbTypeList, Array&lt;CbType&gt;, flash.Vector&lt;CbType&gt;</code>
     *
     * @param excludes The CbTypes to exclude.
     * @return A new OptionType whose included types are just 'this' and whose
     *         excluded types are those given as argument.
     * @throws # If excludes is null.
     */
    public function excluding(excludes:Dynamic):OptionType{
        return(new OptionType(this)).excluding(excludes);
    }
    /**
     * Dynamic object for user to store additional data.
     * <br/><br/>
     * This object cannot be set, only its dynamically created
     * properties may be set. In AS3 the type of this property is &#42
     * <br/><br/>
     * This object will be lazily constructed so that until accessed
     * for the first time, will be null internally.
     *
     * @default {}
     */
    #if nape_swc@:isVar #end
    public var userData(get_userData,never):Dynamic<Dynamic>;
    inline function get_userData():Dynamic<Dynamic>{
        if(zpp_inner.userData==null){
            zpp_inner.userData=cast{};
        }
        return zpp_inner.userData;
    }
    /**
     * List of all Interactors using this CbType.
     * <br/><br/>
     * This list contains only those Interactors that are inside of a Space
     * <br/><br/>
     * This list is not only readonly, but also immutable.
     */
    #if nape_swc@:isVar #end
    public var interactors(get_interactors,never):InteractorList;
    inline function get_interactors():InteractorList{
        if(zpp_inner.wrap_interactors==null){
            zpp_inner.wrap_interactors=ZPP_InteractorList.get(zpp_inner.interactors,true);
        }
        return zpp_inner.wrap_interactors;
    }
    /**
     * List of all Constraints using this CbType.
     * <br/><br/>
     * This list contains only those Constraints that are inside of a Space
     * <br/><br/>
     * This list is not only readonly, but also immutable.
     */
    #if nape_swc@:isVar #end
    public var constraints(get_constraints,never):ConstraintList;
    inline function get_constraints():ConstraintList{
        if(zpp_inner.wrap_constraints==null){
            zpp_inner.wrap_constraints=ZPP_ConstraintList.get(zpp_inner.constraints,true);
        }
        return zpp_inner.wrap_constraints;
    }
    /**
     * @private
     */
    @:keep public function toString():String{
        return if(this==ANY_BODY)"ANY_BODY";
        else if(this==ANY_SHAPE)"ANY_SHAPE";
        else if(this==ANY_COMPOUND)"ANY_COMPOUND";
        else if(this==ANY_CONSTRAINT)"ANY_CONSTRAINT";
        else "CbType#"+id;
    }
}
