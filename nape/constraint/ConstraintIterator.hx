package nape.constraint;
import nape.constraint.ConstraintList;
import zpp_nape.util.Lists.ZPP_ConstraintList;
/**
 * Haxe Iterator<T> compatible iterator over Nape list.
 */
#if!false@:final #end
#if nape_swc@:keep #end
class ConstraintIterator{
    /**
     * @private
     */
    public var zpp_inner:ConstraintList=null;
    /**
     * @private
     */
    public var zpp_i:Int=0;
    /**
     * @private
     */
    public var zpp_critical:Bool=false;
    /**
     * @private
     */
    public static var zpp_pool:ConstraintIterator=null;
    /**
     * @private
     */
    public var zpp_next:ConstraintIterator=null;
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_ConstraintList.internal)throw "Error: Cannot instantiate "+"Constraint"+"Iterator derp!";
        #end
    }
    /**
     * Create iterator for Nape list.
     * <br/><br/>
     * There is no specific reason to use this over: <code>list.iterator()</code>
     * especcialy since this requires writing the class name :)
     * (This function is used internally)
     *
     * @param list The Nape list to create iterator for.
     * @return     An iterator over the Nape list.
     */
    public static function get(list:ConstraintList){
        var ret=if(zpp_pool==null){
            ZPP_ConstraintList.internal=true;
            var ret=new ConstraintIterator();
            ZPP_ConstraintList.internal=false;
            ret;
        }
        else{
            var r=zpp_pool;
            zpp_pool=r.zpp_next;
            r;
        }
        ret.zpp_i=0;
        ret.zpp_inner=list;
        ret.zpp_critical=false;
        return ret;
    }
    /**
     * Check if there are any elements remaining.
     *
     * @return True if there are more elements to iterator over.
     */
    #if nape_swc@:keep #end
    public inline function hasNext(){
        #if true zpp_inner.zpp_inner.valmod();
        #else zpp_inner.zpp_vm();
        #end
        var length=zpp_inner.length;
        zpp_critical=true;
        if(zpp_i<length){
            return true;
        }
        else{
            {
                this.zpp_next=ConstraintIterator.zpp_pool;
                ConstraintIterator.zpp_pool=this;
                this.zpp_inner=null;
            };
            return false;
        }
    }
    /**
     * Return next element in list.
     *
     * @return The next element in iteration.
     */
    #if nape_swc@:keep #end
    public inline function next(){
        zpp_critical=false;
        return zpp_inner.at(zpp_i++);
    }
}
