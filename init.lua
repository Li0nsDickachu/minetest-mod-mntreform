--mnt logo
minetest.register_node("mntreform:mnt_wallcarpet", {
    description = "Mnt Wall Carpet",
    inventory_image = "mntreform_mnt_item.png",
    tiles = {"mntreform_mntlogo.png"},
    wield_image = "mntreform_mntlogo.png",
    wield_scale = { x=1, y=1, z=0.5 },
    visual_scale = 1.0, 
    use_texture_alpha = "clip", 
    

    sounds = {
        place = {name="mntreform_wallcarpet", gain=1.0}
    },
    is_ground_content = false,
    paramtype = "light",
    sunlight_propagates = false,
    drawtype = "signlike",
    walkable = false,
    _mcl_hardness = 0.1,
    _mcl_blast_resistance = 0.1,
    stack_max = 64,
    _doc_items_longdesc = "A wall carpet is a carpet that can be placed on any surface. It is intended as wall deocration",
   groups = {handy=1, carpet=1,attached_node=1,flammable=1,fire_encouragement=60, fire_flammability=20, dig_by_water=1,deco_block=1},

    -- Required: store the rotation in param2
    paramtype2 = "wallmounted",

    selection_box = {
        type = "wallmounted",
    },
})


minetest.register_craft({
    type = "shapeless",
    output = "mntreform:mnt_wallcarpet",
    recipe = { 
        "mcl_wool:white_carpet",
        "mcl_wool:black_carpet",
    },
})

minetest.register_craft({
	type = "fuel",
	recipe = "mntreform:mnt_wallcarpet",
	-- Original value: 3.35
	burntime = 3,
})




--mnt computer (off)

minetest.register_node("mntreform:mntcomputer_off", {
    description = "MNT Computer",
    drawtype = "nodebox",
    groups = {handy = 1, falling_node=1, crush_after_fall=1, mesecon_effector_off = 1, mesecon = 2},
    tiles = {
               "mntreform_mntcomputer_topview_off.png",
               "mntreform_mntcomputer_bottom.png",
               "mntreform_mntcomputer_rightside.png",
               "mntreform_mntcomputer_leftside.png",
               "mntreform_mntcomputer_backside_off.png",
               "mntreform_mntcomputer.png"
    },



    mesecons = {effector = {
		action_on = function (pos, node)
			minetest.swap_node(pos, {name="mntreform:mntcomputer_on", param2 = node.param2})
		end,
		rules = mesecon.rules.alldirs,
	}},



    _mcl_hardness = 2,
    _mcl_blast_resistance = 10,
    stack_max = 1,
    _doc_items_longdesc = "This is MNT reform. A new kind of computer. Crafting help: you will need 6 different items to make this computer. A screen, frame, heatsink, batteries, main board and a trackball assembly. Use the real mnt for a reference of which colors dye may be needed.",
    walkable = true,
    paramtype = "light",
    paramtype2 = "facedir",

    node_box = {
        type = "fixed",
        fixed = {
--            {-0.35, -0.35, -0.35,      0.35, -0.5, 0.4}, --bottom
            {(-13.75/32), (-12/32), (-12.75/32),	(13.75/32), (-10/32), (14/32)}, --screen
            {(1/32), (-13.5/32), (-9/32),	(-1/32), (-13.75/32), (-7/32)}, --trackball
            {(-14/32), (-12/32), (-13/32),	(14/32), (-13/32), (14/32)}, --ledge/keyboard

            {(-13/32), (-13/32), (-12/32),	(13/32), (-16/32), (-11/32)}, --bottom front
            {(-13/32), (-13/32), (13/32),	(13/32), (-16/32), (14/32)}, --bottom back
            {(-13/32), (-13/32), (-11/32),	(-12/32), (-16/32), (13/32) }, --bottom right
            {(12/32), (-13/32), (-11/32),	(13/32), (-16/32), (13/32) }, --bottom left


            {(11/32), (-13/32), (8/32),	(-11/32), (-13.5/32), (-9/32)}, --boards
            {(11/32), (-12.5/32), (-3/32),	(3/32), (-15/32), (-11/32)}, --left battery
            {(-3/32), (-12.5/32), (-3/32),	(-11/32), (-15/32), (-11/32)}, --right battery
            {(-3/32), (-12.5/32), (8/32),	(1/32),  (-14/32), (-1/32)}, --heatsink

        },
    },
})



