Config = {}

Config.EnableTestsCommands = true

-- Set to true if you want to display the top score
-- You have to populate the values yourself using the events / API functions
Config.DisplayTopScore = true

-- Set to false if you want to use your own kill detection system
-- If true, The system will use gameEventTriggered - CEventNetworkEntityDamage to detect kills
-- The Internal logic is very basic and I recommend to use your own logic for your gamemode.
Config.UseInternalKillDetection = true