package nape.callbacks;
import nape.callbacks.CbTypeList;
import zpp_nape.callbacks.OptionType;
/**
 * OptionType representing matching behaviour for Listeners.
 * <br/><br/>
 * An object's set of CbType's 'matches' against an OptionType iff.
 * the OptionType's includes list intersects the object's set of CbTypes
 * and the OptionType's excludes list 'does not' intersect the object's set
 * of CbTypes.
 * <pre>
 * option = new OptionType([A, B], [C, D]);
 * obj.cbTypes = [] // => does not match option.
 * obj.cbTypes = [A] // => matches the option
 * obj.cbTypes = [A, C] // => does not match option.
 * </pre>
 * The optionType's includes and excludes list are managed to be always
 * disjoint: The action of including an already excluded type serves to
 * remove it from the excludes list, equalliy excluding an already included
 * type serves to remove it from the includes list.
 * <pre>
 * var option = new OptionType();
 * option.including(A); // option = {[A]:[]}
 * option.excluding(A); // option = {[]:[]}
 * option.excluding(A); // option = {[]:[A]}
 * option.including(A); // option = {[A]:[]}
 * </pre>
 */
@:final#if nape_swc@:keep #end
class OptionType{
    /**
     * @private
     */
    public var zpp_inner:ZPP_OptionType=null;
    /**
     * List of included CbTypes.
     * <br/><br/>
     * This list is both readonly, and immutable. To remove an element
     * from this list you can use: <code>option.excluding(cbType)</code>
     *
     * @default []
     */
    #if nape_swc@:isVar #end
    public var includes(get_includes,never):CbTypeList;
    inline function get_includes():CbTypeList{
        if(zpp_inner.wrap_includes==null)zpp_inner.setup_includes();
        return zpp_inner.wrap_includes;
    }
    /**
     * List of excluded CbTypes.
     * <br/><br/>
     * This list is both readonly, and immutable. To remove an element
     * from this list you can use: <code>option.including(cbType)</code>
     *
     * @default []
     */
    #if nape_swc@:isVar #end
    public var excludes(get_excludes,never):CbTypeList;
    inline function get_excludes():CbTypeList{
        if(zpp_inner.wrap_excludes==null)zpp_inner.setup_excludes();
        return zpp_inner.wrap_excludes;
    }
    /**
     * Construct a new OptionType.
     * <br/><br/>
     * The type of the arguments is Dynamic, and is permitted to be one of:
     * <code>CbType, CbTypeList, Array&lt;CbType&gt; flash.Vector&lt;CbType&gt;</code>
     *
     * @param includes The set of CbTypes to be included in the matching process.
     *                 (default null)
     * @param excludes The set of CbTypes to be excluded in the matching process.
     *                 (default null)
     * @return Return new OptionType with give sets of CbTypes.
     * @throws # If either argument is not of the expected Type.
     */
    #if flib@:keep function flibopts_2(){}
    #end
    public function new(includes:Dynamic=null,excludes:Dynamic=null){
        zpp_inner=new ZPP_OptionType();
        zpp_inner.outer=this;
        if(includes!=null)including(includes);
        if(excludes!=null)excluding(excludes);
    }
    /**
     * Append set of types to includes list.
     * <br/><br/>
     * This method was originally named the more appropriate 'include'
     * but this conflicted with the AS3 keyword include and had to be
     * change.
     * <br/><br/>
     * The argument is typed Dynamic, and is permitted to be one of:
     * <code>CbType, CbTypeList, Array&lt;CbType&gt; flash.Vector&lt;CbType&gt;</code>
     *
     * @param includes The set of CbTypes to be included. (default null)
     * @return A reference to this OptionType.
     * @throws # If argument is not of the expected Type.
     */
    public function including(includes:Dynamic=null):OptionType{
        zpp_inner.append(zpp_inner.includes,includes);
        return this;
    }
    /**
     * Append set of types to excludes list.
     * <br/><br/>
     * This method was originally named the more appropriate 'exclude'
     * but to match the necessary change for the include function, this was
     * renamed as excluding.
     * <br/><br/>
     * The argument is typed Dynamic, and is permitted to be one of:
     * <code>CbType, CbTypeList, Array&lt;CbType&gt; flash.Vector&lt;CbType&gt;</code>
     *
     * @param excludes The set of CbTypes to be excluded. (default null)
     * @return A reference to this OptionType.
     * @throws # If argument is not of the expected Type.
     */
    public function excluding(excludes:Dynamic=null):OptionType{
        zpp_inner.append(zpp_inner.excludes,excludes);
        return this;
    }
    /**
     * @private
     */
    @:keep public function toString():String{
        var inc=includes.toString();
        var exc=excludes.toString();
        return "@{"+inc+" excluding "+exc+"}";
    }
}
