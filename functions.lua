student = {4,8,128,132,136,140}

function draw_character(num,x,y)
    spr(num,x+1,y,4,4)
    map(0,11,x,y-6,4,5)
end

-- TEXT -------------------------------

function draw_text(text,c,l)
    print(sub(text[c][l],0,text_counter), 44,106,7)
    map(5,12,40,96,11,4)
end

function update_text(text,c)
    if btnp(4) then
        if n < #text[c] and text_done then
            n+=1
            text_counter = 0
            text_done = false
        else
            text_done = true
            text_counter = #text[c][n]
        end
    end

    if text_counter > #text[c][n] then
        text_done = true
    end

    if not text_done and text_counter%6 == 0 then
        if selected%2 == 1 then
            sfx(7+flr(rnd(3))) --girl voice
        else
            sfx(4+flr(rnd(3))) --dude voice
        end
    end
    
    text_counter+=0.5
end

function init_text()
    dialogue = {}
    add(dialogue, {'you\'re just in time!\n','i\'m in a bit of a\npickle here... ',
'some of my students\nare falling behind\nand need help! ','i\'m too busy to\ndo it all\nmyself... ',
'i\'ll be entrusting\nyou with the\ntutoring! ','choose a student\nand you can get\nstarted!'})
    add(dialogue, {'hey! i\'m glad you\ncame to help me!','i\'m having trouble\nwith ' .. topic,
    'do you need to\nstudy up? or are\nyou ready to go?'})
end

-- SHAKE -------------------------------

function init_shake()
    cam_x = 0
    cam_y = 0
    shakeFramesLeft = 0
    shakeIntensity = 6
end

function update_shake()
    if shakeFramesLeft > 0 then
        cam_x = rnd(shakeIntensity) - shakeIntensity/2
        cam_y = rnd(shakeIntensity) - shakeIntensity/2
        shakeFramesLeft -= 1
    else
        cam_x = 0
        cam_y = 0
    end
end

-- student = {4,8,128,132,136,140}
-- girl 1, guy 1, girl 2, guy 2, girl 3, dog

-- TOPICS -------------------------------

    -- {element name, symbol, group num, period, group characterization, state of matter, atomic number, fact 1, fact 2}

-- symbols, groups, states, facts, challenge

 