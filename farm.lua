function GetATM()
	for i, v in pairs(workspace.Cashiers:GetChildren()) do
		if v:WaitForChild("Humanoid").Health > 0 then
			local cf = v.Open.CFrame
			local lv = cf.lookVector
			game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = cf + (lv * Vector3.new(0, 0, -2))
			game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", v.Open.Position)
			return v
		end
	end
end
farm = true

function GETMONEY()
	for i, v in pairs(workspace.Ignored.Drop:GetChildren()) do
		if v.Name == "MoneyDrop" and (workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.Position - v.Position).Magnitude < 25
		then
			fireclickdetector(v.ClickDetector)
			wait(0.7)
		end
	end
end


game:GetService("RunService").Heartbeat:Connect(function()
GETMONEY()
GETMONEY()
GETMONEY()
ATM = GetATM()
local cf = ATM.Open.CFrame
local lv = cf.lookVector
game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
	cf + (lv * Vector3.new(0, 0, -2))
repeat
	pcall (function()
		game.Players.LocalPlayer.Backpack.Combat.Parent = game.Players.LocalPlayer.Character
	end)
	wait()
	game.Players.LocalPlayer.Character.Combat:Activate()
until ATM.Humanoid.Health > 0
		wait(2.5)
		for i, v in pairs(workspace.Ignored.Drop:GetChildren()) do
			if v.Name == "MoneyDrop" and (workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.Position - v.Position).Magnitude < 25
			then
				fireclickdetector(v.ClickDetector)
				wait(0.7)
		end
end
end)

-- // Wait until game loaded
repeat wait() until game:IsLoaded()

-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local LocalPlayer = Players.LocalPlayer

function serverhop()
    print("PENIS")
    pcall(function()
	    Plr.Character:Destroy()
	    repeat wait() until Plr.Character
    end)
    Plr:Kick("Rejoining...")
    
	while wait(5) do
	    local x = {}
	    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		    if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId and v.maxPlayers-10 < v.playing then
			    x[#x + 1] = v.id
        	end
	    end
    	if #x > 0 then
    		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
    	end
    end
end
spawn(function()
    wait(300)
    serverhop()
end)
LocalPlayer.OnTeleport:Connect(function(State)
    if (State == Enum.TeleportState.Started) then
        syn.queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/0nly6Ex/fastfarm/main/farm.lua"))
    end
end)
