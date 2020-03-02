--[[

Send Message about Server Restarts

]]--

function SendMessage()
	TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n SERVER UNDER MAINTENANCE \n Will be restared frequencly \n If you experience any errors, don't worry, they will be fixed \n ——————————————————————", {239, 0, 0})
	print("SERVER UNDER MAINTENANCE \n Will be restared frequencly")

	SetTimeout(60000, SendMessage)
end

SendMessage()