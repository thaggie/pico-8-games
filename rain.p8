pico-8 cartridge // http://www.pico-8.com
version 18
__lua__


player_x=32
player_y=0

player = {}

baddies = {}
f=0

function _init() 
  cartdata('thaggie_rain')
  high = dget(0)
  score = 0
  for c=7,1,-1 do
    player[c]={x=32 - (c*4), y=60, c=c}
  end
  
  baddies[1] = {x=128, y=60}
  
  flag=0
end

function bad()
  return {x=128,y=flr(rnd(120)) + 1}
end

function _update()
  
  
  for c=7,2,-1 do
    player[c].y = player[c-1].y
  end
  
  if (player[1].y>1) then
    if(btn(2)) then
      player[1].y-=1
    end
  end
  
  if (player[1].y < 120) then
    if(btn(3)) then
      player[1].y+=1
    end
  end
  
  
  for b=1,#baddies do
    baddies[b].x -=1
    if (baddies[b].x < 0) then
       baddies[b] = bad()     
   end    
  end
  
  if (f%18==0) then
    baddies[#baddies+1] = bad()
  end
  
  score = #baddies * 100
  x = player[1].x
  y = player[1].y
  dead = false
  for b=1,#baddies do
    bd = baddies[b]
    if (bd.x < x+5 and bd.x >= x-5) then
      if (bd.y < y+4 and bd.y >= y-4) then
        dead = true
      end 
    end
  end
  
  if dead then
    if (score > high) then 
      high = score
      dset(0, high)
    end
    score = 0
    baddies = {}
  end
  f+=1
end

function _draw()
  cls()
 
  for c=7,1,-1 do
    p = player[c]
    spr(p.c,p.x, p.y)
  end
  
  for b=1,#baddies do
    spr(0,baddies[b].x, baddies[b].y)
  end
  
  
  print('high: '.. high .. ' score: ' .. score, 0,0)
  
  spr(flag, 120, 0)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000008800000099000000aa000000bb000000cc000000dd000000ee0000000000000000000000000000000000000000000000000000000000000000000
00700700008888000099990000aaaa0000bbbb0000cccc0000dddd0000eeee000000000000000000000000000000000000000000000000000000000000000000
0007700008888880099999900aaaaaa00bbbbbb00cccccc00dddddd00eeeeee00000000000000000000000000000000000000000000000000000000000000000
0007700008888880099999900aaaaaa00bbbbbb00cccccc00dddddd00eeeeee00000000000000000000000000000000000000000000000000000000000000000
00700700008888000099990000aaaa0000bbbb0000cccc0000dddd0000eeee000000000000000000000000000000000000000000000000000000000000000000
000000000008800000099000000aa000000bb000000cc000000dd000000ee0000000000000000000000000000000000000000000000000000000000000000000
