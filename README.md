base readme
# CS2 UI Replica

This project is a replica of the Counter-Strike 2 (CS2) user interface.

## Configuration

The script uses a `Config` object to manage settings. Here are the available options:

```lua
Config = {}
Config.EnableTestsCommands = true -- Set to true to use test commands
Config.DisplayTopScore = true -- Set to true to display the top score
Config.UseInternalKillDetection = true -- Use the internal kill detection system
```

- `EnableTestsCommands`: Displays test commands if set to `true`.
- `DisplayTopScore`: Displays the top score if set to `true`. You need to populate the values yourself using events or API functions.
- `UseInternalKillDetection`: If set to `true`, the system will use `gameEventTriggered - CEventNetworkEntityDamage` to detect kills. The internal logic is basic, and it's recommended to use your own logic for your game mode.

## FiveM Exports

```lua
-- Set the score for team 1
exports['noxen_cs2_ui']:SetScoreTeam1(score)

-- Set the score for team 2
exports['noxen_cs2_ui']:SetScoreTeam2(score)

-- Set the current team
exports['noxen_cs2_ui']:SetTeam(team)

-- Trigger the kill animation
exports['noxen_cs2_ui']:AddKill()

-- Reset the kill counter
exports['noxen_cs2_ui']:ResetKills()

-- Toggle the UI visibility
exports['noxen_cs2_ui']:Toggle()
```

### Usage in Other Resources

To use these exports in another resource, you can call them like this:

```lua
-- Example: Set team 1 score to 5
exports['noxen_cs2_ui']:SetScoreTeam1(5)

-- Example: Trigger kill animation
exports['noxen_cs2_ui']:AddKill()

-- Example: Toggle UI visibility
exports['noxen_cs2_ui']:Toggle()
```

Make sure that your server.cfg includes the `noxen_cs2_ui` resource and that it's started before any resources that depend on it.

### Note on AddKill()

The `AddKill()` export automatically triggers the kill animation on the HUD.

### For Developers

If you're developing a resource that depends on `noxen_cs2_ui`, you can add it as a dependency in your `fxmanifest.lua` file:

```lua
dependency 'noxen_cs2_ui'
```

This ensures that `noxen_cs2_ui` is loaded before your resource, preventing any potential issues with missing exports.


## Example

```lua
-- Configuration
Config.DisplayTopScore = true
Config.UseInternalKillDetection = false

-- Using the API
API.SetScoreTeam1(5)
API.SetScoreTeam2(3)
API.SetTeam(1)
API.AddKill()

-- To hide/show the UI
API.Toggle()
```

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.