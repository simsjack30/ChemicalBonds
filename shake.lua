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