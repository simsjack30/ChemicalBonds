-- SCENE ONE - MENU -------------------------------
scene.init[1] = function()
    menu_x = 0
    timer = 0
    flash = 0
    display = false
    init_shake()
    heart = false
    counter_start = false
    music_on = true
end

scene.update[1] = function()

    decayprt()

    timer+=1
    if (menu_x < 96) menu_x+=1

    if counter_start then
        flash+=1
        if flash > 120 then
            flash = 0
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
        if music_on then
            music(6)
            music_on = false
        end
        if btnp(4) then
            scene.active=7
            scene.initing()
        end
    end
end

scene.draw[1] = function()
    drawprt(prt)
    camera(cam_x, cam_y)

    if display then
        counter_start = true
        if flash < 60 then
            print('press z to continue', 26, 70, 7)
            print('(' .. chr(142) .. ' on mobile)', 34, 78, 7)
        end
    end
    
    spr(0,128-menu_x,44,8,1)

    if not heart then
        spr(16,-(8*6.5)+menu_x,55,5,1)
    else
        spr(16,-(8*6.5)+menu_x-2,55)
        spr(18,-(8*6.5)+menu_x+18,55,3,1)
    end

    if heart then
        spr(8, 51, 55, 2, 2)
    end
end

-- SCENE TWO - EXPOSITION -------------------------------
scene.init[2] = function()
    music(-1, 3000)
    selected = 7
    init_text()
    professor_text = {'you\'re just in time!\n','i\'m in a bit of a\npickle here... ',
    'some of my students\nare falling behind\nand need help! ','i\'m too busy to\ndo it all\nmyself... ',
    'i\'ll be entrusting\nyou with the\ntutoring! ','choose a student\nand you can get\nstarted!'}
end

scene.update[2] = function()
    if all_text_done(professor_text) then
        if btnp(4) then
            scene.active+=1
            scene.initing()
        end
    else
        update_text(professor_text)
    end
end

scene.draw[2] = function()
    draw_character(characters[selected].sprite,0,94)
    draw_text(professor_text)
end

-- SCENE THREE - CHAR SELECT -------------------------------
scene.init[3] = function()
    music(10, 3000)
    if all_help() then
        scene.active = 10
        scene.initing()
    end
    counter = 0
    selected = 1
    wrap_num = 30
    help = {wrap_text(characters[1].name..' needs help with element symbols',wrap_num),
    wrap_text(characters[2].name..' needs help with groups of elements',wrap_num),
    wrap_text(characters[3].name..' needs help with element groups',wrap_num),
    wrap_text(characters[4].name..' doesn\'t really need help with anything',wrap_num),
    wrap_text(characters[5].name..' needs help with element facts',wrap_num),
    wrap_text(characters[6].name..' needs help with smybols and facts',wrap_num)}
end

scene.update[3] = function()
    counter+=0.005
    if counter > 1 then
        counter = 0
    end

    select_character()
    if btnp(4) then
        music(-1,3000)
        if selected == 4 then
            scene.active = 9
            scene.initing()
        else
            scene.active+=1
            scene.initing()
        end
    end
end

scene.draw[3] = function()
    local count = 1
    map(0,6,0,96,16,4)
    for i=0,2 do
        for j=0,1 do

            if selected == count then
                draw_character(characters[count].sprite,i*40+8,j*40+8+sin(counter*2)*2)
                if characters[count].helped then
                    spr(41,i*40+3,j*40+2+sin(counter*2)*2,2,2)
                end
                count+=1
            else
                draw_character(characters[count].sprite,i*40+8,j*40+8)
                if characters[count].helped then
                    spr(41,i*40+3,j*40+2,2,2)
                end
                count+=1
            end
        end
    end
    print(help[selected], 4, 106, 7)
end