minetest.register_craft({
    type = "shaped",
    output = "mntreform:mntcomputer_off",
    recipe = { 
        {'', 'xpanes:pane_natural_flat', ''},
        {'mntreform:heatsink', 'mntreform:frame', 'mntreform:mainboard'},
        {'mntreform:batteries', 'mntreform:trackball_assembly', 'mntreform:batteries'},
    },
})





--mnt computer (on)

minetest.register_node("mntreform:mntcomputer_on", {
    description = "MNT Computer",
    drawtype = "nodebox",
    groups = {handy=1, falling_node=1, crush_after_fall=1, not_in_creative_inventory=1, mesecon = 2, opaque = 1},
    drop = "node mntreform:mntcomputer_off",
    tiles = {
               "mntreform_mntcomputer_keyboard.png",
               "mntreform_mntcomputer_bottom.png",
               "mntreform_mntcomputer_rightside.png",
               "mntreform_mntcomputer_leftside.png",
               "mntreform_mntcomputer_backside_on.png",
               "mntreform_mntcomputerscreen.png"
    },


    mesecons = {effector = {
		action_off = function (pos, node)
			minetest.swap_node(pos, {name="mntreform:mntcomputer_off", param2 = node.param2})
		end,
		rules = mesecon.rules.alldirs,
	}},



    on_rightclick = function (pos, node)
        minetest.sound_play("mntreform_sound", {pos=pos}, true)
    end,

    _mcl_hardness = 2,
    _mcl_blast_resistance = 10,
    stack_max = 1,
    _doc_items_longdesc = "This is MNT reform. A new kind of computer.",
    walkable = true,
    paramtype = "light",
    paramtype2 = "facedir",
    light_source = 14,

    node_box = {
        type = "fixed",
        fixed = {
--            {(-13.75/32), (14.75/32), (12/32),	(13.75/32), (-12/32), (14/32)}, --first screen
            {(-13.75/32), (14.75/32), (13/32), 	(13.75/32), (-12/32), (14/32)}, --screen

            {(-13.75/32), (14.75/32), (12/32),		(13.75/32), (13/32), (13/32)}, --screen top edge
            {(-13.75/32), (-8/32), (12/32),		(13.75/32), (-12/32), (13/32)}, --screen bottom edge
            {(-13.75/32), (14.75/32), (12/32),		(-12/32), (-12/32), (13/32)}, --screen left edge
            {(12/32), (14.75/32), (12/32),		(13.75/32), (-12/32), (13/32)}, --screen right edge

--          {-0.05, -0.25, -0.35,		0.05, -0.3, -0.25}, --trackball
            {(1/32), (-11.75/32), (-9/32),	(-1/32), (-13.75/32), (-7/32)}, --alternative trackball
            {(-14/32), (-12/32), (-13/32),	(14/32), (-13/32), (14/32)}, --ledge/keyboard

            {(-13/32), (-13/32), (-12/32),	(13/32), (-16/32), (-11/32)}, --bottom front
            {(-13/32), (-13/32), (13/32),	(13/32), (-16/32), (14/32)}, --bottom back
            {(12/32), (-13/32), (-11/32),	(13/32), (-16/32), (13/32) }, --bottom left
            {(-13/32), (-13/32), (-11/32),	(-12/32), (-16/32), (13/32) }, --bottom right


            {(11/32), (-13/32), (8/32),	(-11/32), (-13.5/32), (-9/32)}, --boards
            {(11/32), (-12.5/32), (-3/32),	(3/32), (-15/32), (-11/32)}, --left battery
            {(-3/32), (-12.5/32), (-3/32),	(-11/32), (-15/32), (-11/32)}, --right battery
            {(-3/32), (-12.5/32), (8/32),	(1/32),  (-14/32), (-1/32)}, --heatsink
--           X     Y      Z            X     Y    Z


        },
    },
})




--batteries

minetest.register_node("mntreform:batteries", {
    description = "MNT Batteries",
    drawtype = "nodebox",
    groups = {handy = 1, falling_node=1},
    _mcl_hardness = 2,
    _mcl_blast_resistance = 10,
    stack_max = 64,
    _doc_items_longdesc = "These batteries power the MNT computer",
    walkable = true,
    paramtype = "light",
    paramtype2 = "facedir",



    tiles = {
               "mntreform_mntbatteries.png",
               "mntreform_mntbatteries.png",
               "mntreform_mntbatteries.png",
               "mntreform_mntbatteries.png",
               "mntreform_mntbatteries_frontback.png",
               "mntreform_mntbatteries_frontback.png"
    },


    node_box = {
        type = "fixed",
        fixed = {
            {(4/32), (-13.5/32), (4/32),	(-4/32), (-16/32), (-4/32)}, --left battery
        },
    },

})


