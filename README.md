# legacy-lua-scripts

Repository containing all my Lua scripts for ET:Legacy. May or may not work with other mods.

## Autoref

This mod allows to define a list of allowed users who will automatically be given referee status when they join the server.
The list to edit is in the `autoref.lua` file and is called `allowed_guids`.

To add it to your server, you simply need to upload the lua file in the `legacy` directory of your server, and add `lua_modules "autoref.lua"` in your server configuration.