-- SCENE FOUR - STUDY OR TUTOR -------------------------------
scene.init[4] = function()
    init_text()
    chosen = 0
    show_selection = false
    topics = {'element symbols','element groups','element groups','a bit of\neverything','element facts','a bit of\neverything'}
    student_text = {'hey! i\'m glad you\ncame to help me!','i\'m having trouble\nwith ' .. topics[selected],
    'do you need to\nstudy up? or are\nyou ready to go?'}
end

scene.update[4] = function()
    counter+=0.005
    if counter > 1 then
        counter = 0
    end

    if all_text_done(student_text) then
        show_selection = true
        if btnp(4) then
            if chosen%2==0 then
                if selected == 1 or selected == 5 or selected == 6 then
                    scene.active+=1
                    scene.initing()
                else
                    scene.active=8
                    scene.initing()
                end
            else
                scene.active+=2
                scene.initing()
            end
        end
    else
        update_text(student_text)
    end

    if btnp(2) then
        sfx(3)
        counter = 0
        chosen +=1
    end

    if btnp(3) then
        sfx(3)
        counter = 0
        chosen -=1
    end
end

scene.draw[4] = function()
    draw_character(characters[selected].sprite,0,94)
    draw_text(student_text)
    if show_selection then
        for i=0,1 do
            if i == 1 then
                if chosen%2==1 then
                    map(17,1,48,20+i*25+sin(counter*2)*2,4,3)
                    print('study', 54, 31+i*25+sin(counter*2)*2, 7)
                else
                    map(17,1,48,20+i*25,4,3)
                    print('study', 54, 31+i*25, 7)
                end
            else
                if chosen%2==0 then
                    map(17,1,48,20+i*25+sin(counter*2)*2,4,3)
                    print('tutor', 54, 31+i*25+sin(counter*2)*2, 7)
                else
                    map(17,1,48,20+i*25,4,3)
                    print('tutor', 54, 31+i*25, 7)
                end
            end
        end
    end
end

-- SCENE FIVE - TUTOR - FACTS -------------------------------

scene.init[5] = function()
    init_shake()
    init_text()
    init_scroll()

    bank = 0
    if difficulty == 1 then
        bank = 20
    elseif difficulty == 2 then
        bank = 60
    elseif difficulty == 3 then
        bank = 118
    end

    rand_topics = {4,9,10}
    rand_topics2 = {9,10}

    current_question = 1
    questions = {}
    question_text = {}
    wrong_text = {}
    build_questions()
    wrong = false
    correct = 0
    flag = true
    flag2 = true
    show_result = false
end

scene.update[5] = function()
    update_shake()

    if not show_result then
        if btnp(4) and text_done then
            if not wrong then
                if is_correct() then
                    sfx(2)
                    correct += 1
                else
                    shakeFramesLeft = 6
                    sfx(0)
                    wrong = true
                    text_line -= 1
                end
                current_question += 1
            else
                wrong = false
            end
        end
    end

    if not wrong then
        if current_question > 5 then
            if flag then
                show_result = true
                text_line = 1
                flag = false
                result = {'',wrap_text('you got '..correct..' out of 5 correct',20)}
                if correct > 3 then
                    characters[selected].helped = true
                    add(result, wrap_text('this helps a ton! i think i\'m ready! thank you so much',20))
                else
                    add(result, wrap_text('i still may need some help...',20))
                end
            end
            if all_text_done(result) then
                if btnp(4) then
                    scene.active=3
                    scene.initing()
                end
            else
                update_text(result)
            end
        else
            update_text(question_text)
        end
    else
        update_text(wrong_text)
    end

    update_scroll()

end

scene.draw[5] = function()
    camera(cam_x, cam_y)
    map(0,11,12,-5,11,2)
    print(get_info(9)..": "..get_info(1),15,3,7)
    draw_character(characters[selected].sprite,0,94)
    draw_elements()
    draw_scroll()


    if not wrong then
        if current_question > 5 then
            draw_text(result)
        else
            draw_text(question_text)
        end
    else
        draw_text(wrong_text)
        rectfill(elements[questions[current_question-1]][1]*6+4,elements[questions[current_question-1]][2]*6+10,elements[questions[current_question-1]][1]*6+8,elements[questions[current_question-1]][2]*6+14,8)
    end