minetest.register_craft({
    type = "shaped",
    output = "mntreform:batteries",
    recipe = { 
        {'mcl_dye:lightblue', 'mcl_core:iron_ingot', 'mcl_dye:lightblue'},
        {'mcl_dye:lightblue', 'mesecons:redstone', 'mcl_dye:lightblue'},
        {'mcl_dye:lightblue', 'mcl_core:iron_ingot', 'mcl_dye:lightblue'},
    },
})




--screen

--minetest.register_node("mntreform:screen", {
--    description = "MNT Screen",
--    drawtype = "nodebox",
--    groups = {handy = 1, falling_node=1, crush_after_fall=1},
--    _mcl_hardness = 2,
--    _mcl_blast_resistance = 10,
--    stack_max = 64,
--    _doc_items_longdesc = "This is the official MNT screen",
--    walkable = true,
--    paramtype = "light",
--    paramtype2 = "facedir",


--    tiles = {
--               "mntreform_mntcomputer_screenfront.png",
--               "mntreform_mntcomputer_screenback.png",
--               "mntreform_mntcomputer.png",
--               "mntreform_mntcomputer.png",
--               "mntreform_mntcomputer.png",
--               "mntreform_mntcomputer.png"
--    },



--    node_box = {
--        type = "fixed",
--        fixed = {
--            {(-13.75/32), (-16/32), (-12.75/32),	(13.75/32), (-14/32), (14/32)}, --screen

--        },
--    },
--})


--minetest.register_craft({
--    type = "shaped",
--    output = "mntreform:screen",
--    recipe = { 
--        {'mcl_core:iron_ingot', 'mcl_core:iron_ingot', 'mcl_core:iron_ingot'},
--        {'mcl_core:iron_ingot', 'xpanes:pane_natural_flat', 'mcl_core:iron_ingot'},
--        {'mcl_core:iron_ingot', 'mcl_core:iron_ingot', 'mcl_core:iron_ingot'},
--    },
--})




--heatsink

minetest.register_node("mntreform:heatsink", {
    description = "MNT Heatsink",
    drawtype = "nodebox",
    groups = {handy = 1, falling_node=1},
    _mcl_hardness = 2,
    _mcl_blast_resistance = 10,
    stack_max = 64,
    _doc_items_longdesc = "This heatsink cools the MNT computer",
    walkable = true,
    paramtype = "light",
    paramtype2 = "facedir",



    tiles = {
               "mntreform_heatsink_topview.png",
               "mntreform_heatsink.png",
               "mntreform_heatsink_leftside.png",
               "mntreform_heatsink_rightside.png",
               "mntreform_heatsink.png",
               "mntreform_heatsink.png"
    },


    node_box = {
        type = "fixed",
        fixed = {
            {(-2/32), (-14/32), (4/32),	(2/32),  (-16/32), (-5/32)}, --heatsink
        },
    },

})



minetest.register_craft({
    type = "shaped",
    output = "mntreform:heatsink",
    recipe = { 
        {'', 'mcl_dye:black', ''},
        {'', 'mcl_core:iron_ingot', ''},
        {'', 'mcl_core:iron_ingot', ''},
    },
})


--frame

