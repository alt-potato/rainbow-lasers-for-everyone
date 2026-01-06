local dr = data.raw

local animation_speed = 0.5
local tint = nil --{0.5, 0.5, 0.5}

local MOD_NAME = "rainbow-lasers-for-everyone"
local FILE_CONVERSION_TABLE = {
	["__base__/graphics/entity/laser-turret/laser-body.png"] = "__" .. MOD_NAME .. "__/graphics/laser-body-rgb.png",
	["__base__/graphics/entity/laser-turret/laser-end.png"] = "__" .. MOD_NAME .. "__/graphics/laser-end-rgb.png",
	["__base__/graphics/entity/laser-turret/laser-ground-light-body.png"] = "__"
		.. MOD_NAME
		.. "__/graphics/laser-ground-light-body-rgb.png",
	["__base__/graphics/entity/laser-turret/laser-ground-light-head.png"] = "__"
		.. MOD_NAME
		.. "__/graphics/laser-ground-light-head-rgb.png",
	["__base__/graphics/entity/laser-turret/laser-ground-light-tail.png"] = "__"
		.. MOD_NAME
		.. "__/graphics/laser-ground-light-tail-rgb.png",
}

-- lua is such a funny language isn't it
-- lua is great i love lua i should probably be hit on the head with a hammer for this
local convert = {
		beam = function(beam_segment)
			local base = beam_segment.layers[1]
			local light = beam_segment.layers[2]

      local new_filename = FILE_CONVERSION_TABLE[base.filename]
      if not new_filename then
        return
      end

			base.filename = new_filename
			base.frame_count = 72
			base.line_length = 8
			base.animation_speed = animation_speed

			light.repeat_count = 9
			light.animation_speed = animation_speed
		end,
		ground = function(beam_segment)
      local new_filename = FILE_CONVERSION_TABLE[beam_segment.filename]
      if not new_filename then
        return
      end

			beam_segment.filename = new_filename
			beam_segment.frame_count = 72
			beam_segment.line_length = 8
			beam_segment.repeat_count = nil
			beam_segment.animation_speed = animation_speed
			beam_segment.tint = tint
		end
}

local function update_laser_beam_graphics(beam_gs)
	convert.beam(beam_gs["beam"]["head"])
	convert.beam(beam_gs["beam"]["body"][1])
	convert.beam(beam_gs["beam"]["tail"])

	convert.ground(beam_gs["ground"]["head"])
	convert.ground(beam_gs["ground"]["body"])
	convert.ground(beam_gs["ground"]["tail"])
end

local function update_electric_beam_graphics(beam_gs)
  convert.ground(beam_gs["beam"]["head"])
	convert.ground(beam_gs["beam"]["body"])
  convert.ground(beam_gs["beam"]["tail"])
end

-- laser beam format
-- looks for a beam with two layers (main and light) and a ground with one layer
local function is_laser_beam(beam_gs)
	-- mfw no lua try/catch
	return beam_gs.beam
		and beam_gs.beam.head
		and beam_gs.beam.head.layers
		and beam_gs.beam.head.layers[1]
		and beam_gs.beam.body
		and #beam_gs.beam.body == 1
		and beam_gs.beam.body[1]
		and #beam_gs.beam.body[1].layers == 2
		and beam_gs.beam.tail
		and beam_gs.beam.tail.layers
		and beam_gs.beam.tail.layers[1]
		and beam_gs.ground
		and beam_gs.ground.head
		and beam_gs.ground.body
		and beam_gs.ground.tail
end

-- electric beam format
-- looks for multiple bodies ig idk
local function is_electric_beam(beam_gs)
	return beam_gs.beam and beam_gs.beam.body and type(beam_gs.beam.body) == "table" and #beam_gs.beam.body > 1
end

local function update_beam_graphics(beam)
	if not beam.graphics_set then
		log("No graphics set for beam: " .. beam.name .. ", skipping")
		return
	end

	local beam_gs = beam.graphics_set

	if is_laser_beam(beam_gs) then
		update_laser_beam_graphics(beam_gs)
		return
	end

	if is_electric_beam(beam_gs) then
		update_electric_beam_graphics(beam_gs)
		return
	end

	-- unknown format, do nothing
	log("Unknown beam format for beam '" .. beam.name .. "', skipping")
end

for beam_name, beam in pairs(dr["beam"] or {}) do
	update_beam_graphics(beam)
end
