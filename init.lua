
local anim_speed = 60

minetest.register_entity("test_attach_select:ent1",  {
	initial_properties = {
		physical = false,
		collide_with_objects = false,
		--~ collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		--~ selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		pointable = false,
		visual = "mesh",
		--~ visual_size = {x = 1, y = 1, z = 1},
		mesh = "test_attach_select_ent1.b3d",
		textures = {"test_attach_select_ent1.png"},
		is_visible = true,
		backface_culling = false,
		static_save = true,
	},

	on_activate = function(self, staticdata, dtime_s)
		local pos = self.object:get_pos()

		local red = minetest.add_entity(pos, "test_attach_select:ent2")
		red:set_attach(self.object, "option_red")
		red:get_luaentity().color = "red"

		local yellow = minetest.add_entity(pos, "test_attach_select:ent2")
		yellow:set_attach(self.object, "option_yellow")
		yellow:get_luaentity().color = "yellow"

		local green = minetest.add_entity(pos, "test_attach_select:ent2")
		green:set_attach(self.object, "option_green")
		green:get_luaentity().color = "green"

		self.object:set_animation({x = 0, y = 36}, anim_speed)
	end,
})

minetest.register_entity("test_attach_select:ent2",  {
	initial_properties = {
		physical = false,
		collide_with_objects = false,
		selectionbox = {-0.2, -0.2, -0.2, 0.2, 0.2, 0.2},
		pointable = true,
		visual = "cube", -- invisible would be good
		--~ visual_size = {x = 0.4, y = 0.4, z = 0.4},
		visual_size = {x = 0, y = 0, z = 0},
		mesh = "test_attach_select_ent1.b3d",
		textures = {},
		is_visible = true,
		backface_culling = false,
		static_save = false,
		damage_texture_modifier = "",
	},

	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
		local playername = puncher and puncher:get_player_name()
		if playername then
			minetest.chat_send_player(playername, minetest.colorize(self.color or "white",
					"[ent2] punched, color="..(self.color or "<invalid>")))
		end
		return true
	end,
})

local function create_server_lag()
	local t0 = minetest.get_us_time()
	while minetest.get_us_time() < t0 + 1000000 do
		-- wait
	end
	minetest.after(0, create_server_lag)
end

-- uncomment to test with 1 second server lags
--~ minetest.after(0, create_server_lag)
