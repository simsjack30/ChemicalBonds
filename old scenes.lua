-- SCENE ONE - MENU -------------------------------
scene.init[1] = function()
    x = 0
    timer = 0
    counter = 0
    display = false
    init_shake()
    heart = false
    counter_start = false
end

scene.update[1] = function()

    decayprt()

    timer+=1
    if (x < 96) x+=1

    if counter_start then
        counter+=1
        if counter > 120 then
            counter = 0
        end
    end

    if timer == 96 then
        shakeFramesLeft = 6
        sfx(0)
    end

    if timer == 220 then
        makeprt(56,60,8)
        makeprt(56,60,7)
        makeprt(56,60,2)
        heart = true
        shakeFramesLeft = 6
        sfx(1)
    end

    update_shake()

    if timer > 300 then
        display = true
        if btnp(4) then
            scene.active+=1
            scene.initing()
        end
    end

end

scene.draw[1] = function()
    drawprt(prt)
    camera(cam_x, cam_y)

    if display then
        counter_start = true
        if counter < 60 then
            print('press z to continue', 26, 70, 7)
            print('(' .. chr(142) .. ' on mobile)', 34, 78, 7)
        end
    end
    
    spr(68,128-x,44,8,1)

    if not heart then
        spr(84,-(8*6.5)+x,55,5,1)
    else
        spr(84,-(8*6.5)+x-2,55)
        spr(86,-(8*6.5)+x+18,55,3,1)
    end

    if heart then
        spr(76, 51, 55, 2, 2)
    end
end

-- SCENE TWO - EXPOSITION - STUDY OR TUTOR -------------------------------
scene.init[2] = function()
    c=1
    n=1
    selected = 2
    text_counter = 0
    text_done = false
    next_scene = false
    confirm = false
end

scene.update[2] = function()

    if next_scene then
        if btnp(4) and confirm then
            scene.active+=1
            scene.initing()
        end
        confirm = true
    end

    update_text(dialogue,1)
    

    if n == #dialogue[c] and text_done then
            next_scene = true
    end
end

scene.draw[2] = function()
    draw_character(12,0,94)
    draw_text(dialogue,c,n)
end


-- SCENE THREE - CHAR SELECT -------------------------------
scene.init[3] = function()
    counter = 0
    selected = 1
    help = {'kim needs help with element\nsymbols','nash needs help with states\nof matter','rebecca needs help with\nelement groups','paul doesn\'t have a\nparticular topic he\nneeds help with','lamashtu needs help with\nelement facts','dog desires a challenge'}
end

scene.update[3] = function()
    counter+=0.005
    if counter > 1 then
        counter = 0
    end

        select_character()
        if btnp(4) then
            scene.active+=1
            scene.initing()
        end
end

scene.draw[3] = function()
    map(18,12,0,96,16,4)

    local count = 1

        for i=0,2 do
            for j=0,1 do
                if selected == count then
                    draw_character(student[count],i*40+8,j*40+8+sin(counter*2)*2)
                    count+=1
                else
                    draw_character(student[count],i*40+8,j*40+8)
                    count+=1
                end
            end
        end
    
        print(help[selected], 4, 106, 7)
        

end

function select_character()
    if btnp(0) then
        sfx(3)
        counter = 0
        selected-=2
        if selected < 1 then
            if selected == -1 then
                selected = 6
            else
                selected = 5
            end
        end
    end

    if btnp(1) then
        sfx(3)
        counter = 0
        selected+=2
        if selected > 6 then
            if selected == 7 then
                selected = 2
            else
                selected = 1
            end
        end
    end

    if btnp(2) then
        sfx(3)
        counter = 0
        selected-=1
        if selected < 1 then
            selected = 6
        end
    end

    if btnp(3) then
        sfx(3)
        counter = 0
        selected+=1
        if selected > 6 then
            selected = 1
        end
    end
end


-- SCENE FOUR - CHOICE -------------------------------
scene.init[4] = function()
    counter = 0
    n=1
    x=1
    y=1
    text_done = false
    text_counter = 0
    topics = {'element symbols','groups','states of\nmatter','a bit of\neverything','element facts','challenge'}
    topic = topics[selected]
    show_selection = false
    init_text()
    chosen = 1
    confirm = false
end

