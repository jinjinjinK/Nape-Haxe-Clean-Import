package zpp_nape.constraint;
import nape.Config;
import nape.TArray;
import nape.constraint.Constraint;
import nape.constraint.UserConstraint;
import nape.geom.Vec3;
import nape.util.Debug;
import zpp_nape.constraint.Constraint;
import zpp_nape.geom.Vec3;
import zpp_nape.util.Debug;
import zpp_nape.util.Math;
#if nape_swc@:keep #end
class ZPP_UserConstraint extends ZPP_Constraint{
    public var outer_zn:UserConstraint=null;
    public function bindVec2_invalidate(_){
        outer_zn.__invalidate();
    }
    public var bodies:TArray<ZPP_UserBody>=null;
    public var dim:Int=0;
    public var jAcc:TArray<Float>=null;
    public var bias:TArray<Float>=null;
    public function addBody(b:ZPP_Body){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                b!=null;
            };
            if(!res)throw "assert("+"b!=null"+") :: "+("addBody :: null UserConstraint");
            #end
        };
        var match=null;
        for(x in bodies){
            if(x.body==b){
                match=x;
                break;
            }
        };
        if(match==null){
            bodies.push(new ZPP_UserBody(1,b));
            if(active&&space!=null){
                if(b!=null)b.constraints.add(this);
            };
        }
        else match.cnt++;
    }
    public function remBody(b:ZPP_Body){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                b!=null;
            };
            if(!res)throw "assert("+"b!=null"+") :: "+("remBody :: null Userconstraint");
            #end
        };
        var match=null;
        var bl=Std.int(bodies.length);
        var i=0;
        while(i<bl){
            var x=bodies[i];
            if(x.body==b){
                x.cnt--;
                if(x.cnt==0){
                    if(bl>0)bodies[i]=bodies[bl-1];
                    bodies.pop();
                    if(active&&space!=null){
                        if(b!=null)b.constraints.remove(this);
                    };
                }
                match=x;
                break;
            }
            i++;
        }
        return match!=null;
    }
    public function bodyImpulse(b:ZPP_Body){
        for(i in 0...dim)J[i]=jAcc[i];
        var ret=Vec3.get(0,0,0);
        if(stepped)outer_zn.__impulse(J,b.outer,ret);
        return ret;
    }
    public override function activeBodies(){
        for(b in bodies){
            if(b.body!=null)b.body.constraints.add(this);
        };
    }
    public override function inactiveBodies(){
        for(b in bodies){
            if(b.body!=null)b.body.constraints.remove(this);
        };
    }
    public var stepped:Bool=false;
    public override function copy(dict:Array<ZPP_CopyHelper>=null,todo:Array<ZPP_CopyHelper>=null):Constraint{
        var ret=outer_zn.__copy();
        copyto(ret);
        throw "not done yet";
        return ret;
    }
    public function new(dim:Int,velonly:Bool){
        super();
        bodies={
            #if flash10 new flash.Vector<ZPP_UserBody>()#else new Array<ZPP_UserBody>()#end;
        };
        this.dim=dim;
        this.velonly=velonly;
        jAcc={
            #if flash10 new flash.Vector<Float>(dim,true)#else new Array<Float>()#end;
        };
        bias={
            #if flash10 new flash.Vector<Float>(dim,true)#else new Array<Float>()#end;
        };
        L={
            #if flash10 new flash.Vector<Float>(dim*dim,true)#else new Array<Float>()#end;
        };
        J={
            #if flash10 new flash.Vector<Float>(dim,true)#else new Array<Float>()#end;
        };
        jOld={
            #if flash10 new flash.Vector<Float>(dim,true)#else new Array<Float>()#end;
        };
        y={
            #if flash10 new flash.Vector<Float>(dim,true)#else new Array<Float>()#end;
        };
        Keff={
            #if flash10 new flash.Vector<Float>((dim*(dim+1))>>>1,true)#else new Array<Float>()#end;
        };
        vec3=Vec3.get(0,0,0);
        for(i in 0...dim){
            jAcc[i]=bias[i]=J[i]=jOld[i]=y[i]=0.0;
            for(j in 0...dim)L[i*dim+j]=0.0;
        }
        stepped=false;
    }
    public override function validate(){
        for(b in bodies)if(b.body.space!=space)throw "Error: Constraints must have each body within the same sapce to which the constraint has been assigned";
        outer_zn.__validate();
    }
    public override function wake_connected(){
        for(b in bodies){
            if(b.body.isDynamic())b.body.wake();
        }
    }
    public override function forest(){
        for(b in bodies){
            if(b.body.isDynamic()){
                var xr=({
                    if(b.body.component==b.body.component.parent)b.body.component;
                    else{
                        var obj=b.body.component;
                        var stack=null;
                        while(obj!=obj.parent){
                            var nxt=obj.parent;
                            obj.parent=stack;
                            stack=obj;
                            obj=nxt;
                        }
                        while(stack!=null){
                            var nxt=stack.parent;
                            stack.parent=obj;
                            stack=nxt;
                        }
                        obj;
                    }
                });
                var yr=({
                    if(component==component.parent)component;
                    else{
                        var obj=component;
                        var stack=null;
                        while(obj!=obj.parent){
                            var nxt=obj.parent;
                            obj.parent=stack;
                            stack=obj;
                            obj=nxt;
                        }
                        while(stack!=null){
                            var nxt=stack.parent;
                            stack.parent=obj;
                            stack=nxt;
                        }
                        obj;
                    }
                });
                if(xr!=yr){
                    if(xr.rank<yr.rank)xr.parent=yr;
                    else if(xr.rank>yr.rank)yr.parent=xr;
                    else{
                        yr.parent=xr;
                        xr.rank++;
                    }
                }
            };
        }
    }
    public override function pair_exists(id:Int,di:Int){
        var ret=false;
        var bl=Std.int(bodies.length);
        for(bi in 0...bl){
            var b=bodies[bi].body;
            for(ci in bi+1...bl){
                var c=bodies[ci].body;
                if((b.id==id&&c.id==di)||(b.id==di&&c.id==id)){
                    ret=true;
                    break;
                }
            }
            if(ret)break;
        }
        return ret;
    }
    public override function broken(){
        outer_zn.__broken();
    }
    public override function clearcache(){
        for(i in 0...dim)jAcc[i]=0.0;
        pre_dt=-1.0;
    }
    public function lsq(v:TArray<Float>){
        var sum=0.0;
        for(i in 0...dim)sum+=v[i]*v[i];
        return sum;
    }
    public function _clamp(v:TArray<Float>,max:Float){
        var x=lsq(v);
        if(x>max*max){
            var scale=max/Math.sqrt(x);
            for(i in 0...dim)v[i]*=scale;
        }
    }
    var L:TArray<Float>=null;
    public function solve(m:TArray<Float>){
        var ind=0;
        for(j in 0...dim){
            var sum=0.0;
            for(k in 0...j-1)sum+=L[j*dim+k]*L[j*dim+k];
            var rec=Math.sqrt(m[ind++]-sum);
            L[j*dim+j]=rec;
            if(rec!=0){
                rec=1.0/rec;
                for(i in j+1...dim){
                    var sum=0.0;
                    for(k in 0...j-1)sum+=L[i*dim+k]*L[j*dim+k];
                    L[i*dim+j]=rec*(m[ind++]-sum);
                }
            }
            else{
                for(i in j+1...dim)L[i*dim+j]=0.0;
                ind+=dim-j-1;
            }
        }
        return L;
    }
    var y:TArray<Float>=null;
    public function transform(L:TArray<Float>,x:TArray<Float>){
        for(i in 0...dim){
            var sum=x[i];
            var lii=L[i*dim+i];
            if(lii!=0){
                for(k in 0...i)sum-=L[i*dim+k]*y[k];
                y[i]=sum/lii;
            }
            else y[i]=0.0;
        }
        for(ix in 0...dim){
            var i=dim-1-ix;
            var lii=L[i*dim+i];
            if(lii!=0){
                var sum=y[i];
                for(k in i+1...dim)sum-=L[k*dim+i]*x[k];
                x[i]=sum/lii;
            }
            else x[i]=0.0;
        }
    }
    public var soft:Float=0.0;
    public var gamma:Float=0.0;
    public var velonly:Bool=false;
    public var jMax:Float=0.0;
    public var Keff:TArray<Float>=null;
    public override function preStep(dt:Float){
        #if NAPE_RELEASE_BUILD 
        outer_zn.__validate();
        #end
        if(pre_dt==-1.0)pre_dt=dt;
        var dtratio=dt/pre_dt;
        pre_dt=dt;
        stepped=true;
        outer_zn.__prepare();
        outer_zn.__eff_mass(Keff);
        L=solve(Keff);
        if(!stiff&&!velonly){
            var biasCoef;
            soft={
                var omega=2*Math.PI*frequency;
                gamma=1/(dt*omega*(2*damping+omega*dt));
                var ig=1/(1+gamma);
                biasCoef=dt*omega*omega*gamma;
                gamma*=ig;
                ig;
            };
            outer_zn.__position(bias);
            if(breakUnderError&&lsq(bias)>maxError*maxError)return true;
            for(i in 0...dim)bias[i]*=-biasCoef;
            _clamp(bias,maxError);
        }
        else{
            for(i in 0...dim)bias[i]=0.0;
            gamma=0.0;
            soft=1.0;
        }
        for(i in 0...dim)jAcc[i]*=dtratio;
        jMax=maxForce*dt;
        return false;
    }
    var vec3:Vec3=null;
    public override function warmStart(){
        for(bs in bodies){
            var b=bs.body;
            outer_zn.__impulse(jAcc,b.outer,vec3);
            {
                var t=(b.imass);
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((t!=t));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"b.vel"+",in b: "+"vec3."+",in s: "+"b.imass"+")");
                    #end
                };
                b.velx+=vec3.x*t;
                b.vely+=vec3.y*t;
            };
            b.angvel+=vec3.z*b.iinertia;
        }
    }
    var J:TArray<Float>=null;
    var jOld:TArray<Float>=null;
    public override function applyImpulseVel(){
        outer_zn.__velocity(J);
        for(i in 0...dim)J[i]=bias[i]-J[i];
        transform(L,J);
        for(i in 0...dim){
            jOld[i]=jAcc[i];
            jAcc[i]+=(J[i]=(J[i]*soft-jAcc[i]*gamma));
        }
        outer_zn.__clamp(jAcc);
        if((breakUnderForce||!stiff)&&lsq(jAcc)>jMax*jMax){
            if(breakUnderForce)return true;
            else if(!stiff)_clamp(jAcc,jMax);
        }
        for(i in 0...dim)J[i]=jAcc[i]-jOld[i];
        for(bs in bodies){
            var b=bs.body;
            outer_zn.__impulse(J,b.outer,vec3);
            {
                var t=(b.imass);
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((t!=t));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"b.vel"+",in b: "+"vec3."+",in s: "+"b.imass"+")");
                    #end
                };
                b.velx+=vec3.x*t;
                b.vely+=vec3.y*t;
            };
            b.angvel+=vec3.z*b.iinertia;
        }
        return false;
    }
    public override function applyImpulsePos(){
        if(velonly)return false;
        outer_zn.__prepare();
        outer_zn.__position(J);
        var lj=lsq(J);
        if(breakUnderError&&lj>maxError*maxError)return true;
        else if(lj<Config.constraintLinearSlop*Config.constraintLinearSlop)return false;
        for(i in 0...dim)J[i]*=-1;
        outer_zn.__eff_mass(Keff);
        transform(solve(Keff),J);
        outer_zn.__clamp(J);
        for(bs in bodies){
            var b=bs.body;
            outer_zn.__impulse(J,b.outer,vec3);
            {
                var t=(b.imass);
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((t!=t));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"b.pos"+",in b: "+"vec3."+",in s: "+"b.imass"+")");
                    #end
                };
                b.posx+=vec3.x*t;
                b.posy+=vec3.y*t;
            };
            b.delta_rot(vec3.z*b.iinertia);
        }
        return false;
    }
    public override function draw(g:Debug){
        outer_zn.__draw(g);
    }
}
#if nape_swc@:keep #end
class ZPP_UserBody{
    public var cnt:Int=0;
    public var body:ZPP_Body=null;
    public function new(cnt:Int,body:ZPP_Body){
        this.cnt=cnt;
        this.body=body;
    }
}
