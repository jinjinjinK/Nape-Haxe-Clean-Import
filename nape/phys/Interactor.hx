package nape.phys;
import nape.callbacks.CbTypeList;
import nape.dynamics.InteractionGroup;
import nape.phys.Body;
import nape.phys.Compound;
import nape.shape.Shape;
import zpp_nape.dynamics.InteractionGroup;
import zpp_nape.phys.Body;
import zpp_nape.phys.Compound;
import zpp_nape.phys.Interactor;
import zpp_nape.shape.Shape;
#if nape_swc@:keep #end
class Interactor{
    /**
     * @private
     */
    public var zpp_inner_i:ZPP_Interactor=null;
    /**
     * Unique id of this Interactor.
     */
    #if nape_swc@:isVar #end
    public var id(get_id,never):Int;
    inline function get_id():Int{
        return zpp_inner_i.id;
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
        if(zpp_inner_i.userData==null){
            zpp_inner_i.userData=cast{};
        }
        return zpp_inner_i.userData;
    }
    /**
     * Fast equivalent to <code>Std.is(interactor, Shape)</code>
     * @return true if this Interactor is a Shape.
     */
    public#if NAPE_NO_INLINE#else inline #end
    function isShape(){
        return zpp_inner_i.ishape!=null;
    }
    /**
     * Fast equivalent to <code>Std.is(interactor, Body)</code>
     * @return true if this Interactor is a Body.
     */
    public#if NAPE_NO_INLINE#else inline #end
    function isBody(){
        return zpp_inner_i.ibody!=null;
    }
    /**
     * Fast equivalent to <code>Std.is(interactor, Compound)</code>
     * @return true if this Interactor is a Compound.
     */
    public#if NAPE_NO_INLINE#else inline #end
    function isCompound(){
        return zpp_inner_i.icompound!=null;
    }
    /**
     * Fast equivalent to <code>cast(interactor, Shape)</code>
     */
    #if nape_swc@:isVar #end
    public var castShape(get_castShape,never):Null<Shape>;
    inline function get_castShape():Null<Shape>{
        return if(isShape())zpp_inner_i.ishape.outer else null;
    }
    /**
     * Fast equivalent to <code>cast(interactor, Body)</code>
     */
    #if nape_swc@:isVar #end
    public var castBody(get_castBody,never):Null<Body>;
    inline function get_castBody():Null<Body>{
        return if(isBody())zpp_inner_i.ibody.outer else null;
    }
    /**
     * Fast equivalent to <code>cast(interactor, Compound)</code>
     */
    #if nape_swc@:isVar #end
    public var castCompound(get_castCompound,never):Null<Compound>;
    inline function get_castCompound():Null<Compound>{
        return if(isCompound())zpp_inner_i.icompound.outer else null;
    }
    /**
     * InteractionGroup assigned to this Interactor.
     *
     * @default null
     */
    #if nape_swc@:isVar #end
    public var group(get_group,set_group):Null<InteractionGroup>;
    inline function get_group():Null<InteractionGroup>{
        return if(zpp_inner_i.group==null)null else zpp_inner_i.group.outer;
    }
    inline function set_group(group:Null<InteractionGroup>):Null<InteractionGroup>{
        {
            zpp_inner_i.immutable_midstep("Interactor::group");
            zpp_inner_i.setGroup(group==null?null:group.zpp_inner);
        }
        return get_group();
    }
    /**
     * Set of CbType's assigned to this Interactor.
     *
     * @default []
     */
    #if nape_swc@:isVar #end
    public var cbTypes(get_cbTypes,never):CbTypeList;
    inline function get_cbTypes():CbTypeList{
        if(zpp_inner_i.wrap_cbTypes==null)zpp_inner_i.setupcbTypes();
        return zpp_inner_i.wrap_cbTypes;
    }
    /**
     * @private
     */
    #if(!NAPE_RELEASE_BUILD)
    public static var zpp_internalAlloc=false;
    #end
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!zpp_internalAlloc)throw "Error: Cannot instantiate an Interactor, only Shape/Body/Compound";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        return "";
    }
}
