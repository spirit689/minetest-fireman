
fireman = {}

local function remove_nodes(user) 
    local pos = user:get_pos()
    pos = pos:round()

    local r = 8;

    local pos1 = pos:subtract(r)
    local pos2 = pos:add(r)
    local found = minetest.find_nodes_in_area(pos1, pos2, { 'group:fire', 'group:water', 'group:lava' })

    if #found > 0 then
        minetest.bulk_set_node(found, { name = "air" })
        minetest.chat_send_player(user:get_player_name(), 'Fireman: removed ' .. tostring(#found) .. ' nodes')
    end
end

local def = {
    description = 'Extinguisher',
    inventory_image  = '',
    on_use = function (itemstack, user, pointed_thing)
        if(minetest.check_player_privs(user, 'fireman')) then
            remove_nodes(user)
        end
    end
}

minetest.register_tool('fireman:x', def)

minetest.register_chatcommand("rm", {
	params = "",
	description = "Remove nearby fire nodes.",
	privs = {fireman=true},
	func = function(name, param)
        local user = minetest.get_player_by_name(name)
        remove_nodes(user)
	end
})

minetest.register_privilege('fireman', {
    description = 'Fireman can remove nearby fire nodes',
    give_to_singleplayer = true,
    give_to_admin = true
})