end

function build_questions()
    for i=1, 5 do
        select_question()
    end
    for i in all(questions) do
        init_topic()
        if topic_num == 4 then
            add(question_text, wrap_text(elements[i][topic_num].." is the symbol for what element?",20))
        else
            add(question_text, wrap_text("what " .. elements[i][topic_num].."?",20))
        end
        add(wrong_text, wrap_text(elements[i][3] .. " was the correct answer",20))
    end
end

function is_correct()
    if get_info(topic_num-2) == elements[questions[current_question]][topic_num] then
        return true
    else
        return false
    end
end

--CALL THIS TO SELECT AN INDEX IN THE ELEMENT SEQUENCE
function init_topic(s)
    if selected == 1 then
        topic_num = 4
    elseif selected == 5 then
        topic_num = rand_topics2[flr(rnd(2))+1]
    elseif selected == 6 then
        topic_num = rand_topics[flr(rnd(3))+1]
    end
end

--CALL THIS TO PUT A RANDOM INT IN THE QUESTIONS ARRAY
function select_question()
    local newQuestionIndex
    repeat
        newQuestionIndex = flr(rnd(bank)) + 1
    until not contains(questions, newQuestionIndex)
    add(questions, newQuestionIndex)
end

function contains(table, value)
    for i = 1, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end

-- SCENE SIX - STUDY -------------------------------

scene.init[6] = function()
    init_scroll()
    tutor_menu = false
    disp = 1
    show_overlay = false
    menu_select = 0
    flash = 0
    overlay_key = {'reactive nonmetals', 'noble gases', 'alkali metals', 'alkaline earth metals',
    'transition metals', 'post-transition metals', 'metalloids', 'lanthanides', 'actinides', 'solid at room temp',
    'liquid at room temp', 'gas at room temp'}
end

scene.update[6] = function()
    flash+=1
    if flash > 120 then
        flash = 0
    end

    if not tutor_menu then
        palt(0,true)
        update_scroll()
    else
        draw_tutor_menu()
        if btnp(3) then
            sfx(3)
            menu_select+=1
            if menu_select > 1 then
                menu_select = 0
                flash = 0
            end
        end
        if btnp(2) then
            sfx(3)
            menu_select-=1
            if menu_select < 0 then
                menu_select = 1
            end
            flash = 0
        end
        if menu_select == 0 then
            if btnp(4) then
                sfx(2)
                show_overlay = not show_overlay
                flash = 0
            end
            if show_overlay then
                if btnp(1) then
                    sfx(3)
                    disp+=1
                end
                if btnp(0) then
                    sfx(3)
                    disp-=1
                end
                if disp < 1 then
                    disp = 12
                end
                if disp > 12 then
                    disp = 1
                end
            end
        else
            if btnp(4) then
                palt(0,true)
                if selected == 1 or selected == 5 or selected == 6 then
                    scene.active=5
                    scene.initing()
                else
                    scene.active=8
                    scene.initing()
                end
            end
        end
    end

    if btnp(4) then
        tutor_menu = true
    end

    if btnp(5) then
        tutor_menu = false
    end

end

scene.draw[6] = function()
    if show_overlay then
        if disp < 10 then
            draw_group(disp)
        else
            draw_state(disp-9)
        end
        print(overlay_key[disp], 19, 14, 7)
    end

    draw_elements()
    map(0,11,12,-5,16,2)
    print(get_info(9)..": "..get_info(1),15,3,7)
    print(get_info(2),104,3,7)
    if get_info(9) < 100 then
        print(wrap_text(get_info(1).." "..get_info(7),31).."\n"..wrap_text("it "..get_info(8),31),3,80,7)
    else
        print(wrap_text(get_info(1).." "..get_info(7),31),3,80,7)
    end
    if not tutor_menu then
        draw_scroll()
    else
        draw_tutor_menu()
    end
end

