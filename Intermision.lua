-->> Variables

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Intermision_Tiempo = 30

local Juego_Tiempo = 20

local Jugadores_Activos = {}

local Jugadores_Inactivos = {}

local Recompensa_Activos = math.random(10, 15)

local Recompensa_Inactivos = math.random(1, 5)

local bool = true

local Integers

local Todos_Los_Jugadores = game.Players:GetPlayers()

local PuntoA = workspace:WaitForChild("PuntoA").CFrame

local PuntoB = workspace:WaitForChild("PuntoB").CFrame

local Vida_Predeterminada = 1 * 100 --> 100; esta es la vida que tendra el jugador cuando se termine una partida y todos regresen

local Tiempo_Final = 0 -- El tiempo que aparecera si solo hay un jugador

-->> Funciones

local function Descartar_Jugador(Jugador)
	for indice, Juga in pairs(game.Players:GetPlayers()) do
		if Juga == Jugador then
			if Jugadores_Activos[indice] == nil then
				print("El jugador se encuentra en la lista")
			else
				table.insert(Jugadores_Inactivos, Jugadores_Activos[indice])
				table.remove(Jugadores_Activos, indice)
			end
		end
	end
end

local function Agregar_Jugador(Jugador)
	for indice, Jug in pairs(game.Players:GetPlayers()) do
		if Jug == Jugador then
			if Jugadores_Activos[indice] == nil then
				if Jugadores_Inactivos[indice] == Jugador then
					table.insert(Jugadores_Activos, Jugador)
					table.remove(Jugadores_Inactivos, indice)
				else
					table.insert(Jugadores_Activos, Jugador)
				end
			else
				print("El jugador ya esta en la lista")
			end
		end
	end
end

local function ObtenerLongitud_Tabla(Tabla)
	local Contador = 0 
	for _, v in pairs(Tabla) do
		Contador = Contador + 1
	end
	return Contador
end

-->> Dando valores a las variables posiblemente vacias con un valor "nil" o "nulo"

Integers = {}
Integers["Intermision_Integer"] = ReplicatedStorage.Values:WaitForChild("Intermision")
Integers["Juego_Integer"] = ReplicatedStorage.Values:WaitForChild("Juego")

Integers.Intermision_Integer.Value = Intermision_Tiempo
Integers.Juego_Integer.Value = Juego_Tiempo

-->> Bucles y interactivdad del juego

while bool do

	task.wait()

	Integers["Juego_Integer"].Value = Juego_Tiempo
	for Indice = Intermision_Tiempo, 0, -1  do
		Integers["Intermision_Integer"].Value = Indice
		task.wait(1)
	end

	task.wait(2)

	Integers["Intermision_Integer"].Value = Intermision_Tiempo
	for indice, Jugador in pairs(game.Players:GetPlayers()) do

		if Jugador.Character:FindFirstChild("HumanoidRootPart") and Jugador.Character:FindFirstChild("Humanoid").Health > 0 then
			Agregar_Jugador(Jugador)
			Jugador.Character:WaitForChild("HumanoidRootPart").CFrame = PuntoA
		elseif Jugador.Character:FindFirstChild("HumanoidRootPart") and Jugador.Character:FindFirstChild("Humanoid").Health == 0 then
			Descartar_Jugador(Jugador)
		else
			warn("Error. " .. tostring(Jugador) .. " no es un jugador o instancia invalida")
		end

	end

	if ObtenerLongitud_Tabla(Jugadores_Activos) < 2 then Juego_Tiempo = 3 end

	--print("Jugadores activos: " .. table.concat(Jugadores_Activos) )

	for Indice = Juego_Tiempo, 0, -1 do
		Integers["Juego_Integer"].Value = Indice
		task.wait(1)
	end

	task.wait(2)
	for indice, Jugador in pairs(game.Players:GetPlayers()) do
		local Sentencia_HUMANOIDROOTPART = Jugador.Character:FindFirstChild("HumanoidRootPart")
		if Sentencia_HUMANOIDROOTPART and Jugador.Character:FindFirstChild("Humanoid").Health > 0 then
			Jugador.Character:FindFirstChild("Humanoid").Health = Vida_Predeterminada
			Descartar_Jugador(Jugador)
			Sentencia_HUMANOIDROOTPART.CFrame = PuntoB
		else
			Descartar_Jugador(Jugador)
		end
	end

	--print("Inactivos: " .. table.concat(Jugadores_Inactivos))

end

game.Players.PlayerAdded:Connect(function(Jugador)
	print("asas")

	table.insert(Jugadores_Inactivos, Jugador)

	Jugador.CharacterAdded:Connect(function(char)
		local Humanoid = char:WaitForChild("Humanoid")
		Humanoid.Died:Connect(function()
			print("a")
			Descartar_Jugador(Jugador)
			print("Se removio a un jugador de la lista. Solo quedan " .. table.concat(Jugadores_Inactivos) .. " inactivos e activos")
		end)
	end)

end)

local function fn(plr)
	print("adada")
	for ind, asd in pairs(game.Players:GetPlayers()) do
		if asd == plr then
			if Jugadores_Activos[ind] == nil then return else
				table.remove(Jugadores_Activos, ind)
			end

			if Jugadores_Inactivos[ind] == nil then return else
				table.remove(Jugadores_Inactivos, ind)
			end
		end
	end
	print(
		"Activos: " .. table.concat(Jugadores_Inactivos) .. "\n" ..
			"Inactivos: " .. table.concat(Jugadores_Activos)
	)
end

game.Players.PlayerRemoving:Connect(fn)

game:BindToClose(function()
	for _, Jugador in pairs(game.Players:GetPlayers()) do
		fn(Jugador)
	end
end)
