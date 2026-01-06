local dr = data.raw

local animation_speed = 0.5
local tint = nil --{0.5, 0.5, 0.5}

local beam_gs = dr["beam"]["laser-beam"]["graphics_set"]

local beam_head = beam_gs["beam"]["head"]["layers"][1]
local beam_head_light = beam_gs["beam"]["head"]["layers"][2]
local beam_body = beam_gs["beam"]["body"][1]["layers"][1]
local beam_body_light = beam_gs["beam"]["body"][1]["layers"][2]
local beam_tail = beam_gs["beam"]["tail"]["layers"][1]
local beam_tail_light = beam_gs["beam"]["tail"]["layers"][2]

beam_head.filename = "__RainbowLasers__/graphics/laser-body-rgb.png"
beam_head.frame_count = 72
beam_head.line_length = 8
beam_head.animation_speed = animation_speed

beam_head_light.repeat_count = 9
beam_head_light.animation_speed = animation_speed

beam_body.filename = "__RainbowLasers__/graphics/laser-body-rgb.png"
beam_body.frame_count = 72
beam_body.line_length = 8
beam_body.animation_speed = animation_speed

beam_body_light.repeat_count = 9
beam_body_light.animation_speed = animation_speed

beam_tail.filename = "__RainbowLasers__/graphics/laser-end-rgb.png"
beam_tail.frame_count = 72
beam_tail.line_length = 8
beam_tail.animation_speed = animation_speed

beam_tail_light.repeat_count = 9
beam_tail_light.animation_speed = animation_speed


local ground_head = beam_gs["ground"]["head"]
local ground_body = beam_gs["ground"]["body"]
local ground_tail = beam_gs["ground"]["tail"]

ground_head.filename = "__RainbowLasers__/graphics/laser-ground-light-head-rgb.png"
ground_head.frame_count = 72
ground_head.line_length = 8
ground_head.repeat_count = nil
ground_head.animation_speed = animation_speed
ground_head.tint = tint

ground_body.filename = "__RainbowLasers__/graphics/laser-ground-light-body-rgb.png"
ground_body.frame_count = 72
ground_body.line_length = 8
ground_body.repeat_count = nil
ground_body.animation_speed = animation_speed
ground_body.tint = tint

ground_tail.filename = "__RainbowLasers__/graphics/laser-ground-light-tail-rgb.png"
ground_tail.frame_count = 72
ground_tail.line_length = 8
ground_tail.repeat_count = nil
ground_tail.animation_speed = animation_speed
ground_tail.tint = tint