function draw_tutor_menu()
    palt(0,false)
    rect(34,34,94,94,5)
    rectfill(35,35,93,93,0)
    if menu_select == 0 then
        map(0,14,44,36,5,2)
    else
        map(0,14,44,46,5,2)
    end
    print('overlay', 50, 44, 7)
    print('tutor', 54, 54, 7)
    print('(z to select)', 39, 70, 7)
    print('(x to go back)', 37, 78, 7)
    if menu_select == 0 then
        if flash<60 and show_overlay then
            spr(11, 36, 42)
            spr(12, 86, 42)
        end
    end
end

-- SCENE DIFFICULTY -------------------------------

scene.init[7] = function()
    difficulty = 1
    counter = 0
    diff_table = {' easy','medium',' hard'}
end

scene.update[7] = function()
    if btnp(4) then
        scene.active=2
        scene.initing()
    end
    counter+=0.005
    if counter > 1 then
        counter = 0
    end
    if btnp(2) then
        sfx(3)
        counter = 0
        difficulty -= 1
        if difficulty < 1 then
            difficulty = 3
        end
    end
    if btnp(3) then
        sfx(3)
        counter = 0
        difficulty += 1
        if difficulty > 3 then
            difficulty = 1
        end
    end
end

scene.draw[7] = function()
    for i=1, 3 do
        if difficulty == i then
            print(diff_table[i], 52, 36+i*15+sin(counter*2)*2, 7)
            map(0,14,44,28+i*15+sin(counter*2)*2,5,2)
        else
            print(diff_table[i], 52, 36+i*15, 7)
            map(0,14,44,28+i*15,5,2)
        end
    end
    print('select difficulty', 30, 30, 7)
end

function draw_character(num,x,y)
    map(0,0,x,y-6,4,5)
    spr(num,x+1,y,4,4)
end

function wrap_text(text, max_length)
    local lines = {}
    local current_line = ""
    local remaining_text = text

    while #remaining_text > 0 do
        local break_index = max_length

        if #remaining_text <= max_length then
            break_index = #remaining_text
        else
            while break_index > 0 and sub(remaining_text, break_index, break_index) ~= " " do
                break_index -= 1
            end
        end

        local line_part = sub(remaining_text, 1, break_index)
        add(lines, line_part)

        if break_index < #remaining_text then
            remaining_text = sub(remaining_text, break_index + 1)
        else
            remaining_text = ""
        end
    end

    local wrapped_text = ""
    for i = 1, #lines do
        wrapped_text = wrapped_text .. lines[i] .. "\n"
    end

    return wrapped_text
end

-- SCENE EIGHT - TUTOR REB AND NASH -------------------------------

scene.init[8] = function()
    init_shake()
    init_text()
    init_scroll()

    current_question = 1
    questions = {}
    question_text = {}
    wrong_text = {}
    wrong = false
    correct = 0
    flag = true
    flag2 = true
    show_result = false

    group_key = {'reactive nonmetals','noble gases','alkali metals','alkaline earth metals',
    'transition metals','post-transition metals','metalloids','lanthanides','actinides'}

    numbers_rand = gen_rand()
    build_questions_group()
end

function gen_rand()
    local numbers = {}
    while #numbers < 5 do
        local num = flr(rnd(9)) + 1
        local isDuplicate = false
        for i = 1, #numbers do
            if num == numbers[i] then
                isDuplicate = true
                break
            end
        end
        if not isDuplicate then
            add(numbers, num)
        end
    end
    return numbers
end

function build_questions_group()
    for i in all(numbers_rand) do
        add(question_text, wrap_text("show me an element that belongs to the " .. group_key[i],20))
        add(wrong_text, wrap_text("these elements are " .. group_key[i],20))
    end
end

function is_correct_group()
    if get_info(5) == numbers_rand[current_question] then
        return true
    else
        return false
    end
end

