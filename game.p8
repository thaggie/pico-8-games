pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
	player = {
		x=59,
		y=59,
		dx=0,
		dy=0,
		max_dx=4,
		max_dy=3,
		acc=0.5,
		boost=6,
    h=8,
    w=8
	}

	gravity=0.3
	friction=0.85

  hit=false
end

function _update()
	player.dy += gravity
	player.dx *= friction
	
	if (btn(0)) then
		player.dx -= player.acc
	end
	
	if (btn(1)) then
		player.dx += player.acc		
  end

  if (btnp(5) and (player.dy == gravity)) then
		player.dy -= player.boost
  end

  if (player.dx > player.max_dx) then
    player.dx = player.max_dx
  end

  if (player.dy > player.max_dy) then
    player.dy = player.max_dy
  end

  if player.dx<0 then
    if collide_map(player,"left",0) then
      player.dx=0
    end
  end

  if player.dy>0 then
    if collide_map(player,"down",0) then
        player.dy = 0
        player.y-=((player.y+player.h+1)%8)-1
    end
  end

  if player.dx>0 then
    if collide_map(player,"right",0) then
      player.dx=0
    end
  end

  player.x += player.dx
  player.y += player.dy

  if (player.y > 110) then
    player.y = 110
    player.dy = 0
  end

  if (player.x > 128) then
    player.x = -8
  end

  if (player.x < -8) then
    player.x = 128
  end



end

function collide_map(obj,aim,flag)
  local x=obj.x    
  local y=obj.y
  local w=obj.w
  local h=obj.h

  local x1=0    
  local y1=0
  local x2=0    
  local y2=0

  if aim=="left" then
    x1=x-1  y1=y
    x2=x    y2=y+h-1

  elseif aim=="right" then
    x1=x+w    y1=y
    x2=x+w+1  y2=y+h-1

  elseif aim=="up" then
    x1=x+1    y1=y-1
    x2=x+w-1  y2=y

  elseif aim=="down" then
    x1=x      y1=y+h
    x2=x+w    y2=y+h
  end

  --pixels to tiles
  x1/=8    
  y1/=8
  x2/=8    
  y2/=8

  if fget(mget(x1,y1), flag)
  or fget(mget(x1,y2), flag)
  or fget(mget(x2,y1), flag)
  or fget(mget(x2,y2), flag) then
      return true
  else
      return false
  end

end

function _draw()
  cls()
  map(0,0)
  spr(1, player.x, player.y)

  rectfill(0, 118, 127, 127, 13)

  print (hit)
end

__gfx__
00000000006006000000000000000000000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006006000000000000000000000000005800000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000666666000000000000000000000000088a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700006c66c600000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000066776600000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700006776000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000065560000000000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000008b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000008888a8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000068888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000088888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000044444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000888888888888888888000000eeeee000eeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000000000000000000000000000
00899999999999999999980000eccccc000ccccccccccccce0000000000000000000000000000000000000000000000000000000000000000000000000000000
0899aaaaaaaaaaaaaaaa99800eccbbbb000bbbbbbbbbbbbcce000000000000000000000000000000000000000000000000000000000000000000000000000000
089aabbbbbbbbbbbbbbaa9800ecbbaaa000aaaaaaaaaaabbce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abccccccccccccccba9800ecba99900099999999999abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abceeeeeeeeeeeecba9800ecba98800088888888889abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abce0000000000ecba9800ecba98000000000000089abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abceeeeeeeeeeeecba9800ecba98800088888888889abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089abccccccccccccccba9800ecba99900099999999999abce000000000000000000000000000000000000000000000000000000000000000000000000000000
089aabbbbbbbbbbbbbbaa9800ecbbaaa000aaaaaaaaaaabbce000000000000000000000000000000000000000000000000000000000000000000000000000000
0899aaaaaaaaaaaaaaaa99800eccbbbb000bbbbbbbbbbbbcce000000000000000000000000000000000000000000000000000000000000000000000000000000
00899999999999999999980000eccccc000ccccccccccccce0000000000000000000000000000000000000000000000000000000000000000000000000000000
000888888888888888888000000eeeee000eeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0888088808880888aacccccc00000000000000006116bbbbbbbfffff000000000000444444440000000000000000000000000000000000000000000000000000
0888088808c808c8aacccccc0000088b00000000111bbbbbbbffffff0000000000004bbbbbb40000000000000000000000000000000000000000000000000000
0888888808c282c8cccccccc0000888b000000001717bbbbbbff0f0f0000000000004b2bb2b40000000000000000000000000000000000000000000000000000
088888880822e228999888bb00088a88000000007b7bbbbbbbfff0ff0000000000004bbbbbb40000000000000000000000000000000000000000000000000000
088888880889e988999888bb0888888800000000bbbbbbebebbff0ff0000000000004baaaab40000000000000000000000000000000000000000000000000000
00888880008beb80c4cc4cc46888888800000000bbb1111111bf0f0f0000000000444bbbbbb44400000000000000000000000000000000000000000000000000
000888000008b800c4cc4cc48888888800000000bbbb4445114ff0ff0000000000aaa685866aaa00000000000000000000000000000000000000000000000000
0000800000088800bbbbbbb40004444400000000bbb334441bb4bbbb000000000011116661111100000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbb3644411b4bbbb000000000011122222111100000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbb362222224bbbb000000000111112221110100000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000bb33622222e44bbb000000000101112221110100000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000bb3662222224b4bb000000009901122221110990000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000bb3334b4b4b4bb44000000000001222222110000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbb33aaaaaaa4b4b000000000001222222210000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbb3aaaaaaaa4bb000000000003000000030000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbbaaaaaaaaa444000000000055000000055000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010101010100000000000000000000010001010001000000000000000000000101010101010000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000545454545454545454000000520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000545400000000000000000000520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000004041414141414241420000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141416554540000005200520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5000000000000000000000005200520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5000000000000000000000005200520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000000000280502705027050161501615015150141502705027050270502c0503005032050241502515025150251502905029050000000000000000000000000000000000000000000000000000000000000
0007000016060120600b00006f0007f000e600085000b400075000b400075000b40006600066000660020d0020d0020d000000000000000000000000000000000000000000000000000000000000000000000000
000600001075015750107500b750137501010018750101001d7501c7501f750257502d7002d750167500e75008750067500000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 01424344