minetest.register_node("mntreform:frame", {
    description = "MNT Frame",
    drawtype = "nodebox",
    groups = {handy = 1, falling_node=1, crush_after_fall=1},
    _mcl_hardness = 2,
    _mcl_blast_resistance = 10,
    stack_max = 64,
    _doc_items_longdesc = "This is the frame that holds the MNT computer",
    walkable = true,
    paramtype = "light",
    paramtype2 = "facedir",



    tiles = {
               "mntreform_mntcomputer_keyboardframe.png",
               "mntreform_mntcomputer.png",
               "mntreform_mntcomputer_rightside.png",
               "mntreform_mntcomputer_leftside.png",
               "mntreform_mntcomputer_backside_on.png",
               "mntreform_mntcomputerscreen_frame.png"
    },


    node_box = {
        type = "fixed",
        fixed = {
            {(-13.75/32), (14.75/32), (13.9/32), 	(13.75/32), (-12/32), (14/32)}, --screen

            {(-13.75/32), (14.75/32), (12/32),		(13.75/32), (13/32), (13.9/32)}, --screen top edge
            {(-13.75/32), (-8/32), (12/32),		(13.75/32), (-12/32), (13.9/32)}, --screen bottom edge
            {(-13.75/32), (14.75/32), (12/32),		(-12/32), (-12/32), (13.9/32)}, --screen left edge
            {(12/32), (14.75/32), (12/32),		(13.75/32), (-12/32), (13.9/32)}, --screen right edge


            {(-14/32), (-12/32), (-13/32),		(14/32), (-13/32), (14/32)}, --ledge/keyboard

            {(-13/32), (-13/32), (-12/32),		(13/32), (-16/32), (-11/32)}, --bottom front
            {(-13/32), (-13/32), (13/32),		(13/32), (-16/32), (14/32)}, --bottom back
            {(12/32), (-13/32), (-11/32),		(13/32), (-16/32), (13/32) }, --bottom left
            {(-13/32), (-13/32), (-11/32),		(-12/32), (-16/32), (13/32) }, --bottom right
        },
    },

})


minetest.register_craft({
    type = "shaped",
    output = "mntreform:frame",
    recipe = { 
        {'mcl_dye:black', 'mcl_dye:black', 'mcl_dye:black'},
        {'mcl_dye:black', 'mcl_core:ironblock', 'mcl_dye:black'},
        {'mcl_dye:black', 'mcl_dye:black', 'mcl_dye:black'},
    },
})



--mnt trackball assembly

minetest.register_node("mntreform:trackball_assembly", {
    description = "MNT Trackball Assembly",
    drawtype = "nodebox",
    groups = {handy = 1, falling_node=1},
    _mcl_hardness = 2,
    _mcl_blast_resistance = 10,
    stack_max = 64,
    _doc_items_longdesc = "This is the trackball assembly for the MNT computer",
    walkable = true,
    paramtype = "light",
    paramtype2 = "facedir",



    tiles = {
               "mntreform_trackball_assembly_top.png",
               "mntreform_trackball_assembly.png",
               "mntreform_trackball_assembly_sides.png",
               "mntreform_trackball_assembly_sides.png",
               "mntreform_trackball_assembly_sides.png",
               "mntreform_trackball_assembly.png",
    },


    node_box = {
        type = "fixed",
        fixed = {
            {(3/32), (-15/32), (-3/32),	(-3/32), (-15.5/32), (3/32)}, --boards
            {(1/32), (-14/32), (-3/32),	(-1/32), (-16/32), (-1/32)}, --alternative trackball
        },
    },

})



minetest.register_craft({
    type = "shaped",
    output = "mntreform:trackball_assembly",
    recipe = { 
        {'', 'mcl_dye:green', ''},
        {'mcl_core:gold_ingot', 'mcl_dye:white', 'mcl_core:gold_ingot'},
        {'mesecons:redstone', 'mcl_core:iron_ingot', 'mesecons:redstone'},
    },
})


--mnt mainboard

minetest.register_node("mntreform:mainboard", {
    description = "MNT Mainboard",
    drawtype = "nodebox",
    groups = {handy = 1, falling_node=1},
    _mcl_hardness = 2,
    _mcl_blast_resistance = 10,
    stack_max = 64,
    _doc_items_longdesc = "This is the mainboard for the MNT computer",
    walkable = true,
    paramtype = "light",
    paramtype2 = "facedir",



    tiles = {
               "mntreform_mainboard_top.png",
               "mntreform_mainboard.png",
               "mntreform_mainboard.png",
               "mntreform_mainboard.png",
               "mntreform_mainboard.png",
               "mntreform_mainboard.png",
    },


    node_box = {
        type = "fixed",
        fixed = {
            {(11/32), (-15.5/32), (8/32),	(-11/32), (-16/32), (-2/32)}, --boards
        },
    },

})



minetest.register_craft({
    type = "shaped",
    output = "mntreform:mainboard",
    recipe = { 
        {'mesecons:redstone', 'mcl_dye:dark_green', 'mesecons:redstone'},
        {'mcl_core:gold_ingot', 'mcl_dye:white', 'mcl_core:gold_ingot'},
        {'mesecons:redstone', 'mcl_core:gold_ingot', 'mesecons:redstone'},
    },
})