scene.update[8] = function()
    update_shake()

    if not show_result then
        if btnp(4) and text_done then
            if not wrong then
                if is_correct_group() then
                    sfx(2)
                    correct += 1
                else
                    shakeFramesLeft = 6
                    sfx(0)
                    wrong = true
                    text_line -= 1
                end
                current_question += 1
            else
                wrong = false
            end
        end
    end

    if not wrong then
        if current_question > 5 then
            if flag then
                show_result = true
                text_line = 1
                flag = false
                result = {'',wrap_text('you got '..correct..' out of 5 correct',20)}
                if correct > 3 then
                    characters[selected].helped = true
                    add(result, wrap_text('this helps a ton! i think i\'m ready! thank you so much',20))
                else
                    add(result, wrap_text('i may still need some help...',20))
                end
            end
            if all_text_done(result) then
                if btnp(4) then
                    scene.active=3
                    scene.initing()
                end
            else
                update_text(result)
            end
        else
            update_text(question_text)
        end
    else
        update_text(wrong_text)
    end

    update_scroll()

end

scene.draw[8] = function()
    camera(cam_x, cam_y)
    map(0,11,12,-5,11,2)
    print(get_info(9)..": "..get_info(1),15,3,7)
    draw_character(characters[selected].sprite,0,94)
    draw_elements()
    draw_scroll()

    if not wrong then
        if current_question > 5 then
            draw_text(result)
        else
            draw_text(question_text)
        end
    else
        draw_text(wrong_text)
        draw_group(numbers_rand[current_question-1])
    end
end

-- SCENE EIGHT - PAUL -------------------------------

scene.init[9] = function()
    init_text()
    paul_text = {wrap_text('me? no i don\'t need any help with chemistry',20),
    wrap_text('i just come to chill',20),
    wrap_text('you like my cool shades?',20),
    wrap_text('i bet you do! i picked \'em up this morning',20),
    wrap_text('urban outfitters for 50% off',20),
    wrap_text('yeah... they\'re pretty freaking sweet',20),
    wrap_text('wanna hear about my trip out to hawaii last summer?',20),
    wrap_text('dude it was actually so sick',20),
    wrap_text('imagine waking up every day and crushing waves',20),
    wrap_text('that was me for a solid two weeks',20),
    wrap_text('my roommate nelson was so jealous',20),
    wrap_text('suck it nelson',20),
    wrap_text('he\'s just mad that his dad doesn\'t own a ford dealership',20),
    wrap_text('speaking of, you should check out my f-150 raptor',20),
    wrap_text('sickest truck on the streets right now',20),
    wrap_text('bet you drive a honda accord or something',20),
    wrap_text('nah i\'m just kiddin\', you seem pretty cool',20),
    wrap_text('i\'ve been listening to a lot of pitbull lately',20),
    wrap_text('mister worldwide as they say',20),
    wrap_text('his music is a little deeper than you might think',20),
    wrap_text('not a lot of people understand what he\'s getting at',20),
    wrap_text('actually you should come over to the bro cave later',20),
    wrap_text('i can have my friend pick us up some coors',20),
    wrap_text('we can blow through a few games of 2k',20),
    wrap_text('i\'ve earned the title of dunk master at the house',20),
    wrap_text('which is funny because i\'m more of a golf guy',20),
    wrap_text('just being out on the green man...',20),
    wrap_text('it\'s just you and nature and your golfcart',20),
    wrap_text('dang i think my dad is calling',20),
    wrap_text('hold on, i gotta take this',20),
    wrap_text('...',20),
    wrap_text('dude, you just got punked',20),
    wrap_text('no way am i answering a call from my parents',20),
    wrap_text('c\'mon man, up top',20),
    wrap_text('heck yeah, you know what\'s up',20),
    wrap_text('do you think they mind if i light up in here?',20),
    wrap_text('i\'ve been fiending for a little buzz bro',20),
    wrap_text('kyle picked me up this bum vape',20),
    wrap_text('coil is actually giga-busted',20),
    wrap_text('anyway, are you thinking what i\'m thinking?',20),
    wrap_text('we can say it on 3...',20),
    wrap_text('1... 2... 3...',20),
    wrap_text('where the chicks at!',20),
    wrap_text('forreal tho i think kim could get it',20),
    wrap_text('am i allowed to say that? probably not',20),
    wrap_text('dude i have to tell you about my trip abroad',20),
    wrap_text('actually hold that thought, getting a text',20),
    wrap_text('bro my friend chipley is absolutely electric',20),
    wrap_text('this dude just sent a vid of me crushing beer pong',20),
    wrap_text('what were we even talking about?',20),
    wrap_text('can\'t remember',20),
    wrap_text('hey can i ask you a personal question?',20),
    wrap_text('do you think tablets are kinda femenine',20),
    wrap_text('i mean like they\'re so smooth and creative centric',20),
    wrap_text('i donno if i could ever own one ya know',20),
    wrap_text('maybe if they did a crossover with someone like drake',20),
    wrap_text('dude now i\'m hurting for some drake',20),
    wrap_text('i\'m actually like drake in a lot of ways',20),
    wrap_text('my friend chipley is friends with drake\'s neighbor',20),
    wrap_text('actually let me call chipley over here',20)}
    show_menu = false
    flag = true
    listen = 0
