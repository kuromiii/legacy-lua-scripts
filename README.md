# legacy-lua-scripts

Repository containing all my Lua scripts for ET:Legacy. May or may not work with other mods.

## Autoref

This mod allows to define a list of allowed users who will automatically be given referee status when they join the server.
The list to edit is in the `autoref.lua` file and is called `allowed_guids`.

To add it to your server, you simply need to upload the lua file in the `legacy` directory of your server, and add `lua_modules "autoref.lua"` in your server configuration. You also need to edit the list of allowed users, obviously.

## First Blood

This mod simply plays a sound and displays a message on first blood.
By default, the sound that's played is the referee sound and the message is "player HAS DRAWN THE FIRST BLOOD", but this can easily be changed by editing the `firstblood.lua` file.
Specifically, you need to change the `sound` and `message` variables.

To add it to your server, you simply need to upload the lua file in the `legacy` directory of your server, and add `lua_modules "firstblood.lua"` in your server configuration.

## Max Syringes/Adrenalines

This mod limits the amount of syringes and/or adrenalines for medics to carry.
As ammo is shared between medic syringes and adrenalines, it changes both of these at the same time. Nothing can be done about that unfortunately.

By default, the amount of maximum syringes/adrenalines is 6.

One issue with this mod that I cannot easily fix for now is that if you go to a ammo cabinet (or pick up a ammo pack) and that you have the maximum amount of syringes/adrenalines already, it will still pick it up.

To add it to your server, you simply need to upload the lua file in the `legacy` directory of your server, and add `lua_modules "maxsyringes.lua"` in your server configuration. 