scene.update[4] = function()
    counter+=0.005
    if counter > 1 then
        counter = 0
    end

    if selected != 6 then
        update_text(dialogue,2)
    end

    if n == #dialogue[2] and text_done then
        show_selection = true
    end

    if show_selection then
        if btnp(2) then
            counter = 0
            sfx(3)
            chosen +=1
            chosen%=2
        end

        if btnp(3) then
            counter = 0
            sfx(3)
            chosen +=1
            chosen%=2
        end
    end

    if show_selection then
        if btnp(4) and confirm then
            if chosen==1 then
                scene.active+=1
                scene.initing()
            else
                scene.active=6
                scene.initing()
            end
        end
        confirm = true
    end
end

scene.draw[4] = function()
    draw_character(student[selected],0,94)
    draw_text(dialogue,2,n)
    if selected == 6 then
        print('...',44,106,7)
    end

    if show_selection then
        if chosen==1 then
            map(18,10,44,25+sin(counter*2)*2,4,2)
            map(23,10,51,45,4,2)
        else
            map(18,10,44,25,4,2)
            map(23,10,51,45+sin(counter*2)*2,4,2)
        end
    end
end

function scroll()

    local maxGroup = 18
    local maxPeriod = 10

    if btnp(1) then
        repeat
            x += 1
            if x > maxGroup then
                x = 1
                y += 1
                if y > maxPeriod then y = 1 end
            end
        until get_element(y, x) ~= nil
    end

    if btnp(0) then
        repeat
            x -= 1
            if x < 1 then
                x = maxGroup
                y -= 1
                if y < 1 then y = maxPeriod end  -- Wrap around to the bottom
            end
        until get_element(y, x) ~= nil
    end

    if btnp(3) then
        repeat
            y += 1
            if y > maxPeriod then
                y = 1
                x += 1
                if x > maxGroup then x = 1 end  -- Wrap around to the first group
            end
        until get_element(y, x) ~= nil
    end

    if btnp(2) then
        repeat
            y -= 1
            if y < 1 then
                y = maxPeriod
                x -= 1
                if x < 1 then x = maxGroup end  -- Wrap around to the last group
            end
        until get_element(y, x) ~= nil
    end
end



function draw_scroll()
    spr(2, x * 5 + 12, y * 5 + 7)
    print(elements[y][x][4], 11, y * 5 + 8, 7)
    
    if (elements[y][x][5] != 8) and (elements[y][x][5] != 9) then
        if elements[y][x][3] < 10 then
            print(elements[y][x][3], x * 5 + 14, 5, 7)
        else
            print(elements[y][x][3], x * 5 + 12, 5, 7)
        end
    end
end

function drawTable()
    for period, groups in pairs(elements) do
        for group, element in pairs(groups) do
            if element then  
                  spr(1, group * 5 + 13, period * 5 + 8)
            end
        end
    end
end

function get_element(period, group)
    if elements[period] and elements[period][group] then
        return elements[period][group][1]
    else
        return nil
    end
end


-- SCENE FOUR - STUDY -------------------------------

scene.init[5] = function()

end

scene.update[5] = function()
    scroll()
end

scene.draw[5] = function()
    drawTable()
    print(get_element(y,x))
    draw_scroll()
end

-- SCENE FIVE - QUIZ -------------------------------

scene.init[6] = function()
    question_num = 1
    n = 1
    xq = 1
    yq = 1
    text_done = false
    text_counter = 0
    init_prefixes()
end

scene.update[6] = function()
    scroll()
    update_text(prefixes,1)
    -- if btnp(4) then
    --     text_done = false
    --     text_counter = 0
    -- end
end

scene.draw[6] = function()
    drawTable()
    --print(get_element(y,x))
    draw_scroll()
    draw_character(student[selected],0,94)
    draw_text(prefixes,1,n)

    for i in all(random_ints) do
        print(i)
    end
end



-- include a "basics" section, where you can learn about the periodic table
-- challenge mode where you are given the element and you must place it on the table

-- {element name, symbol, group num, period, group characterization, state of matter, fact 1, fact 2}

-- give atomic number

-- table that logs questions asked - so no duplicates
-- table of prefixes


function init_prefixes()
    prefixes = {}
    add(prefixes, {'what element has the\nsymbol ','what about the symbol ','and what about for the symbol ','what about ','last what element has the symbol '})
    add(prefixes, {'pick an element that is a ','find an element that\'s a','can you show me an element that is a ','last show me an element that is a '})
    add(prefixes, {'what element is a member of the ','what about the ','and one that is a ','what about a ','last show me a '})
end

function rnd_element(elements)
    local selected_element

    repeat
        local element_row = flr(rnd(#elements)) + 1
        local element_col = flr(rnd(#elements[element_row])) + 1
        selected_element = elements[element_row][element_col][1]
    until selected_element ~= nil

    return selected_element
end