end

scene.update[9] = function()
    counter+=0.005
    if counter > 1 then
        counter = 0
    end
    if text_line%5==0 then
        show_menu = true
    else 
        show_menu = false
    end
    if all_text_done(paul_text) then
        if btnp(4) then
            scene.active=3
            scene.initing()
            characters[4].helped = true
        end
    else
        update_text(paul_text)
    end
    if show_menu then
        if btnp(4) then
            if listen == 1 then
                scene.active=3
                scene.initing()
                characters[4].helped = true
            end
        end
        if btnp(2) then
            sfx(3)
            counter = 0
            listen -= 1
            if listen < 0 then
                listen = 1
            end
        end
        if btnp(3) then
            sfx(3)
            counter = 0
            listen += 1
            if listen > 1 then
                listen = 0
            end
        end
    end

end

scene.draw[9] = function()
    draw_character(characters[selected].sprite,0,94)
    draw_text(paul_text)
if show_menu then
    if text_line == 60 then
        map(18, 11, 32, 60 + sin(counter * 2) * 2, 8, 2)
        print('walk away', 46, 68 + sin(counter * 2) * 2, 7)
    else
    if listen == 0 then
        map(18, 11, 32, 40 + sin(counter * 2) * 2, 8, 2)
        map(18, 11, 32, 60, 8, 2)
        print('keep listening', 36, 48 + sin(counter * 2) * 2, 7)
        print('walk away', 46, 68, 7)
    else
        map(18, 11, 32, 40, 8, 2)
        map(18, 11, 32, 60 + sin(counter * 2) * 2, 8, 2)
        print('keep listening', 36, 48, 7)
        print('walk away', 46, 68 + sin(counter * 2) * 2, 7)
    end
end
end

end

function init_characters()
    characters = {
        {
            name = "kim",
            sprite = 136,
            voice = 7,
            helped = false
        },
        {
            name = "tony",
            sprite = 196,
            voice = 4,
            helped = false
        },
        {
            name = "rebecca",
            sprite = 192,
            voice = 7,
            helped = false
        },
        {
            name = "brent",
            sprite = 140,
            voice = 14,
            helped = false
        },
        {
            name = "lamashtu",
            sprite = 200,
            voice = 10,
            helped = false
        },
        {
            name = "paul",
            sprite = 204,
            voice = 4,
            helped = false
        },
        {
            name = "professor",
            sprite = 132,
            voice = 4
        },
            name = "dog",
            sprite = 128
    }
end

function init_scroll()
    scroll_x = 1
    scroll_y = 1
    max_col = 18
    max_row = 11
end

function draw_scroll()
    spr(32, 2+scroll_x*6, 8+scroll_y*6,2,2)
end

