local replicated = game:GetService("ReplicatedStorage")
local httpservice = game:GetService('HttpService')

local remote2 = replicated:WaitForChild("ChatRemote")

local api_url = "http://127.0.0.1:5000/chat"

remote2.OnServerEvent:Connect(function(player, action, message)
	if action == "response" and message then
		local success, response = pcall(function()
			-- use pcall to make sure to check if got any error
			return httpservice:PostAsync(
				api_url,
				httpservice:JSONEncode({ message = message }),
				Enum.HttpContentType.ApplicationJson
			)
		end)

		if success then
			local data = httpservice:JSONDecode(response)
			local aiResponse = data.response or "can u say it again?"
			remote2:FireClient(player, "response2", aiResponse)
		else
			warn("[!] Error, report to the dev:", response)
		end
	end
end)
