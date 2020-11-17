pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- title: invaders
-- author: elliott
-- 


ps = {

	position = {
		x = 60,
		y = 120,
	},
	
	sprite = 1,
	xmin = 0,
	xmax = 120,
	speed = 3
}

function _update()
	
-- update x coordinate
-- 2 = left
-- 3 = right
	if (btn(0)) then
		ps.position.x =
		 ps.position.x - ps.speed
	end
	
		if (btn(1)) then
		ps.position.x =
		 ps.position.x + ps.speed
	end
	
		if ps.position.x > ps.xmax then
			ps.position.x = ps.xmax
		end
	
		if ps.position.x < ps.xmin then 
			ps.position.x = ps.xmin
		end
	
	cls()
	
	spr(ps.sprite, ps.position.x, ps.position.y)

end
__gfx__
0000000000000000cccccccccccccccccc8cc8cc8888888900000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000cccccccccc8cc8ccccc88ccc88a8888800000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccccc8cc8ccc8cccc8c88888a8800000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000ccccccccccccccccc8cccc8c8988888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000bb000cccccccccccccccccccccccc88a88a8800000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000bb000ccccccccc888888c888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbbcccccccccc8888cc888888888898888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbbcccccccccccccccc888888888888889800000000000000000000000000000000000000000000000000000000000000000000000000000000