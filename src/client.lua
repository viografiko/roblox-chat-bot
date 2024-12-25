local replicated = game:GetService("ReplicatedStorage")
local text = game:GetService("TextChatService")

local remote = replicated:WaitForChild("ChatRemote")

text.SendingMessage:Connect(function(message)
	remote:FireServer("response", message.Text)
end)

remote.OnClientEvent:Connect(function(action, aiResponse)
	if action == "response2" and aiResponse then
		text.TextChannels.RBXGeneral:DisplaySystemMessage("[AI] " .. aiResponse)
	end
end)
