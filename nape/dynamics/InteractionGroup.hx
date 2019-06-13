package nape.dynamics;
import nape.dynamics.InteractionGroupList;
import nape.phys.InteractorList;
import zpp_nape.dynamics.InteractionGroup;
import zpp_nape.util.Lists.ZPP_InteractionGroupList;
import zpp_nape.util.Lists.ZPP_InteractorList;
/**
 * InteractionGroups are another way of filtering interactions.
 * <br/><br/>
 * InteractionGroups form tree structures which are checked along side InteractionFilters
 * when deciding if two Shapes should interact.
 * <br/><br/>
 * InteractionGroups are assigned to any Interactor (not just Shapes), and two Shapes will
 * interact only if the most recent common ancestor in the InteractionGroup tree permits it.
 * <br/><br/>
 * For the purposes of the search, if any Interactor has no InteractionGroup assigned, we
 * search up the Compound tree first.
 * <pre>
 *            _Group1
 *           /   |
 *          /  Group2      Group3
 *         /    |    \       |                 Group1
 *     Body1   /      Cmp1   |                 /   \           Group3
 *    /    \  /      /    \  |      ==>    Shp1    Group2        |
 * Shp1   Shp2   Body2     Cmp2                    /    \      Shp4
 *                 |         |                  Shp2    Shp3
 *                Shp3     Body3
 *                           |
 *                         Shp4
 * </pre>
 * If we look at which InteractionGroup is used for which Shape following this rule, then
 * the left graph can be transformed into an InteractionGroup tree on the right and we get
 * that the MRCA (Most recent common ancestors) are such that:
 * <pre>
 * MRCA(Shp1, Shp3) == Group1;
 * MRCA(Shp2, Shp3) == Group2;
 * MRCA(Shp4,   # ) == null;
 * </pre>
 * If we were to set up the groups such that <code>Group1.ignore = false</code> and
 * <code>Group2.ignore = true</code>; then shapes 1 and 3 would not be permitted to
 * interact, whilst shapes 2 and 3 would be permitted.
 * <br/>
 * As the MRCA for shape 4 with any other is null, then the value of Group3's ignore field
 * is irrelevant, but the existance of Group3 is not as it serves to otherwise prevent Shape 4
 * from being permitted to interact with shapes 2 and 3.
 * <br/><br/>
 * InteractionGroup's can be fairly expressive, but they are strictly less powerful than
 * InteractionFilters. InteractionGroup's have their place however as there is no limit
 * to the number of Groups you can use.
 */
@:final#if nape_swc@:keep #end
class InteractionGroup{
    /**
     * @private
     */
    public var zpp_inner:ZPP_InteractionGroup=null;
    /**
     * Parent group in InteractionGroup tree.
     * @default null
     */
    #if nape_swc@:isVar #end
    public var group(get_group,set_group):Null<InteractionGroup>;
    inline function get_group():Null<InteractionGroup>{
        return if(zpp_inner.group==null)null else zpp_inner.group.outer;
    }
    inline function set_group(group:Null<InteractionGroup>):Null<InteractionGroup>{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(group==this)throw "Error: Cannot assign InteractionGroup to itself";
            #end
            zpp_inner.setGroup(group==null?null:group.zpp_inner);
        }
        return get_group();
    }
    /**
     * Ignore property, set to true so that objects will not interact.
     * @default false
     */
    #if nape_swc@:isVar #end
    public var ignore(get_ignore,set_ignore):Bool;
    inline function get_ignore():Bool{
        return zpp_inner.ignore;
    }
    inline function set_ignore(ignore:Bool):Bool{
        {
            if(this.ignore!=ignore){
                zpp_inner.invalidate(true);
                zpp_inner.ignore=ignore;
            }
        }
        return get_ignore();
    }
    /**
     * Set of active interactors using this group.
     * <br/><br/>
     * Active interactors meaning those that are part of a Space.
     * <br/><br/>
     * This list is immutable.
     */
    #if nape_swc@:isVar #end
    public var interactors(get_interactors,never):InteractorList;
    inline function get_interactors():InteractorList{
        if(zpp_inner.wrap_interactors==null)zpp_inner.wrap_interactors=ZPP_InteractorList.get(zpp_inner.interactors,true);
        return zpp_inner.wrap_interactors;
    }
    /**
     * Immutable set of children of Interaction groups.
     * <br/><br/>
     * You cannot assign or remove children in this manner, you must do it via setting
     * the childs parent group to this/null.
     * <br/><br/>
     * This list is immutable.
     */
    #if nape_swc@:isVar #end
    public var groups(get_groups,never):InteractionGroupList;
    inline function get_groups():InteractionGroupList{
        if(zpp_inner.wrap_groups==null)zpp_inner.wrap_groups=ZPP_InteractionGroupList.get(zpp_inner.groups,true);
        return zpp_inner.wrap_groups;
    }
    /**
     * Construct a new InteractionGroup.
     *
     * @param ignore Whether interactors should be ignored. (default false)
     */
    public function new(ignore=false){
        zpp_inner=new ZPP_InteractionGroup();
        zpp_inner.outer=this;
        this.ignore=ignore;
    }
    /**
     * @private
     */
    public function toString(){
        var ret="InteractionGroup";
        if(ignore)ret+=":ignore";
        return ret;
    }
}
