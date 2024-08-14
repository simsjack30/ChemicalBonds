prt={}

function drawprt(prt)
    for p in all(prt) do
        circfill(p.x,p.y,p.rad,p.clr)
    end
end

function decayprt()
    for p in all(prt) do
        p.x+=p.dx*2
        p.y+=p.dy*2
        p.act-=1
        if p.act<0 then
            del(prt,p)
        end
    end
end

function makeprt(xin,yin,clrin)
    for i=1,30 do
        add(prt,{x=xin,y=yin,
            dx=rnd(2)-1,dy=rnd(2)-1,
            rad=rnd(2),act=30+rnd(30),clr=clrin})
    end
end