function update_scroll()
    if btnp(0) then
        sfx(13)
        repeat
            scroll_x -= 1
            if scroll_x < 1 then
                scroll_x = max_col
                scroll_y -= 1
                if scroll_y < 1 then
                    scroll_y = max_row
                end
            end
        until exists()
    end

    if btnp(1) then
        sfx(13)
        repeat
            scroll_x += 1
            if scroll_x > max_col then
                scroll_x = 1
                scroll_y += 1
                if scroll_y > max_row then
                    scroll_y = 1
                end
            end
        until exists()
    end

    if btnp(2) then
        sfx(13)
        repeat
            scroll_y -= 1
            if scroll_y < 1 then
                scroll_y = max_row
                scroll_x -= 1
                if scroll_x < 1 then
                    scroll_x = max_col
                end
            end
        until exists()
    end

    if btnp(3) then
        sfx(13)
        repeat
            scroll_y += 1
            if scroll_y > max_row then
                scroll_y = 1
                scroll_x += 1
                if scroll_x > max_col then
                    scroll_x = 1
                end
            end
        until exists()
    end
end

function get_info(i)
    return elements_matrix[scroll_x][scroll_y][i]
end

function exists()
    if elements_matrix[scroll_x][scroll_y] ~= nil then
        return true
    else
        return false
    end
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

function init_text()
    text_counter = 0
    text_line = 1
    text_done = false
    current_question = 1
end

function update_text(text)
    text_counter+=0.5
    if btnp(4) then
        if text_done then
            text_done = false
            text_counter = 0
            text_line+=1
        else
            text_counter = #text[text_line]
            text_done = true
        end
    end
    if text_counter > #text[text_line] then
        text_done = true
    end
    if not text_done and text_counter%6 == 2 then
            sfx(characters[selected].voice+flr(rnd(3)))
    end
end

function draw_text(text)
    if scene.active == 5 or scene.active == 8 then
        map(7,14,40,80,11,6)
        print(sub(text[text_line],0,text_counter), 44,89,7)
    else
        map(5,1,40,96,11,4)
        print(sub(text[text_line],0,text_counter), 44,106,7)
    end

end

function all_text_done(text)
    return text_done and (text_line == #text)
end

function all_help()
    for i = 1, 6 do
        if i ~= 4 and not characters[i].helped then
            return false
        end
    end
    return true
end

-- WIN SCENE -------------------------------

scene.init[10] = function()
    music(10, 3000)
    palt(0,false)
    camera(8,0)
    fireworks = 0
    fireworks2 = 0
    fireworks3 = 200
    text = "thank you for playing"
    letter_positions = {}
    for i = 1, #text do
        add(letter_positions, {x = 17+i * 5, y = 64})
    end
end

scene.update[10] = function()
    fireworks+=1
    fireworks2+=1
    fireworks3+=1

    if fireworks > 173 then
        fireworks = 0
        makeprt(20+rnd(108),40+rnd(40),7+rnd(7))
        sfx(18)
        sfx(19)
    end
    if fireworks2 > 239 then
        fireworks2 = 0
        makeprt(20+rnd(108),40+rnd(40),7+rnd(7))
        sfx(19)
        sfx(18)
    end
    if fireworks3 > 257 then
        fireworks3 = 0
        makeprt(20+rnd(108),40+rnd(40),7+rnd(7))
        sfx(19)
        sfx(18)
    end
    decayprt()
    for i = 1, #letter_positions do
        letter_positions[i].y = 64 + sin(i * 0.2 + t()) * 2 -- Adjust the values as needed
    end
end

scene.draw[10] = function()
    drawprt(prt)

    for i = 1, #letter_positions do
        print(sub(text, i, i), letter_positions[i].x, letter_positions[i].y, 7)
    end
    spr(140, 1, 102, 4, 4)
    spr(68, 21, 100, 4, 4)
    spr(72, 40, 98, 4, 4)
    spr(196, 112, 102, 4, 4,true)
    spr(76, 96, 100, 4, 4)
    spr(192, 78, 98, 4, 4,true)
    spr(64, 60, 96, 4, 4)
end