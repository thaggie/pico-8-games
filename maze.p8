pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
local dog

function create_dog() 
  return {
    x = 64,
    y = 64,
    width = 8,
    height = 8,
    s = 1
  }
end

function create_heart() 
  width = 8
  height = 8
  local x = rnd() * (128 - width)
  local y = rnd() * (128 - height)
  local dx = (rnd() > 0.5) and -2 or 2
  local dy = (rnd() > 0.5) and -2 or 2
  return {
    width = width,
    height = height,
    x = x,
    y = y,
    dx = dx,
    dy = dy
  }
end

function create_squirrel ()
  width = 8
  height = 8
  local x = rnd() * (128 - width)
  local y = rnd() * (128 - height)
  local dx = (rnd() > 0.5) and -1 or 1
  local dy = (rnd() > 0.5) and -1 or 1
  return {
    width = width,
    height = height,
    x = x,
    y = y,
    dx = dx,
    dy = dy
  }
end

function game_init() 
  score = 0
  dog = create_dog()
  heart = create_heart()
  
  squirrels = {}
  mode = 1
end


function detect_collision(h, d) 
  return (h.x + h.width > d.x and h.x < d.x + d.width and h.y + h.height > d.y and h.y < d.y + d.height)
end

function score_point()
    score += 1
    squirrels[#squirrels+1]=create_squirrel()
    heart = create_heart()
    sfx(0)
end

function update_speeder(speeder) 
  if (speeder.x + speeder.dx < 0 or speeder.x + speeder.dx > 128-speeder.width) then
    speeder.dx *= -1
    sfx(1)
  end

  if (speeder.y + speeder.dy < 0 or speeder.y + speeder.dy > 128-speeder.height) then
    speeder.dy *= -1
    sfx(1)
  end

   speeder.x += speeder.dx
   speeder.y += speeder.dy
end

function die()
    mode = 0
    sfx(2)
    if score > high_score then
      high_score = score
    end
end

function game_update() 
  if (btn(0) and dog.x > 1) then
     dog.x = dog.x - 1
     dog.s = 1
  end
  
  if (btn(1) and dog.x < 120) then
     dog.x = dog.x + 1
     dog.s = 0
  end
  
  if (btn(2) and dog.y > 1) then
     dog.y = dog.y - 1
  end
  
  if (btn(3) and dog.y < 120) then
     dog.y = dog.y + 1
  end

  update_speeder(heart)
  

  --update_speeder(squirrel)
  
  for i = 1,#squirrels,1 
  do 
    local squirrel = squirrels[i]
    update_speeder(squirrel)
    if detect_collision(squirrel, dog) then 
      die()
    end
  end

  if detect_collision(heart, dog) then 
    score_point()
  end

end


function draw_squirrel (squirrel) 
  if (squirrel.dx == -1) then
    spr(3, squirrel.x, squirrel.y)
  else
    spr(4, squirrel.x, squirrel.y)
  end
end

function game_draw()
  cls(3)
  rect(0,0,127,127,5)
  spr(2, heart.x, heart.y)

  for i = 1,#squirrels,1 
  do 
    draw_squirrel(squirrels[i])
  end

  spr(dog.s,dog.x,dog.y)
  print(score, 2,2, 7)
end

function _init()   
  game_init()
  mode = 0
  high_score=0
end

function _update() 
  if mode == 0 then 
    if btnp(5) or btnp(4) then 
      game_init()
    end
  else
    game_update()
  end
end

function _draw()
  if mode == 0 then 
    cls()
    spr(dog.s,dog.x,dog.y)
    if (score > 0) then
      print(score .. " - your score", 2,2, 7)
    end
    if (high_score > 0) then
      print(high_score .. " - high score", 2,9, 7)
    end
    
  else
    game_draw()
  end
end

__gfx__
64400000000004460000000000600000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
64500000000005460000000006600600060066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
64444446644444460880880065660660660665600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444448888888076660660660666700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444477774444448888888000660660660666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444440888880000666660666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000088800000666000000666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000008000000066000000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000000000280502705027050161501615015150141502705027050270502c0503005032050241502515025150251502905029050000000000000000000000000000000000000000000000000000000000000
0007000016060120600b00006f0007f000e600085000b400075000b400075000b40006600066000660020d0020d0020d000000000000000000000000000000000000000000000000000000000000000000000000
000600001075015750107500b750137501010018750101001d7501c7501f750257502d7002d750167500e75008750067500000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 01424344

