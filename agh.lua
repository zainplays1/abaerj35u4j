repeat
	task.wait()
until game:IsLoaded() and
	game:GetService("Players").LocalPlayer and
	game:GetService("Players").LocalPlayer.Character and
	game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate") and
	game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
	game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator")
local a = game.Players.LocalPlayer.Character.Animate
local b = "http://www.roblox.com/asset/?id="
local c

if not getgenv().AlreadyLoaded then
	getgenv().AlreadyLoaded = true
end

game.StarterPlayer.AllowCustomAnimations = true
workspace:SetAttribute("RbxLegacyAnimationBlending", true)

if not getgenv().OriginalAnimations then
	getgenv().OriginalAnimations = {}
	if a:FindFirstChild("pose") then
		local d = game.Players.LocalPlayer.Character.Animate.pose:FindFirstChildOfClass("Animation")
		if d then
			OriginalAnimations[3] = d.AnimationId
		end
	end
	OriginalAnimations[1] = a.idle.Animation1.AnimationId
	OriginalAnimations[2] = a.idle.Animation2.AnimationId
	OriginalAnimations[4] = a.walk:FindFirstChildOfClass("Animation").AnimationId
	OriginalAnimations[5] = a.run:FindFirstChildOfClass("Animation").AnimationId
	OriginalAnimations[6] = a.jump:FindFirstChildOfClass("Animation").AnimationId
	OriginalAnimations[7] = a.climb:FindFirstChildOfClass("Animation").AnimationId
	OriginalAnimations[8] = a.fall:FindFirstChildOfClass("Animation").AnimationId
	if a:FindFirstChild("swim") then
		OriginalAnimations[9] = a.swim:FindFirstChildOfClass("Animation").AnimationId
		OriginalAnimations[10] = a.swimidle:FindFirstChildOfClass("Animation").AnimationId
	end
end

local function e(f)
	return getgenv().OriginalAnimations[f]
end

if syn and syn.queue_on_teleport and not getgenv().AlreadyLoaded then
	syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Eazvy/public-scripts/main/Universal_Animations_Emotes.lua'))()")
elseif queue_on_teleport and not getgenv().AlreadyLoaded then
	queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Eazvy/public-scripts/main/Universal_Animations_Emotes.lua'))()")
end

local g = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	g:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	g:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

local h = 0
local i = 0

getgenv().Settings = {
	Favorite = {},
	Custom = {
		Name = nil,
		Idle = nil,
		Idle2 = nil,
		Idle3 = nil,
		Walk = nil,
		Run = nil,
		Jump = nil,
		Climb = nil,
		Fall = nil,
		Swim = nil,
		SwimIdle = nil,
		Wave = 9527883498,
		Laugh = 507770818,
		Cheer = 507770677,
		Point = 507770453,
		Dance = 507771019,
		Dance2 = 507776043,
		Dance3 = 507777268,
		Weight = 9,
		Weight2 = 1
	},
	Chat = false,
	Player = nil,
	EmoteChat = false,
	Animate = false,
	RandomAnim = false,
	Noclip = false,
	RapePlayer = false,
	TwerkAss = false,
	TwerkAss2 = false,
	RandomEmote = false,
	CopyMovement = false,
	SyncAnimations = false,
	PlayAlways = false,
	FlySpeed = 50,
	InfJump = false,
	ClickTeleport = false,
	SyncEmote = false,
	PlayerSync = nil,
	AnimationSpeedToggle = false,
	CurrentAnimation = "",
	FreezeAnimation = false,
	FreezeEmote = false,
	EmotePrefix = "/em",
	AnimationPrefix = "/a",
	EmoteSpeed = 1,
	AnimationSpeed = 1,
	ReverseSpeed = -1,
	SelectedAnimation = "",
	LastEmote = "",
	Looped = false,
	Reversed = false,
	Time = false,
	TimePosition = 1
}

if isfile and not isfile("Eazvy-Hub/Animations_Settings.txt") and writefile then
	writefile('Eazvy-Hub/Animations_Settings.txt', game:GetService('HttpService'):JSONEncode(getgenv().Settings))
end

function UpdateFile()
	if writefile then
		writefile('Eazvy-Hub/Animations_Settings.txt', game:GetService('HttpService'):JSONEncode(getgenv().Settings))
	end
end

if readfile and isfile("Eazvy-Hub/Animations_Settings.txt") then
	getgenv().Settings = game:GetService('HttpService'):JSONDecode(readfile('Eazvy-Hub/Animations_Settings.txt'))
	if Settings.EmotePrefix and Settings.EmotePrefix == "/e" then
		Settings.EmotePrefix = "/em"
		UpdateFile()
	end
end

local j = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request
local k = game:GetService('HttpService')

local function l()
	local m = {}
	local n = j({
		Url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Desc&limit=100"
	})
	local o = k:JSONDecode(n.Body)
	if o and o.data then
		for p, q in next, o.data do
			if type(q) == "table" and tonumber(q.playing) and tonumber(q.maxPlayers) and q.playing < q.maxPlayers then
				table.insert(m, 1, q.id)
			end
		end
	end
	if #m > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, m[math.random(1, #m)], game.Players.LocalPlayer)
	end
	game:GetService("TeleportService").TeleportInitFailed:Connect(function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, m[math.random(1, #m)], game.Players.LocalPlayer)
	end)
end

function getPlayersByName(r)
	local r, s, t = string.lower(r), #r, {}
	for u, q in pairs(game:GetService('Players'):GetPlayers()) do
		if q.Name ~= game:GetService('Players').LocalPlayer then
			if r:sub(0, 1) == '@' then
				if string.sub(string.lower(q.Name), 1, s - 1) == r:sub(2) then
					return q
				end
			else
				if string.sub(string.lower(q.Name), 1, s) == r or string.sub(string.lower(q.DisplayName), 1, s) == r then
					return q
				end
			end
		end
	end
end

local v = loadstring(game:HttpGet('https://raw.githubusercontent.com/Eazvy/Eazvy-Hub/main/Content/UILibrary.lua'))()

local function w(x, y)
	v:MakeNotification({
		Name = "Animation - Error",
		Content = x .. "\n" .. y,
		Image = "rbxassetid://161551681",
		Time = 4
	})
end

local function z(x, y)
	v:MakeNotification({
		Name = "Animation - Success",
		Content = x .. "\n" .. y,
		Image = "rbxassetid://4914902889",
		Time = 4
	})
end

local function A(x, y, B)
	v:MakeNotification({
		Name = "Animation - Success",
		Content = x .. "\n" .. y,
		Image = "rbxassetid://4914902889",
		Time = B
	})
end

if getgenv().Teleported and game.CoreGui:FindFirstChild("Orion") then
	game.CoreGui.Orion.Enabled = false
	z("Successfully Loaded Animations Script", "Press Q to Toggle UI we've minimized it because you're coming from a different server.")
end

local C = {
	['Fashion'] = 3333331310,
	["Baby Dance"] = 4265725525,
	["Cha-Cha"] = 6862001787,
	['Monkey'] = 3333499508,
	['Shuffle'] = 4349242221,
	["Top Rock"] = 3361276673,
	["Around Town"] = 3303391864,
	["Fancy Feet"] = 3333432454,
	["Hype Dance"] = 3695333486,
	['Bodybuilder'] = 3333387824,
	['Idol'] = 4101966434,
	['Curtsy'] = 4555816777,
	['Happy'] = 4841405708,
	["Quiet Waves"] = 7465981288,
	['Sleep'] = 4686925579,
	["Floss Dance"] = 5917459365,
	['Shy'] = 3337978742,
	['Godlike'] = 3337994105,
	["Hero Landing"] = 5104344710,
	["High Wave"] = 5915690960,
	['Cower'] = 4940563117,
	['Bored'] = 5230599789,
	["Show Dem Wrists   -KSI"] = 7198989668,
	['Celebrate'] = 3338097973,
	['Beckon'] = 5230598276,
	['Haha'] = 3337966527,
	["Lasso Turn - Tai  Verdes"] = 7942896991,
	["Line Dance"] = 4049037604,
	['Shrug'] = 3334392772,
	['Point2'] = 3344585679,
	['Stadium'] = 3338055167,
	['Confused'] = 4940561610,
	['Side to Side'] = 3333136415,
	['Old Town Road  Dance - Lil Nas X"'] = 5937560570,
	['Hello'] = 3344650532,
	['Dolphin Dance'] = 5918726674,
	['Samba'] = 6869766175,
	['Break Dance'] = 5915648917,
	["Hips Poppin' -  Zara Larsson"] = 6797888062,
	['Wake Up Call -  KSI'] = 7199000883,
	['Greatest'] = 3338042785,
	['On The Outside -  Twenty One'] = 7422779536,
	['Boxing Punch -  KSI'] = 7202863182,
	['Sad'] = 4841407203,
	['Flowing Breeze'] = 7465946930,
	['Twirl'] = 3334968680,
	['Jumping Wave'] = 4940564896,
	['HOLIDAY Dance -  Lil Nas X (LNX)'] = 5937558680,
	['Take Me Under -  Zara Larsson'] = 6797890377,
	['Shuffle'] = 4349242221,
	['Dizzy'] = 3361426436,
	["Dancing' Shoes -   Twenty One"] = 7404878500,
	['Fashionable'] = 3333331310,
	['Fast Hands'] = 4265701731,
	['Tree'] = 4049551434,
	['Agree'] = 4841397952,
	['Power Blast'] = 4841403964,
	['Swoosh'] = 3361481910,
	['Jumping Cheer'] = 5895324424,
	['Disagree'] = 4841401869,
	['Rodeo Dance -  Lil Nas X (LNX)'] = 5918728267,
	["It Ain't My Fault -  Zara Larsson"] = 6797891807,
	['Rock On'] = 5915714366,
	['Block Partier'] = 6862022283,
	['Dorky Dance'] = 4212455378,
	['Zombie'] = 4210116953,
	['AOK - Tai Verdes'] = 7942885103,
	['T'] = 3338010159,
	['Cobra Arms - Tai   Verdes'] = 7942890105,
	['Panini Dance - Lil Nas X (LNX)'] = 5915713518,
	['Fishing'] = 3334832150,
	['Robot'] = 3338025566,
	['Around Town'] = 3303391864,
	['Saturday Dance -  Twenty One'] = 7422807549,
	['Top Rock'] = 3361276673,
	['Keeping Time'] = 4555808220,
	['Air Dance'] = 4555782893,
	['Fancy Feet'] = 3333432454,
	['Rock Guitar -  Royal Blood'] = 6532134724,
	["Borock's Rage"] = 3236842542,
	["Ud'zal's Summoning"] = 3303161675,
	['Y'] = 4349285876,
	['Swan Dance'] = 7465997989,
	['Louder'] = 3338083565,
	['Up and Down -  Twenty One'] = 7422797678,
	['Swish'] = 3361481910,
	['Drummer Moves -  Twenty One'] = 7422527690,
	['Sneaky'] = 3334424322,
	['Heisman Pose'] = 3695263073,
	['Jacks'] = 3338066331,
	['Cha-Cha 2'] = 3695322025,
	['BURBERRY LOLA ATTITUDE - NIMBUS'] = 10147821284,
	['BURBERRY LOLA  ATTITUDE - GEM'] = 10147815602,
	['BURBERRY LOLA ATTITUDE - HYDRO'] = 10147823318,
	['BURBERRY LOLA ATTITUDE - BLOOM'] = 10147817997,
	['Superhero Reveal'] = 3695373233,
	['Air Guitar'] = 3695300085,
	['Dismissive Wave'] = 3333272779,
	['Country Line  Dance - Lil Nas X'] = 5915712534,
	['Salute'] = 3333474484,
	['Applaud'] = 5915693819,
	['Get Out'] = 3333272779,
	['Hwaiting (화이팅)'] = 9527885267,
	['Annyeong (안녕)'] = 9527883498,
	['Bunny Hop'] = 4641985101,
	['Sandwich Dance'] = 4406555273,
	['Hyperfast  5G Dance Move'] = 9408617181,
	['Victory - 24kGoldn'] = 9178377686,
	['Tantrum'] = 5104341999,
	['Rock Star - Royal Blood'] = 10714400171,
	['Drum Solo - Royal Blood'] = 6532839007,
	['Drum Master - Royal Blood'] = 6531483720,
	['High Hands'] = 9710985298,
	['Tilt'] = 3334538554,
	['Gashina - SUNMI'] = 9527886709,
	['Chicken Dance'] = 4841399916,
	["You can't sit with us - Sunmi"] = 9983520970,
	["Frosty Flair - Tommy Hilfiger"] = 10214311282,
	["Floor Rock Freeze - Tommy Hilfiger"] = 10214314957,
	['Boom Boom Clap - George Ezra'] = 10370346995,
	['Cartwheel - George Ezra'] = 10370351535,
	['Chill Vibes - George Ezra'] = 10370353969,
	['Sidekicks - George Ezra'] = 10370362157,
	['The Conductor - George Ezra'] = 10370359115,
	['Super Charge'] = 10478338114,
	['Swag Walk'] = 10478341260,
	['Mean Mug - Tommy Hilfiger'] = 10214317325,
	['V Pose - Tommy Hilfiger'] = 10214319518,
	['Uprise - Tommy Hilfiger'] = 10275008655,
	['2 Baddies Dance Move - NCT 127'] = 12259828678,
	['Kick It Dance Move - NCT 127'] = 12259826609,
	['Sticker Dance Move - NCT 127'] = 12259825026,
	['Elton John - Rock Out'] = 11753474067,
	['Elton John - Heart Skip'] = 11309255148,
	['Elton John - Still Standing'] = 11444443576,
	['Elton John - Elevate'] = 11394033602,
	['Elton John - Cat Man'] = 11444441914,
	['Elton John - Piano Jump'] = 11453082181,
	['Alo Yoga Pose - Triangle'] = 12507084541,
	['Alo Yoga Pose - Warrior II'] = 12507083048,
	['Alo Yoga Pose - Lotus Position'] = 12507085924,
	['Alo Yoga Pose - Warrior II'] = 12507083048,
	['Alo Yoga Pose - Triangle'] = 12507084541,
	['TWICE-Moonlight-Sunrise'] = 12714233242,
	['TWICE-Set-Me-Free-Dance-1'] = 12714228341,
	['TWICE-Set-Me-Free-Dance-2'] = 12714231087,
	['Ay-Yo-Dance-Move-NCT-127'] = 12804157977,
	['TWICE-The-Feels'] = 12874447851,
	['Zombie'] = 10714089137,
	['Rise-Above-The-Chainsmokers'] = 12992262118,
	['TWICE-What-Is-Love'] = 13327655243,
	['Man-City-Bicycle-Kick'] = 13421057998,
	['TWICE-Fancy'] = 13520524517,
	['TWICE Pop by Nayeon'] = 13768941455,
	['Tommy - Archer'] = 13823324057,
	['TWICE-Pop-by-Nayeon'] = 13768941455,
	['Man City Backflip'] = 13694100677,
	['Man-City-Scorpion-Kick'] = 13694096724,
	['Arm Twist'] = 10713968716,
	['Tommy - Archer'] = 13823324057,
	['YUNGBLUD – HIGH KICK'] = 14022936101,
	['TWICE Like Ooh-Ahh'] = 14123781004,
	['Baby Queen - Air Guitar & Knee Slide'] = 14352335202,
	['Baby Queen - Dramatic Bow'] = 14352337694,
	['Baby Queen - Face Frame'] = 14352340648,
	['Baby Queen - Bouncy Twirl'] = 14352343065,
	['Baby Queen - Strut'] = 14352362059,
	['BLACKPINK Pink Venom - Get em Get em Get em'] = 14548619594,
	['BLACKPINK Pink Venom - I Bring the Pain Like…'] = 14548620495,
	['BLACKPINK Pink Venom - Straight to Ya Dome'] = 14548621256,
	['TWICE LIKEY'] = 14899979575,
	['TWICE Feel Special'] = 14899980745,
	['BLACKPINK Shut Down - Part 1'] = 14901306096,
	['BLACKPINK Shut Down - Part 2'] = 14901308987,
	["Bone Chillin' Bop"] = 15122972413,
	['Paris Hilton - Sliving For The Groove'] = 15392759696,
	['Paris Hilton - Iconic IT-Grrrl'] = 15392756794,
	['Paris Hilton - Checking My Angles'] = 15392752812,
	['BLACKPINK JISOO Flower'] = 15439354020,
	['BLACKPINK JENNIE You and Me'] = 15439356296,
	['Rock n Roll'] = 15505458452,
	['Air Guitar'] = 15505454268,
	['Victory Dance'] = 15505456446,
	['Flex Walk'] = 15505459811,
	['Olivia Rodrigo Head Bop'] = 15517864808,
	['Olivia Rodrigo good 4 u'] = 15517862739,
	['Olivia Rodrigo Fall Back to Float'] = 15549124879,
	["Nicki Minaj That's That Super Bass"] = 15571446961,
	['Nicki Minaj Boom Boom Boom'] = 15571448688,
	['Nicki Minaj Anaconda'] = 15571450952,
	['Nicki Minaj Starships'] = 15571453761,
	['Yungblud Happier Jump'] = 15609995579,
	['Festive Dance'] = 15679621440,
	['BLACKPINK LISA Money'] = 15679623052,
	['BLACKPINK ROSÉ On The Ground'] = 15679624464,
	['Imagine Dragons - "Bones" Dance'] = 15689279687,
	['GloRilla - "Tomorrow" Dance'] = 15689278184,
	['d4vd - Backflip'] = 15693621070,
	['ericdoa - dance'] = 15698402762,
	['Cuco - Levitate'] = 15698404340,
	['Mean Girls Dance Break'] = 15963314052,
	['Paris Hilton Sanasa'] = 16126469463,
	['BLACKPINK Ice Cream'] = 16181797368,
	['BLACKPINK Kill This Love'] = 16181798319,
	['TWICE I GOT YOU part 1'] = 16215030041,
	['TWICE I GOT YOU part 2'] = 16256203246,
	["Dave's Spin Move - Glass Animals"] = 16272432203,
	['Sol de Janeiro - Samba'] = 16270690701,
	['Beauty Touchdown'] = 16302968986,
	['Skadoosh Emote - Kung Fu Panda 4'] = 16371217304,
	['Jawny - Stomp'] = 16392075853,
	['Mae Stephens - Piano Hands'] = 16553163212,
	['BLACKPINK Boombayah Emote'] = 16553164850,
	['BLACKPINK DDU-DU DDU-DU'] = 16553170471,
	['HIPMOTION - Amaarae'] = 16572740012,
	['Mae Stephens – Arm Wave'] = 16584481352,
	['Wanna play?'] = 16646423316,
	['BLACKPINK-How-You-Like-That'] = 16874470507,
	['BLACKPINK - Lovesick Girls'] = 16874472321,
	['Mini Kong'] = 17000021306
}

local D = {
	Emotes = {
		Weight = 9,
		Weight2 = 1
	},
	Stylish = {
		Idle = 616136790,
		Idle2 = 616138447,
		Idle3 = 886888594,
		Walk = 616146177,
		Run = 616140816,
		Jump = 616139451,
		Climb = 616133594,
		Fall = 616134815,
		Swim = 616143378,
		SwimIdle = 616144772,
		Weight = 9,
		Weight2 = 1
	},
	Zombie = {
		Idle = 616158929,
		Idle2 = 616160636,
		Idle3 = 885545458,
		Walk = 616168032,
		Run = 616163682,
		Jump = 616161997,
		Climb = 616156119,
		Fall = 616157476,
		Swim = 616165109,
		SwimIdle = 616166655,
		Weight = 9,
		Weight2 = 1
	},
	Robot = {
		Idle = 616088211,
		Idle2 = 616089559,
		Idle3 = 885531463,
		Walk = 616095330,
		Run = 616091570,
		Jump = 616090535,
		Climb = 616086039,
		Fall = 616087089,
		Swim = 616092998,
		SwimIdle = 616094091,
		Weight = 9,
		Weight2 = 1
	},
	Toy = {
		Idle = 782841498,
		Idle2 = 782845736,
		Idle3 = 980952228,
		Walk = 782843345,
		Run = 782842708,
		Jump = 782847020,
		Climb = 782843869,
		Fall = 782846423,
		Swim = 782844582,
		SwimIdle = 782845186,
		Weight = 9,
		Weight2 = 1
	},
	Cartoony = {
		Idle = 742637544,
		Idle2 = 742638445,
		Idle3 = 885477856,
		Walk = 742640026,
		Run = 742638842,
		Jump = 742637942,
		Climb = 742636889,
		Fall = 742637151,
		Swim = 742639220,
		SwimIdle = 742639812,
		Weight = 9,
		Weight2 = 1
	},
	Superhero = {
		Idle = 616111295,
		Idle2 = 616113536,
		Idle3 = 885535855,
		Walk = 616122287,
		Run = 616117076,
		Jump = 616115533,
		Climb = 616104706,
		Fall = 616108001,
		Swim = 616119360,
		SwimIdle = 616120861,
		Weight = 9,
		Weight2 = 1
	},
	Mage = {
		Idle = 707742142,
		Idle2 = 707855907,
		Idle3 = 885508740,
		Walk = 707897309,
		Run = 707861613,
		Jump = 707853694,
		Climb = 707826056,
		Fall = 707829716,
		Swim = 707876443,
		SwimIdle = 707894699,
		Weight = 9,
		Weight2 = 1
	},
	Levitation = {
		Idle = 616006778,
		Idle2 = 616008087,
		Idle3 = 886862142,
		Walk = 616013216,
		Run = 616010382,
		Jump = 616008936,
		Climb = 616003713,
		Fall = 616005863,
		Swim = 616011509,
		SwimIdle = 616012453,
		Weight = 9,
		Weight2 = 1
	},
	Vampire = {
		Idle = 1083445855,
		Idle2 = 1083450166,
		Idle3 = 1088037547,
		Walk = 1083473930,
		Run = 1083462077,
		Jump = 1083455352,
		Climb = 1083439238,
		Fall = 1083443587,
		Swim = 1083464683,
		SwimIdle = 1083467779,
		Weight = 9,
		Weight2 = 1
	},
	Elder = {
		Idle = 845397899,
		Idle2 = 845400520,
		Idle3 = 901160519,
		Walk = 845403856,
		Run = 845386501,
		Jump = 845398858,
		Climb = 845392038,
		Fall = 845396048,
		Swim = 845401742,
		SwimIdle = 845403127,
		Weight = 9,
		Weight2 = 1
	},
	Werewolf = {
		Idle = 1083195517,
		Idle2 = 1083214717,
		Idle3 = 1099492820,
		Walk = 1083178339,
		Run = 1083216690,
		Jump = 1083218792,
		Climb = 1083182000,
		Fall = 1083189019,
		Swim = 1083222527,
		SwimIdle = 1083225406,
		Weight = 9,
		Weight2 = 1
	},
	Knight = {
		Idle = 657595757,
		Idle2 = 657568135,
		Idle3 = 885499184,
		Walk = 657552124,
		Run = 657564596,
		Jump = 658409194,
		Climb = 658360781,
		Fall = 657600338,
		Swim = 657560551,
		SwimIdle = 657557095,
		Weight = 9,
		Weight2 = 1
	},
	Bold = {
		Idle = 16738333868,
		Idle2 = 16738334710,
		Idle3 = 16738335517,
		Walk = 16738340646,
		Run = 16738337225,
		Jump = 16738336650,
		Climb = 16738332169,
		Fall = 16738333171,
		Swim = 16738339158,
		SwimIdle = 16738339817,
		Weight = 9,
		Weight2 = 1
	},
	Astronaut = {
		Idle = 891621366,
		Idle2 = 891633237,
		Idle3 = 1047759695,
		Walk = 891667138,
		Run = 891636393,
		Jump = 891627522,
		Climb = 891609353,
		Fall = 891617961,
		Swim = 891639666,
		SwimIdle = 891663592,
		Weight = 9,
		Weight2 = 1
	},
	Bubbly = {
		Idle = 910004836,
		Idle2 = 910009958,
		Idle3 = 1018536639,
		Walk = 910034870,
		Run = 910025107,
		Jump = 910016857,
		Climb = 909997997,
		Fall = 910001910,
		Swim = 910028158,
		SwimIdle = 910030921,
		Weight = 9,
		Weight2 = 1
	},
	Pirate = {
		Idle = 750781874,
		Idle2 = 750782770,
		Idle3 = 885515365,
		Walk = 750785693,
		Run = 750783738,
		Jump = 750782230,
		Climb = 750779899,
		Fall = 750780242,
		Swim = 750784579,
		SwimIdle = 750785176,
		Weight = 9,
		Weight2 = 1
	},
	Rthro = {
		Idle = 2510196951,
		Idle2 = 2510197257,
		Idle3 = 3711062489,
		Walk = 2510202577,
		Run = 2510198475,
		Jump = 2510197830,
		Climb = 2510192778,
		Fall = 2510195892,
		Swim = 2510199791,
		SwimIdle = 2510201162,
		Weight = 9,
		Weight2 = 1
	},
	Ninja = {
		Idle = 656117400,
		Idle2 = 656118341,
		Idle3 = 886742569,
		Walk = 656121766,
		Run = 656118852,
		Jump = 656117878,
		Climb = 656114359,
		Fall = 656115606,
		Swim = 656119721,
		SwimIdle = 656121397,
		Weight = 9,
		Weight2 = 1
	},
	Oldschool = {
		Idle = 5319828216,
		Idle2 = 5319831086,
		Idle3 = 5392107832,
		Walk = 5319847204,
		Run = 5319844329,
		Jump = 5319841935,
		Climb = 5319816685,
		Fall = 5319839762,
		Swim = 5319850266,
		SwimIdle = 5319852613,
		Weight = 9,
		Weight2 = 1
	},
	Princess = {
		Idle = 941003647,
		Idle2 = 941013098,
		Idle3 = 1159195712,
		Walk = 941028902,
		Run = 941015281,
		Jump = 0941008832,
		Climb = 940996062,
		Fall = 941000007,
		Swim = 941018893,
		SwimIdle = 941025398,
		Weight = 9,
		Weight2 = 1
	},
	Confident = {
		Idle = 1069977950,
		Idle2 = 1069987858,
		Idle3 = 1116160740,
		Walk = 1070017263,
		Run = 1070001516,
		Jump = 1069984524,
		Climb = 1069946257,
		Fall = 1069973677,
		Swim = 1070009914,
		SwimIdle = 1070012133,
		Weight = 9,
		Weight2 = 1
	},
	Popstar = {
		Idle = 1212900985,
		Idle2 = 1150842221,
		Idle3 = 1239733474,
		Walk = 1212980338,
		Run = 1212980348,
		Jump = 1212954642,
		Climb = 1213044953,
		Fall = 1212900995,
		Swim = 1212852603,
		SwimIdle = 1212998578,
		Weight = 9,
		Weight2 = 1
	},
	Patrol = {
		Idle = 1149612882,
		Idle2 = 1150842221,
		Idle3 = 1159573567,
		Walk = 1151231493,
		Run = 1150967949,
		Jump = 1150944216,
		Climb = 1148811837,
		Fall = 1148863382,
		Swim = 1151204998,
		SwimIdle = 1151221899,
		Weight = 9,
		Weight2 = 1
	},
	Sneaky = {
		Idle = 1132473842,
		Idle2 = 1132477671,
		Idle3 = "None",
		Walk = 1132510133,
		Run = 1132494274,
		Jump = 1132489853,
		Climb = 1132461372,
		Fall = 1132469004,
		Swim = 1132500520,
		SwimIdle = 1132506407,
		Weight = 9,
		Weight2 = 1
	},
	Cowboy = {
		Idle = 1014390418,
		Idle2 = 1014398616,
		Idle3 = 1159487651,
		Walk = 1014421541,
		Run = 1014401683,
		Jump = 1014394726,
		Climb = 1014380606,
		Fall = 1014384571,
		Swim = 1014406523,
		SwimIdle = 1014411816,
		Weight = 9,
		Weight2 = 1
	},
	Ghost = {
		Idle = 616006778,
		Idle2 = 616008087,
		Idle3 = 616008087,
		Walk = 616013216,
		Run = 616013216,
		Jump = 616008936,
		Climb = 0,
		Fall = 616005863,
		Swim = 616011509,
		SwimIdle = 616012453,
		Weight = 9,
		Weight2 = 1
	},
	['Mr. Toilet'] = {
		Idle = 4417977954,
		Idle2 = 4417978624,
		Idle3 = 4441285342,
		Walk = 2510202577,
		Run = 4417979645,
		Jump = 2510197830,
		Climb = 2510192778,
		Fall = 2510195892,
		Swim = 2510199791,
		SwimIdle = 2510201162,
		Weight = 9,
		Weight2 = 1
	},
	Udzal = {
		Idle = 3303162274,
		Idle2 = 3303162549,
		Idle3 = 3710161342,
		Walk = 3303162967,
		Run = 3236836670,
		Jump = 2510197830,
		Climb = 2510192778,
		Fall = 2510195892,
		Swim = 2510199791,
		SwimIdle = 2510201162,
		Weight = 9,
		Weight2 = 1
	},
	['Oinan Thickhoof'] = {
		Idle = 657595757,
		Idle2 = 657568135,
		Idle3 = 885499184,
		Walk = 2510202577,
		Run = 3236836670,
		Jump = 2510197830,
		Climb = 2510192778,
		Fall = 2510195892,
		Swim = 2510199791,
		SwimIdle = 2510201162,
		Weight = 9,
		Weight2 = 1
	},
	Borock = {
		Idle = 3293641938,
		Idle2 = 3293642554,
		Idle3 = 3710131919,
		Walk = 2510202577,
		Run = 3236836670,
		Jump = 2510197830,
		Climb = 2510192778,
		Fall = 2510195892,
		Swim = 2510199791,
		SwimIdle = 2510201162,
		Weight = 9,
		Weight2 = 1
	},
	['Blocky Mech'] = {
		Idle = 4417977954,
		Idle2 = 4417978624,
		Idle3 = 4441285342,
		Walk = 2510202577,
		Run = 4417979645,
		Jump = 2510197830,
		Climb = 2510192778,
		Fall = 2510195892,
		Swim = 2510199791,
		SwimIdle = 2510201162,
		Weight = 9,
		Weight2 = 1
	},
	['Stylized Female'] = {
		Idle = 4708191566,
		Idle2 = 4708192150,
		Idle3 = 121221,
		Walk = 4708193840,
		Run = 4708192705,
		Jump = 4708188025,
		Climb = 4708184253,
		Fall = 4708186162,
		Swim = 4708189360,
		SwimIdle = 4708190607,
		Weight = 9,
		Weight2 = 1
	},
	R15 = {
		Idle = 4211217646,
		Idle2 = 4211218409,
		Idle3 = "None",
		Walk = 4211223236,
		Run = 4211220381,
		Jump = 4211219390,
		Climb = 4211214992,
		Fall = 4211216152,
		Swim = 4211221314,
		SwimIdle = 4374694239,
		Weight = 9,
		Weight2 = 1
	},
	Mocap = {
		Idle = 913367814,
		Idle2 = 913373430,
		Idle3 = "None",
		Walk = 913402848,
		Run = 913376220,
		Jump = 913370268,
		Climb = 913362637,
		Fall = 913365531,
		Swim = 913384386,
		SwimIdle = 913389285,
		Weight = 9,
		Weight2 = 1
	}
}
local E = {
	"/e dance3",
	"/e dance2",
	"/e dance",
	"/e cheer",
	"/e wave",
	"/e laugh",
	"/e point"
}
local function F(string)
	if table.find(E, string) then
		return true
	else
		return false
	end
end
local G = {
	['Balloon Float'] = {
		Emote = 148840371,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Idle'] = {
		Emote = 180435571,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Arm Turbine'] = {
		Emote = 259438880,
		Speed = 1.5,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Floating Head'] = {
		Emote = 121572214,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Insane Rotation'] = {
		Emote = 121572214,
		Speed = 99,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Scream'] = {
		Emote = 180611870,
		Speed = 1.5,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Party Time'] = {
		Emote = 33796059,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Chop'] = {
		Emote = 33169596,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Weird Sway'] = {
		Emote = 248336677,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Goal!'] = {
		Emote = 28488254,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Open'] = {
		Emote = 582855105,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Rotation'] = {
		Emote = 136801964,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Spin'] = {
		Emote = 188632011,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Weird Float'] = {
		Emote = 248336459,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Pinch Nose'] = {
		Emote = 30235165,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Cry'] = {
		Emote = 180612465,
		Speed = 1.5,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Penguin Slide'] = {
		Emote = 282574440,
		Speed = 0,
		Time = 0,
		Weight = 1,
		Loop = true,
		R6 = true,
		Priority = 2
	},
	['Zombie Arms'] = {
		Emote = 183294396,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Flying'] = {
		Emote = 46196309,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Stab'] = {
		Emote = 66703241,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Dance'] = {
		Emote = 35654637,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Random'] = {
		Emote = 48977286,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Hmmm'] = {
		Emote = 33855276,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Sword'] = {
		Emote = 35978879,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Arms Out'] = {
		Emote = 27432691,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Kick'] = {
		Emote = 45737360,
		Speed = 1,
		Time = 0, Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Insane Legs'] = {
		Emote = 87986341,
		Speed = 99,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Head Detach'] = {
		Emote = 35154961,
		Speed = 0,
		Time = 3,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Moon Walk'] = {
		Emote = 30196114,
		Speed = 0,
		Time = 3,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Crouch'] = {
		Emote = 287325678,
		Speed = 0,
		Time = 3,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Beat Box'] = {
		Emote = 45504977,
		Speed = 0,
		Time = 3,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Big Guns'] = {
		Emote = 161268368,
		Speed = 0,
		Time = 3,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Bigger Guns'] = {
		Emote = 225975820,
		Speed = 0,
		Time = 3,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Charleston'] = {
		Emote = 429703734,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Moon Dance'] = {
		Emote = 27789359,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Roar'] = {
		Emote = 163209885,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Weird Pose'] = {
		Emote = 248336163,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Spin Dance 2'] = {
		Emote = 186934910,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Bow Down'] = {
		Emote = 204292303,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Sword Slam'] = {
		Emote = 204295235,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Glitch Levitate'] = {
		Emote = 313762630,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Full Swing'] = {
		Emote = 218504594,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Full Punch'] = {
		Emote = 204062532,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Faint'] = {
		Emote = 181526230,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Floor Faint'] = {
		Emote = 181525546,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Crouch'] = {
		Emote = 182724289,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Jumping Jacks'] = {
		Emote = 429681631,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Spin Dance'] = {
		Emote = 429730430,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Arm Detach'] = {
		Emote = 33169583,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Mega Insane'] = {
		Emote = 184574340,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Dino Walk'] = {
		Emote = 204328711,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Tilt Head'] = {
		Emote = 283545583,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Dab'] = {
		Emote = 183412246,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Float Sit'] = {
		Emote = 179224234,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Clone Illusion'] = {
		Emote = 215384594,
		Speed = 1e7,
		Time = .5,
		Weight = 1,
		Loop = true,
		Priority = 2
	},
	['Hero Jump'] = {
		Emote = 184574340,
		Speed = 1,
		Time = 0,
		Weight = 1,
		Loop = true,
		Priority = 2
	}
}
local H = {}
for p, q in pairs(G) do
	table.insert(H, p)
end
local I = {}
for p, q in pairs(D) do
	if p ~= "Weight" and p ~= "Weight2" and p ~= "Custom" then
		table.insert(I, p)
		i = i + 1
	end
end
local J = {}
for p, q in pairs(C) do
	table.insert(J, p)
	h = h + 1
end
A("Eazvy Emotes/Animations", "Loaded " .. i .. " Animations and " .. h .. " Emotes!", 9)
table.sort(I, function(K, L)
	return K:lower() < L:lower()
end)
table.sort(J, function(K, L)
	return K:lower() < L:lower()
end)
table.sort(H, function(K, L)
	return K:lower() < L:lower()
end)
local function M()
	do
		repeat
			wait()
		until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator")
		local N = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
		for p, q in ipairs(N:GetPlayingAnimationTracks()) do
			q:Stop()
		end
	end
end
local function O()
	do
		repeat
			wait()
		until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator")
		local N = game:GetService("Players").LocalPlayer.Character:WaitForChild("Animate")
		N.Disabled = true
		for p, q in ipairs(game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
			q:AdjustSpeed(Settings.AnimationSpeed)
			q:Stop()
		end
		N.Disabled = false
	end
end
local function P(Q, R, S, T, U, V, W, X, Y, Z, , a0)
	do
		repeat
			wait()
		until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate")
		local a = game:GetService("Players").LocalPlayer.Character.Animate
		if a:FindFirstChild("idle") then
			a.idle.Animation1.AnimationId = b .. Q
			a.idle.Animation1.Weight.Value = tostring()
			a.idle.Animation2.Weight.Value = tostring(a0)
			a.idle.Animation2.AnimationId = b .. R
		end
		if S and a:FindFirstChild("pose") then
			a.pose:FindFirstChildOfClass("Animation").AnimationId = b .. S
		end
		a.walk:FindFirstChildOfClass("Animation").AnimationId = b .. T
		a.run:FindFirstChildOfClass("Animation").AnimationId = b .. U
		a.jump:FindFirstChildOfClass("Animation").AnimationId = b .. V
		a.climb:FindFirstChildOfClass("Animation").AnimationId = b .. W
		a.fall:FindFirstChildOfClass("Animation").AnimationId = b .. X
		if a:FindFirstChild("swim") then
			a.swim:FindFirstChildOfClass("Animation").AnimationId = b .. Y
			a.swimidle:FindFirstChildOfClass("Animation").AnimationId = b .. Z
		end
	end
end
local function a1(a2, a3)
	repeat
		wait()
	until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate")
	local a = game:GetService("Players").LocalPlayer.Character.Animate
	if a2:match("idle") then
		if a:FindFirstChild("pose") then
			a.pose:FindFirstChildOfClass("Animation").AnimationId = b .. a3
		end
	end
	if a2 == "idle1" then
		a.idle.Animation1.AnimationId = b .. a3
	elseif a2 == "idle2" then
		a.idle.Animation2.AnimationId = b .. a3
	elseif a2:match("dance") then
		for u, q in pairs(a[a2]:GetChildren()) do
			if q:IsA("Animation") then
				q.AnimationId = b .. a3
			end
		end
	else
		local a4
		for u, q in pairs(a:GetChildren()) do
			if q.Name == a2 then
				a4 = q
				break
			end
		end
		if a4 then
			a4:FindFirstChildOfClass("Animation").AnimationId = b .. a3
		end
	end
	O()
end
local function a5(a3)
	local a6 = Instance.new("Animation")
	a6.AnimationId = "rbxassetid://" .. a3
	_G.LoadAnim = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(a6)
	_G.LoadAnim.Priority = Enum.AnimationPriority.Idle
	if not Settings.PlayAlways then
		_G.LoadAnim:Stop()
	end
	if Settings.Reversed then
		_G.LoadAnim:Play(0)
		_G.LoadAnim:AdjustSpeed(Settings.ReverseSpeed)
	else
		_G.LoadAnim:Play(0)
		_G.LoadAnim:AdjustSpeed(Settings.EmoteSpeed)
	end
	if Settings.Looped then
		_G.LoadAnim.Looped = Settings.Looped
	end
	if Settings.Time then
		_G.LoadAnim.TimePosition = _G.LoadAnim.TimePosition - Settings.TimePosition
	end
	if not game:GetService("Players").LocalPlayer.Character.Animate.Disabled then
		game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
	end
end
local function a7()
	local a8 = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if a8 and a8.RigType == Enum.HumanoidRigType.R15 then
		return "R15"
	else
		return "R6"
	end
end
local function a9(aa)
	a5(C[aa])
end
local function ab(ac)
	for p, q in pairs(D) do
		lower_string = string.lower(p)
		lower_emote = string.lower(ac)
		if string.find(p, ac) or string.find(lower_string, lower_emote) then
			return p
		end
	end
end
local function ad(ac)
	local ae = {}
	for p, q in pairs(C) do
		upper_string = string.upper(p)
		upper_emote = string.upper(ac)
		if upper_string == upper_emote then
			if not table.find(ae, p) then
				table.insert(ae, p)
			end
		end
	end
	for p, q in pairs(C) do
		lower_string = string.lower(p)
		lower_emote = string.lower(ac)
		if string.find(p, ac) or string.find(lower_string, lower_emote) then
			if not table.find(ae, p) then
				table.insert(ae, p)
			end
		end
	end
	return ae
end
local function af(ac)
	for p, q in pairs(C) do
		upper_string = string.upper(p)
		upper_emote = string.upper(ac)
		if upper_string == upper_emote then
			return p
		end
	end
	for p, q in pairs(C) do
		lower_string = string.lower(p)
		lower_emote = string.lower(ac)
		if string.find(p, ac) or string.find(lower_string, lower_emote) then
			return p
		end
	end
end
if Settings.SelectedAnimation and Settings.SelectedAnimation ~= "" then
	repeat
		wait()
	until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate")
	if Settings.SelectedAnimation == "Custom" and a7() == "R15" then
		M()
		P(Settings.Custom.Idle, Settings.Custom.Idle2, Settings.Custom.Idle3, Settings.Custom.Walk, Settings.Custom.Run, Settings.Custom.Jump, Settings.Custom.Climb, Settings.Custom.Fall, Settings.Custom.Swim, Settings.Custom.SwimIdle, Settings.Custom.Weight, Settings.Custom.Weight2)
		O()
		local a8 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
		local ag = a8:GetPlayingAnimationTracks()
		for u, q in pairs(ag) do
			q:AdjustSpeed(Settings.AnimationSpeed)
		end
	elseif a7() == "R15" then
		M()
		P(D[Settings.SelectedAnimation].Idle, D[Settings.SelectedAnimation].Idle2, D[Settings.SelectedAnimation].Idle3, D[Settings.SelectedAnimation].Walk, D[Settings.SelectedAnimation].Run, D[Settings.SelectedAnimation].Jump, D[Settings.SelectedAnimation].Climb, D[Settings.SelectedAnimation].Fall, D[Settings.SelectedAnimation].Swim, D[Settings.SelectedAnimation].SwimIdle, D[Settings.SelectedAnimation].Weight, D[Settings.SelectedAnimation].Weight2)
		O()
		local a8 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
		local ag = a8:GetPlayingAnimationTracks()
		for u, q in pairs(ag) do
			q:AdjustSpeed(Settings.AnimationSpeed)
		end
	end
end

game.TextChatService.OnIncomingMessage = function(x)
	local ah = tostring(x.TextSource)
	local ai = tostring(x.Text)
	if ah == game.Players.LocalPlayer.Name and Settings.Chat and ai:match(Settings.EmotePrefix) or ah == game.Players.LocalPlayer.Name and Settings.Animate and ai:match(Settings.AnimationPrefix) then
		x.Status = Enum.TextChatMessageStatus.InvalidTextChannelPermissions
	end
end

local function aj()
	if _G.LoadAnim and _G.LoadAnim.TimePosition then
		return tostring(math.floor(_G.LoadAnim.TimePosition))
	end
	return "0"
end

local function ak()
	if _G.LoadAnim and _G.LoadAnim.Looped then
		return tostring(_G.LoadAnim.Looped)
	end
	return "false"
end

if game.TextChatService:FindFirstChild("TextChannels") then
	game.TextChatService.TextChannels.RBXGeneral.MessageReceived:Connect(function(x)
		local ah = tostring(x.TextSource)
		local ai = tostring(x.Text)
		if ah == game.Players.LocalPlayer.Name and Settings.Chat and ai:match(Settings.EmotePrefix) then
			local al = string.gsub(ai, Settings.EmotePrefix .. " ", "")
			local am = af(al)
			if Settings.Chat and am then
				Settings.LastEmote = am
				_G.LoadAnim:Stop()
				O()
				a9(am)
				Status:Set("Selected Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
				return
			end
		end
		if ah == game.Players.LocalPlayer.Name and Settings.Animate and ai:match(Settings.AnimationPrefix) then
			local al = string.gsub(ai, Settings.AnimationPrefix .. " ", "")
			local an = ab(al)
			if Settings.Animate and an then
				P(D[an].Idle, D[an].Idle2, D[an].Idle3, D[an].Walk, D[an].Run, D[an].Jump, D[an].Climb, D[an].Fall, D[an].Swim, D[an].SwimIdle, D[an].Weight, D[an].Weight2)
				AStatus:Set("Current Animation: " .. Settings.SelectedAnimation or "" .. " // Speed: " .. tostring(Settings.AnimationSpeed or "") .. " // Frozen: " .. Settings.FreezeAnimation)
				O()
				return
			end
		end
	end)
end

local ao = v:MakeWindow({Name = "Eazvy Hub // Animations // Emotes", HidePremium = true, SaveConfig = false, ConfigFolder = "EazvyHub", IntroEnabled = false, IntroText = "Eazvy Hub - Animations/Emotes", IntroIcon = "rbxassetid://10932910166", Icon = "rbxassetid://4914902889"})

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(ap)
	if ap == Enum.TeleportState.Started and queue_on_teleport then
		queue_on_teleport("repeat task.wait() until game:IsLoaded() getgenv().Teleported = true")
	end
end)

local aq = ao:MakeTab({Name = "Main", Icon = "rbxassetid://10507357657", PremiumOnly = false})
local ar = ao:MakeTab({Name = "LocalPlayer", Icon = "rbxassetid://3609827161", PremiumOnly = false})

local as
local AStatus
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
	as = ao:MakeTab({Name = "Animations", Icon = "rbxassetid://9405928221", PremiumOnly = false})
	AStatus = as:AddParagraph("Animation Information", "Selected Animation: " .. Settings.SelectedAnimation or "" .. " // Speed: " .. tostring(Settings.AnimationSpeed or "") .. " // Frozen: " .. Settings.FreezeAnimation)
end

ar:AddSlider({Name = "Walkspeed", Min = 16, Max = 250, Default = 16, Color = Color3.fromRGB(0, 128, 255), Increment = 1, ValueName = "", Callback = function(at)
	game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = at
end})

ar:AddSlider({Name = "Jumppower", Min = 50, Max = 550, Default = 50, Color = Color3.fromRGB(0, 191, 255), Increment = 1, ValueName = "", Callback = function(at)
	game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = at
end})

ar:AddSlider({Name = "Gravity", Min = 196, Max = 250, Default = 196, Color = Color3.fromRGB(0, 128, 255), Increment = 1, ValueName = "", Callback = function(at)
	if at > 196 then
		game:GetService("Workspace").Gravity = -at
	else
		game:GetService("Workspace").Gravity = at
	end
end})

local au = 2.1
if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
	au = game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight
end

ar:AddSlider({Name = "Hipheight", Min = au, Max = 300, Default = 2.1, Color = Color3.fromRGB(0, 191, 255), Increment = 1, ValueName = "", Callback = function(at)
	game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight = at
end})

ar:AddSlider({Name = "Fly Speed", Min = 1, Max = 500, Default = 50, Color = Color3.fromRGB(0, 128, 255), Increment = 1, ValueName = "", Callback = function(at)
	Settings.FlySpeed = at
end})

ar:AddSlider({Name = "FOV", Min = 70, Max = 120, Default = 70, Color = Color3.fromRGB(0, 128, 255), Increment = 1, ValueName = "", Callback = function(at)
	game:GetService("Workspace").CurrentCamera.FieldOfView = at
end})

if setfpscap then
	ar:AddSlider({Name = "FPS", Min = 1, Max = 240, Default = 60, Color = Color3.fromRGB(0, 128, 255), Increment = 1, ValueName = "", Callback = function(at)
		setfpscap(at)
	end})
end

local av
local aw
local ax
local ay
local az
local aA
local aB = Client
local aC = {W = false, S = false, A = false, D = false, Moving = false}

local aD = function()
	if not game:GetService("Players").LocalPlayer.Character or not game:GetService("Players").LocalPlayer.Character.Head or aA then
		return
	end
	av = game:GetService("Players").LocalPlayer.Character
	aw = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	aw.PlatformStand = true
	az = workspace:WaitForChild('Camera')
	ax = Instance.new("BodyVelocity")
	ay = Instance.new("BodyAngularVelocity")
	ax.Velocity, ax.MaxForce, ax.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
	ay.AngularVelocity, ay.MaxTorque, ay.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
	ax.Parent = av.Head
	ay.Parent = av.Head
	aA = true
	aw.Died:connect(function()
		aA = false
	end)
end

local aE = function()
	if not game:GetService("Players").LocalPlayer.Character or not aA then
		return
	end
	game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
	ax:Destroy()
	ay:Destroy()
	aA = false
end

game:GetService("UserInputService").InputBegan:connect(function(aF, aG)
	if aF.UserInputType == Enum.UserInputType.MouseButton1 and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and Settings.ClickTeleport then
		game.Players.LocalPlayer.Character:MoveTo(game.Players.LocalPlayer:GetMouse().Hit.p)
	end
	if aG then
		return
	end
	for p, aH in pairs(aC) do
		if p ~= "Moving" and aF.KeyCode == Enum.KeyCode[p] then
			aC[p] = true
			aC.Moving = true
		end
	end
end)

game:GetService("UserInputService").InputEnded:connect(function(aF, aG)
	if aG then
		return
	end
	local K = false
	for p, aH in pairs(aC) do
		if p ~= "Moving" then
			if aF.KeyCode == Enum.KeyCode[p] then
				aC[p] = false
			end
			if aC[p] then
				K = true
			end
		end
	end
	aC.Moving = K
end)

local aI = function(aJ)
	return aJ * (Settings.FlySpeed or 50) / aJ.Magnitude
end

game:GetService("RunService").Heartbeat:connect(function(aK)
	if aA and av and av.PrimaryPart then
		local aB = av.PrimaryPart.Position
		local aL = az.CFrame
		local aM, aN, aO = aL:toEulerAnglesXYZ()
		av:SetPrimaryPartCFrame(CFrame.new(aB.x, aB.y, aB.z) * CFrame.Angles(aM, aN, aO))
		if aC.Moving then
			local aP = Vector3.new()
			if aC.W then
				aP = aP + aI(aL.lookVector)
			end
			if aC.S then
				aP = aP - aI(aL.lookVector)
			end
			if aC.A then
				aP = aP - aI(aL.rightVector)
			end
			if aC.D then
				aP = aP + aI(aL.rightVector)
			end
			av:TranslateBy(aP * aK)
		end
	end
end)
ar:AddToggle({Name = "Fly", Default = false, Callback = function(aP)
	Fly = aP
	if Fly then
		for aQ, aR in next, getconnections(game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head").ChildAdded) do
			aR:Disable()
		end
		aD()
	else
		aE()
	end
end})
local aS = nil
ar:AddToggle({Name = "Noclip", Default = false, Callback = function(aP)
	Settings.Noclip = aP
	local function aT()
		if game:GetService("Players").LocalPlayer.Character and Settings.Noclip then
			for u, aU in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
				if aU:IsA('BasePart') and aU.CanCollide and Settings.Noclip then
					aU.CanCollide = false
				end
			end
		else
			game:GetService("RunService").RenderStepped:Disconnect()
		end
	end
	aS = game:GetService("RunService").RenderStepped:Connect(aT)
	if not Settings.Noclip then
		aS:Disconnect()
	end
end})
ar:AddToggle({Name = "Click Teleport", Default = false, Callback = function(aP)
	Settings.ClickTeleport = aP
	if Settings.ClickTeleport then
		v:MakeNotification({Name = "Eazvy Hub - Success", Content = 'Click-Teleport has been enabled; Keybind: CTRL + Click', Image = "rbxassetid://4914902889", Time = 10})
	end
end})
ar:AddToggle({Name = "Infinite Jump", Default = false, Callback = function(aP)
	Settings.InfJump = aP
end})
game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(aV)
	if Settings.InfJump and aV == " " then
		game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
	end
end)
game:GetService("UserInputService").InputBegan:connect(function(aF, aG)
	if aF.UserInputType == Enum.UserInputType.MouseButton1 and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and Settings.ClickTeleport then
		game.Players.LocalPlayer.Character:MoveTo(game.Players.LocalPlayer:GetMouse().Hit.p)
	end
	if aG then
		return
	end
	for p, aH in pairs(aC) do
		if p ~= "Moving" and aF.KeyCode == Enum.KeyCode[p] then
			aC[p] = true
			aC.Moving = true
		end
	end
end)
local Status = aq:AddParagraph("Emote Information", "Previous Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
if game.Players.LocalPlayer.Character and not game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
	aq:AddDropdown({Name = "Emotes (R6)", Default = "", Options = H, Callback = function(aW)
		if a7() ~= "R15" then
			M()
			a5(G[aW].Emote, G[aW].Speed, G[aW].Time, G[aW].Weight, G[aW].Loop)
			Settings.LastEmote = aW
			UpdateFile()
			Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
		end
	end})
end
local aX
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
	aq:AddTextbox({Name = "Play Emote / Search (Name)", Default = "", TextDisappear = true, Callback = function(at)
		if Settings.EmoteChat then
			local aY = ad(at)
			if #aY >= 1 then
				z("Found " .. #aY .. " Emotes!", 'with search-term "' .. at .. '"' .. ".")
			end
			aX:Refresh(aY, true)
		end
		if Settings.EmoteChat then
			return
		end
		local am = af(at)
		if am and string.len(at) > 2 then
			M()
			a9(am)
			Settings.LastEmote = am
			Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
			UpdateFile()
		end
	end})
	aq:AddTextbox({Name = "Sync Emote (Player)", Default = "", TextDisappear = true, Callback = function(at)
		Settings.PlayerSync = getPlayersByName(at)
		if Settings.PlayerSync and Settings.PlayerSync.Character and Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid") and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			local N = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Animator
			local aZ = Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid").Animator:GetPlayingAnimationTracks()
			for u, q in pairs(aZ) do
				_G.LoadAnim = N:LoadAnimation(q.Animation)
				_G.LoadAnim.TimePosition = q.TimePosition
				_G.LoadAnim:Play(0.100000001, q.WeightCurrent, q.Speed)
				_G.LoadAnim.Priority = Enum.AnimationPriority.Action
			end
			z("Syncing Emotes with ", Settings.PlayerSync.Name .. " @" .. Settings.PlayerSync.DisplayName .. " it may not be synced, on your client but it is on the network.")
			Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
			UpdateFile()
			task.spawn(function()
				_G.LoadAnim.Stopped:Wait()
				if not Settings.PlayAlways then
					_G.LoadAnim:Stop()
				end
			end)
			Settings.PlayerSync.Character.Humanoid.Running:Wait()
			if not Settings.PlayAlways then
				_G.LoadAnim:Stop()
			end
		end
	end})

	local a_ = aq:AddSection({Name = " // Emote Dropdowns"})

	aq:AddDropdown({Name = "Emotes (R15)", Default = "", Options = J, Callback = function(at)
		if a7() ~= "R6" then
			M()
			Settings.LastEmote = at
			a9(at)
			Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
			UpdateFile()
		end
	end})

	aX = aq:AddDropdown({Name = "Emotes (Search)", Default = "", Options = {}, Callback = function(at)
		if a7() ~= "R6" then
			M()
			Settings.LastEmote = at
			a9(at)
			Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
			UpdateFile()
		end
	end})
end
local b0
if a7() == "R15" then
	b0 = aq:AddDropdown({Name = "Emotes (Favorite)", Default = "", Options = {}, Callback = function(at)
		if a7() ~= "R6" then
			M()
			Settings.LastEmote = at
			a9(at)
			Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
			UpdateFile()
		end
	end})
end
if Settings.Favorite and #Settings.Favorite >= 1 and a7() == "R15" then
	b0:Refresh(Settings.Favorite, true)
end
aq:AddButton({Name = "Play Last Emote", Callback = function()
	if Settings.LastEmote and a7() == "R15" then
		a5(C[Settings.LastEmote])
		Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
		UpdateFile()
	end
	if a7() == "R6" then
		M()
		a5(G[Settings.LastEmote].Emote, G[Settings.LastEmote].Speed, G[Settings.LastEmote].Time, G[Settings.LastEmote].Weight, G[Settings.LastEmote].Loop)
	end
end})
function RefreshDropdown()
	local b1 = {}
	for u, ac in ipairs(Settings.Favorite) do
		if not table.find(b1, ac) then
			table.insert(b1, ac)
		end
	end
	b0:Refresh(b1, true)
end
if a7() == "R15" then
	aq:AddButton({Name = "Favorite/Unfavorite Emote", Callback = function()
		local b2 = table.find(Settings.Favorite, Settings.LastEmote)
		if not b2 then
			table.insert(Settings.Favorite, Settings.LastEmote)
			RefreshDropdown()
			z("Successfully Favorited", Settings.LastEmote)
		else
			table.remove(Settings.Favorite, b2)
			RefreshDropdown()
		end
	end})
end
aq:AddButton({Name = "Stop Emote", Callback = function()
	if _G.LoadAnim then
		_G.LoadAnim:Stop()
		O()
		Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
		UpdateFile()
	end
end})
local a_ = aq:AddSection({Name = " // Emote Settings"})
if a7() == "R15" then
	aq:AddToggle({Name = "Emote Chat", Default = false, Callback = function(aP)
		Settings.Chat = aP
		if Settings.Chat then
			z("Enabled Emote-Chat", "Prefix is: " .. Settings.EmotePrefix)
			UpdateFile()
		end
	end})
end
if a7() == "R15" then
	aq:AddToggle({Name = "Emote Search", Default = false, Callback = function(aP)
		Settings.EmoteChat = aP
		UpdateFile()
	end})
end
local function b3()
	local b4
	local b5 = 0
	for u in pairs(C) do
		b5 = b5 + 1
	end
	local b6 = math.random(1, b5)
	b5 = 0
	for b7, u in pairs(C) do
		b5 = b5 + 1
		if b5 == b6 then
			b4 = b7
			break
		end
	end
	return b4, C[b4]
end
if a7() == "R15" then
	aq:AddToggle({Name = "Random Emote", Default = false, Callback = function(aP)
		Settings.RandomEmote = aP
		if not Settings.RandomEmote then
			O()
		end
		while Settings.RandomEmote do
			O()
			local b8, b9 = b3()
			Settings.LastEmote = b8
			a5(b9)
			Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
			repeat
				task.wait()
			until _G.LoadAnim.Length ~= 0 or not Settings.RandomEmote or not game.Players.LocalPlayer.Character or game.Players.LocalPlayer.Character and not game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or game.Players.LocalPlayer.Character and not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			task.wait(_G.LoadAnim.Length + .5 or 5.6)
		end
	end})
end
aq:AddToggle({Name = "Time-Position", Default = false, Callback = function(aP)
	Settings.Time = aP
	Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
	UpdateFile()
end})
aq:AddToggle({Name = "Always Play", Default = false, Callback = function(aP)
	Settings.PlayAlways = aP
	UpdateFile()
end})
if a7() == "R15" then
	aq:AddToggle({Name = "Always Sync-Emotes", Default = false, Callback = function(aP)
		Settings.SyncEmote = aP
		while Settings.SyncEmote do
			task.wait()
			if Settings.SyncEmote and Settings.PlayerSync and Settings.PlayerSync.Character and Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid") and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				local N = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Animator
				local aZ = Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid").Animator:GetPlayingAnimationTracks()
				for u, q in pairs(aZ) do
					_G.LoadAnim = N:LoadAnimation(q.Animation)
					_G.LoadAnim.Priority = Enum.AnimationPriority.Action
					_G.LoadAnim:Play(0.100000001, q.WeightCurrent, q.Speed)
					_G.LoadAnim.TimePosition = q.TimePosition
					_G.LoadAnim:AdjustSpeed(q.Speed)
				end
				task.spawn(function()
					_G.LoadAnim.Stopped:Wait()
					if not Settings.PlayAlways then
						_G.LoadAnim:Stop()
					end
				end)
				Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
			end
		end
	end})
end
aq:AddToggle({Name = "Loop Emote", Default = false, Callback = function(aP)
	Settings.Looped = aP
	Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
	UpdateFile()
end})
aq:AddToggle({Name = "Reverse Emote", Default = false, Callback = function(aP)
	Settings.Reversed = aP
	UpdateFile()
	if Settings.Reversed and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		_G.LoadAnim:AdjustSpeed(Settings.ReverseSpeed)
		Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
	end
end})
aq:AddToggle({Name = "Freeze Emote", Default = false, Callback = function(aP)
	Settings.FreezeEmote = aP
	if aP == true and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and _G.LoadAnim then
		_G.LoadAnim:AdjustSpeed(0)
		Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
	elseif aP == false and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and _G.LoadAnim then
		_G.LoadAnim:AdjustSpeed(1)
		Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
	end
end})
aq:AddSlider({Name = "Emote Speed", Min = 0, Max = 100, Default = 1, Color = Color3.fromRGB(0, 128, 255), Increment = 1, ValueName = "", Callback = function(at)
	Settings.EmoteSpeed = at
	if _G.LoadAnim and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		_G.LoadAnim:AdjustSpeed(at)
		Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
	end
end})
aq:AddSlider({Name = "Time Position", Min = 0, Max = 100, Default = 0, Color = Color3.fromRGB(0, 128, 255), Increment = 1, ValueName = "", Callback = function(at)
	UpdateFile()
	if Settings.Time then
		Settings.TimePosition = at
		_G.LoadAnim.TimePosition = at / 100 * _G.LoadAnim.Length
		Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
	end
end})
if a7() == "R15" then
	local a_ = aq:AddSection({Name = " // Rape Section"})
	aq:AddTextbox({Name = "Enter Player (Name)", Default = "", TextDisappear = true, Callback = function(at)
		Settings.Player = getPlayersByName(at)
	end})

	aq:AddToggle({Name = "Rape", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			if not Settings.Player or Settings.Player and not Settings.Player.Character then
				w("Failed!", "Player was not found! Please enter player-name in textbox above.")
			end
			Settings.PlayAlways = true
			Settings.Time = true
			local am = af("Gem")
			O()
			a9(am)
			_G.LoadAnim.TimePosition = 8
			_G.LoadAnim:AdjustSpeed(0)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			if game.Players.LocalPlayer.Character and Settings.Player.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Settings.Player.Character:FindFirstChild("HumanoidRootPart") then
				local ba = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local bb = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
				if ba.Position.Y < bb.Position.Y then
					if not platform then
						platform = Instance.new("Part")
						platform.Size = Vector3.new(5, 0.1, 5)
						platform.Transparency = 1
						platform.Anchored = true
						platform.Position = bb.Position + Vector3.new(0, 2, 0)
						platform.Parent = game.Workspace
					end
				else
					if platform then
						platform:Destroy()
						platform = nil
					end
				end
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, 1)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, 2)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, 3)
			end
		end
	end})

	aq:AddToggle({Name = "Rape 2", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			if not Settings.Player or Settings.Player and not Settings.Player.Character then
				w("Failed!", "Player was not found! Please enter player-name in textbox above.")
			end
			Settings.PlayAlways = true
			Settings.Time = true
			local am = af("Boom Boom Clap")
			O()
			a9(am)
			_G.LoadAnim.TimePosition = 8
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			if game.Players.LocalPlayer.Character and Settings.Player.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Settings.Player.Character:FindFirstChild("HumanoidRootPart") then
				local ba = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local bb = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
				if ba.Position.Y < bb.Position.Y then
					if not platform then
						platform = Instance.new("Part")
						platform.Size = Vector3.new(5, 0.1, 5)
						platform.Transparency = 1
						platform.Anchored = true
						platform.Position = bb.Position + Vector3.new(0, 2, 0)
						platform.Parent = game.Workspace
					end
				else
					if platform then
						platform:Destroy()
						platform = nil
					end
				end
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, 1)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, 2)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, 3)
			end
		end
	end})

	aq:AddToggle({Name = "Get Raped", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			if not Settings.Player or Settings.Player and not Settings.Player.Character then
				w("Failed!", "Player was not found! Please enter player-name in textbox above.")
			end
			Settings.PlayAlways = true
			local am = af("Sleep")
			O()
			a9(am)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			if game.Players.LocalPlayer.Character and Settings.Player.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Settings.Player.Character:FindFirstChild("HumanoidRootPart") then
				local ba = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local bb = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
				if ba.Position.Y < bb.Position.Y then
					if not platform then
						platform = Instance.new("Part")
						platform.Size = Vector3.new(5, 0.1, 5)
						platform.Transparency = 1
						platform.Anchored = true
						platform.Position = bb.Position + Vector3.new(0, 2, 0)
						platform.Parent = game.Workspace
					end
				else
					if platform then
						platform:Destroy()
						platform = nil
					end
				end
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -1)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -2)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -3)
			end
		end
	end})

	aq:AddToggle({Name = "Get Raped 2", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			if not Settings.Player or Settings.Player and not Settings.Player.Character then
				w("Failed!", "Player was not found! Please enter player-name in textbox above.")
			end
			Settings.PlayAlways = true
			Settings.Time = true
			local am = af("Gem")
			O()
			a9(am)
			_G.LoadAnim.TimePosition = 8
			_G.LoadAnim:AdjustSpeed(0)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			if game.Players.LocalPlayer.Character and Settings.Player.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Settings.Player.Character:FindFirstChild("HumanoidRootPart") then
				local ba = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local bb = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
				if ba.Position.Y < bb.Position.Y then
					if not platform then
						platform = Instance.new("Part")
						platform.Size = Vector3.new(5, 0.1, 5)
						platform.Transparency = 1
						platform.Anchored = true
						platform.Position = bb.Position + Vector3.new(0, 2, 0)
						platform.Parent = game.Workspace
					end
				else
					if platform then
						platform:Destroy()
						platform = nil
					end
				end
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -1)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -2)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -3)
			end
		end
	end})

	aq:AddToggle({Name = "Get Raped 3", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			if not Settings.Player or Settings.Player and not Settings.Player.Character then
				w("Failed!", "Player was not found! Please enter player-name in textbox above.")
			end
			Settings.PlayAlways = true
			Settings.Time = true
			local am = af("Scorpion")
			O()
			a9(am)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			if game.Players.LocalPlayer.Character and Settings.Player.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Settings.Player.Character:FindFirstChild("HumanoidRootPart") then
				local ba = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local bb = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
				if ba.Position.Y < bb.Position.Y then
					if not platform then
						platform = Instance.new("Part")
						platform.Size = Vector3.new(5, 0.1, 5)
						platform.Transparency = 1
						platform.Anchored = true
						platform.Position = bb.Position + Vector3.new(0, 2, 0)
						platform.Parent = game.Workspace
					end
				else
					if platform then
						platform:Destroy()
						platform = nil
					end
				end
				_G.LoadAnim.TimePosition = 83
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -1)
				task.wait(.15)
				_G.LoadAnim.TimePosition = 84
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -2)
				_G.LoadAnim.TimePosition = 83
				task.wait(.15)
				_G.LoadAnim.TimePosition = 84
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -3)
			end
		end
	end})
	aq:AddToggle({Name = "Get Raped 4", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			if not Settings.Player or Settings.Player and not Settings.Player.Character then
				w("Failed!", "Player was not found! Please enter player-name in textbox above.")
			end
			Settings.PlayAlways = true
			Settings.Time = true
			local am = af("BURBERRY LOLA  ATTITUDE - GEM")
			O()
			a9(am)
			_G.LoadAnim.TimePosition = 60
			_G.LoadAnim:AdjustSpeed(0)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			if game.Players.LocalPlayer.Character and Settings.Player.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Settings.Player.Character:FindFirstChild("HumanoidRootPart") then
				local ba = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local bb = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
				if ba.Position.Y < bb.Position.Y then
					if not platform then
						platform = Instance.new("Part")
						platform.Size = Vector3.new(5, 0.1, 5)
						platform.Transparency = 1
						platform.Anchored = true
						platform.Position = bb.Position + Vector3.new(0, 2, 0)
						platform.Parent = game.Workspace
					end
				else
					if platform then
						platform:Destroy()
						platform = nil
					end
				end
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -1)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -2)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -3)
			end
		end
	end})

	aq:AddToggle({Name = "Get Raped 5", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			if not Settings.Player or Settings.Player and not Settings.Player.Character then
				w("Failed!", "Player was not found! Please enter player-name in textbox above.")
			end
			Settings.PlayAlways = true
			Settings.Time = true
			local am = af("BURBERRY LOLA  ATTITUDE - GEM")
			O()
			a9(am)
			_G.LoadAnim.TimePosition = 38
			_G.LoadAnim:AdjustSpeed(0)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			if game.Players.LocalPlayer.Character and Settings.Player.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Settings.Player.Character:FindFirstChild("HumanoidRootPart") then
				local ba = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local bb = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
				if ba.Position.Y < bb.Position.Y then
					if not platform then
						platform = Instance.new("Part")
						platform.Size = Vector3.new(5, 0.1, 5)
						platform.Transparency = 1
						platform.Anchored = true
						platform.Position = bb.Position + Vector3.new(0, 2, 0)
						platform.Parent = game.Workspace
					end
				else
					if platform then
						platform:Destroy()
						platform = nil
					end
				end
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -1)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -2)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(0, 0, -3)
			end
		end
	end})

	aq:AddToggle({Name = "Slap Ass", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			if not Settings.Player or Settings.Player and not Settings.Player.Character then
				w("Failed!", "Player was not found! Please enter player-name in textbox above.")
			end
			Settings.PlayAlways = true
			Settings.Time = true
			local am = af("Beauty Touchdown")
			O()
			a9(am)
			_G.LoadAnim.TimePosition = -1
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			if game.Players.LocalPlayer.Character and Settings.Player.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Settings.Player.Character:FindFirstChild("HumanoidRootPart") then
				local ba = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local bb = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
				if ba.Position.Y < bb.Position.Y then
					if not platform then
						platform = Instance.new("Part")
						platform.Size = Vector3.new(5, 0.1, 5)
						platform.Transparency = 1
						platform.Anchored = true
						platform.Position = bb.Position + Vector3.new(0, 2, 0)
						platform.Parent = game.Workspace
					end
				else
					if platform then
						platform:Destroy()
						platform = nil
					end
				end
				ba.CFrame = bb.CFrame * CFrame.new(-2, 0, 2)
				task.wait(.15)
				_G.LoadAnim.TimePosition = -1
				ba.CFrame = bb.CFrame * CFrame.new(-2, 0, 3)
				task.wait(.15)
				ba.CFrame = bb.CFrame * CFrame.new(-2, 0, 4)
			end
		end
	end})

	local a_ = aq:AddSection({Name = " // Emote Toggles"})

	aq:AddToggle({Name = "Sit", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			Settings.PlayAlways = true
			Settings.Time = true
			O()
			local am = af("Lotus")
			a9(am)
			task.wait(.15)
			_G.LoadAnim.TimePosition = 45 / 100 * _G.LoadAnim.Length
			_G.LoadAnim:AdjustSpeed(0)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
		end
	end})

	aq:AddToggle({Name = "Upside Down", Default = false, Callback = function(aP)
		Settings.RapePlayer = aP
		if Settings.RapePlayer then
			Settings.PlayAlways = true
			Settings.Time = true
			O()
			local am = af("Hero Landing")
			a9(am)
			task.wait(.15)
			_G.LoadAnim.TimePosition = 24.15 / 100 * _G.LoadAnim.Length
			_G.LoadAnim:AdjustSpeed(0)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.RapePlayer do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
		end
	end})

	aq:AddToggle({Name = "Twerk Ass", Default = false, Callback = function(aP)
		Settings.TwerkAss = aP
		if Settings.TwerkAss then
			Settings.PlayAlways = true
			Settings.Time = true
			O()
			local am = af("Scorpion")
			a9(am)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.TwerkAss do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			_G.LoadAnim.TimePosition = 83
			task.wait(.15)
			_G.LoadAnim.TimePosition = 83
			_G.LoadAnim.TimePosition = 83
			task.wait(.15)
			_G.LoadAnim.TimePosition = 83
		end
	end})

	aq:AddToggle({Name = "Twerk Ass 2", Default = false, Callback = function(aP)
		Settings.TwerkAss2 = aP
		if Settings.TwerkAss2 then
			Settings.PlayAlways = true
			Settings.Time = true
			O()
			local am = af("Scorpion")
			a9(am)
		else
			O()
			Settings.PlayAlways = false
		end
		while Settings.TwerkAss2 do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end)
			_G.LoadAnim.TimePosition = 82
			task.wait(.15)
			_G.LoadAnim.TimePosition = 83
			_G.LoadAnim.TimePosition = 82
			task.wait(.15)
			_G.LoadAnim.TimePosition = 83
		end
	end})

	aq:AddTextbox({Name = "Custom Emote (ID)", Default = "", TextDisappear = true, Callback = function(at)
		UpdateFile()
		a5(at)
		Status:Set("Current Emote: " .. Settings.LastEmote .. " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. aj() .. " // Looped: " .. ak())
	end})
end
function GetRandomAnimation(bc)
	local bd = {}
	for b7, u in pairs(bc) do
		table.insert(bd, b7)
	end
	local b4 = bd[math.random(1, #bd)]
	return bc[b4]
end
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
	as:AddDropdown({Name = "Select Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = aW
		UpdateFile()
		M()
		P(D[aW].Idle, D[aW].Idle2, D[aW].Idle3, D[aW].Walk, D[aW].Run, D[aW].Jump, D[aW].Climb, D[aW].Fall, D[aW].Swim, D[aW].SwimIdle, D[aW].Weight, D[aW].Weight2)
		O()
		local a8 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
		local ag = a8:GetPlayingAnimationTracks()
		for u, q in pairs(ag) do
			q:AdjustSpeed(Settings.AnimationSpeed)
		end
		AStatus:Set("Current Animation: " .. Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed))
		O()
	end})
	as:AddTextbox({Name = "Play Animation (Name)", Default = "", TextDisappear = true, Callback = function(at)
		local an = ab(at)
		if an and string.len(at) > 2 then
			M()
			Settings.SelectedAnimation = an
			Settings.LastEmote = "Play"
			P(D[an].Idle, D[an].Idle2, D[an].Idle3, D[an].Walk, D[an].Run, D[an].Jump, D[an].Climb, D[an].Fall, D[an].Swim, D[an].SwimIdle, D[an].Weight, D[an].Weight2)
			UpdateFile()
			AStatus:Set("Current Animation: " .. Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed))
			O()
		end
	end})

	as:AddTextbox({Name = "Sync Animation (Player)", Default = "", TextDisappear = true, Callback = function(at)
		c = getPlayersByName(at)
		if not Settings.SyncAnimations then
			w("IMPORTANT!", "Toggle Sync-Animation in the settings, and type the player name in again to sync.")
		end
		if Settings.SyncAnimations and Sync_Animations then
			Sync_Animations:Disconnect()
		end
		if c and c.Character and c.Character:FindFirstChildOfClass("Humanoid") and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and Settings.SyncAnimations then
			Sync_Animations = c.Character.Humanoid.AnimationPlayed:Connect(function(be)
				if Settings.SyncAnimations then
					M()
					local a = game.Players.LocalPlayer.Character.Animate
					local bf = c.Character.Animate
					local OriginalAnimations = {}
					if bf:FindFirstChild("pose") then
						local d = game.Players.LocalPlayer.Character.Animate.pose:FindFirstChildOfClass("Animation")
						local bg = c.Character.Animate.pose:FindFirstChildOfClass("Animation")
						if d and bg then
							d.AnimationId = bg.AnimationId
						end
					end
					a.idle.Animation1.AnimationId = bf.idle.Animation1.AnimationId
					a.idle.Animation2.AnimationId = bf.idle.Animation2.AnimationId
					a.walk:FindFirstChildOfClass("Animation").AnimationId = bf.walk:FindFirstChildOfClass("Animation").AnimationId
					a.run:FindFirstChildOfClass("Animation").AnimationId = bf.run:FindFirstChildOfClass("Animation").AnimationId
					a.jump:FindFirstChildOfClass("Animation").AnimationId = bf.jump:FindFirstChildOfClass("Animation").AnimationId
					a.climb:FindFirstChildOfClass("Animation").AnimationId = bf.climb:FindFirstChildOfClass("Animation").AnimationId
					a.fall:FindFirstChildOfClass("Animation").AnimationId = bf.fall:FindFirstChildOfClass("Animation").AnimationId
					if a:FindFirstChild("swim") then
						a.swim:FindFirstChildOfClass("Animation").AnimationId = bf.swim:FindFirstChildOfClass("Animation").AnimationId
						a.swimidle:FindFirstChildOfClass("Animation").AnimationId = bf.swimidle:FindFirstChildOfClass("Animation").AnimationId
					end
					O()
					local bh = be.Animation.AnimationId
					for u, bi in pairs(game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
						bi:Stop()
					end
					game.Players.LocalPlayer.Character.Animate.Disabled = true
					local bj = Instance.new("Animation")
					bj.AnimationId = bh
					local bk = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(bj)
					bk:Play()
					bk:AdjustWeight(10)
					bk.Stopped:Connect(function()
						game.Players.LocalPlayer.Character.Animate.Disabled = false
					end)
					AStatus:Set("Current Animation: " .. Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed))
					UpdateFile()
				end
			end)
		end
	end})
	local Sync_Animations

	as:AddToggle({Name = "Animation Chat", Default = false, Callback = function(aP)
		Settings.Animate = aP
		UpdateFile()
		if Settings.Animate then
			z("Enabled Animation-Chat", "Prefix is: " .. Settings.AnimationPrefix)
		end
	end})

	as:AddToggle({Name = "Random Animation", Default = false, Callback = function(aP)
		Settings.RandomAnim = aP
		UpdateFile()
		while Settings.RandomAnim do
			task.wait()
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and Settings.RandomAnim then
				Settings.Custom = GetRandomAnimation(D)
				M()
				P(Settings.Custom.Idle, Settings.Custom.Idle2, Settings.Custom.Idle3, Settings.Custom.Walk, Settings.Custom.Run, Settings.Custom.Jump, Settings.Custom.Climb, Settings.Custom.Fall, Settings.Custom.Swim, Settings.Custom.SwimIdle, Settings.Custom.Weight, Settings.Custom.Weight2)
				Settings.SelectedAnimation = "Custom"
				local a8 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
				local ag = a8:GetPlayingAnimationTracks()
				for u, q in pairs(ag) do
					q:AdjustSpeed(Settings.AnimationSpeed)
				end
				AStatus:Set("Current Animation: " .. Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed))
				O()
				task.wait(6.35)
			end
		end
	end})

	as:AddButton({Name = "Reset Animations", Callback = function()
		M()
		local a = game.Players.LocalPlayer.Character.Animate
		a.idle.Animation1.AnimationId = OriginalAnimations[1] or ""
		a.idle.Animation2.AnimationId = OriginalAnimations[2] or ""
		if a:FindFirstChild("pose") then
			local d = game.Players.LocalPlayer.Character.Animate.pose:FindFirstChildOfClass("Animation")
			if d then
				d.AnimationId = OriginalAnimations[3] or ""
			end
		end
		a.walk:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[4] or ""
		a.run:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[5] or ""
		a.jump:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[6] or ""
		a.climb:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[7] or ""
		a.fall:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[8] or ""
		a.swim:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[9] or ""
		a.swimidle:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[10] or ""
		O()
	end})

	local a_ = as:AddSection({Name = " // Animation Settings"})

	as:AddSlider({Name = "Animation Speed", Min = 0, Max = 100, Default = 1, Color = Color3.fromRGB(0, 128, 255), Increment = 1, ValueName = "", Callback = function(at)
		Settings.AnimationSpeed = at
		AStatus:Set("Current Animation: " .. Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed))
	end})

	as:AddToggle({Name = "Animation Speed", Default = false, Callback = function(aP)
		Settings.AnimationSpeedToggle = aP
		UpdateFile()
	end})

	as:AddToggle({Name = "Sync Animations", Default = false, Callback = function(aP)
		Settings.SyncAnimations = aP
		UpdateFile()
		if not Settings.SyncAnimations then
			O()
			M()
			local a = game.Players.LocalPlayer.Character.Animate
			a.idle.Animation1.AnimationId = OriginalAnimations[1] or ""
			a.idle.Animation2.AnimationId = OriginalAnimations[2] or ""
			if a:FindFirstChild("pose") then
				local d = game.Players.LocalPlayer.Character.Animate.pose:FindFirstChildOfClass("Animation")
				if d then
					d.AnimationId = OriginalAnimations[3] or ""
				end
			end
			a.walk:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[4] or ""
			a.run:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[5] or ""
			a.jump:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[6] or ""
			a.climb:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[7] or ""
			a.fall:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[8] or ""
			a.swim:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[9] or ""
			a.swimidle:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[10] or ""
			O()
		end
	end})

	local function bl()
		local bm = game.Players.LocalPlayer.Character.PrimaryPart.Position
		local bn = c.Character.HumanoidRootPart.Position
		local bo = (bn - bm).unit
		local bp = (bn - bm).magnitude
		local bq = RaycastParams.new()
		bq.FilterType = Enum.RaycastFilterType.Blacklist
		bq.FilterDescendantsInstances = game.Players:GetPlayers()
		local br = workspace:Raycast(bm, bo * bp, bq)
		if br and br.Instance.CanCollide and (br.Instance:IsA("BasePart") or br.Instance:IsA("MeshPart")) then
			return true
		end
		return false
	end

	as:AddToggle({Name = "Copy Movement", Default = false, Callback = function(aP)
		Settings.CopyMovement = aP
		UpdateFile()
		if Settings.CopyMovement and c and c.Character and c.Character:FindFirstChildOfClass("Humanoid") then
			c.Character.Humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
				if Settings.SyncAnimations then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Jump = true
				end
			end)
		end
		while Settings.CopyMovement do
			task.wait()
			if c and c.Character and c.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head") and Settings.CopyMovement then
				local bs = game.Players.LocalPlayer.Character.PrimaryPart.Position
				local bt = c.Character:FindFirstChild("Head").Position
				local bu = Vector3.new(bt.X, bs.Y, bt.Z)
				local bv = CFrame.new(bs, bu)
				game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(bv)
				local bw = bl()
				if bw and Settings.CopyMovement and c and c.Character and c.Character:FindFirstChild("HumanoidRootPart") and Settings.CopyMovement then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = c.Character.HumanoidRootPart.CFrame
				else
					if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and c and c.Character and c.Character:FindFirstChild("HumanoidRootPart") and Settings.CopyMovement then
						game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):MoveTo(c.Character.HumanoidRootPart.Position)
					end
				end
				if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
			end
		end
	end})

	as:AddToggle({Name = "Freeze Animation", Default = false, Callback = function(aP)
		Settings.FreezeAnimation = aP
		UpdateFile()
		if not Settings.FreezeAnimation and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController") then
			local a8 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
			local ag = a8:GetPlayingAnimationTracks()
			for u, q in pairs(ag) do
				q:AdjustSpeed(1)
			end
			O()
		end
		while Settings.FreezeAnimation do
			task.wait()
			if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController") then
				local a8 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
				local ag = a8:GetPlayingAnimationTracks()
				for u, q in pairs(ag) do
					q:AdjustSpeed(0)
				end
			end
		end
	end})
end
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
	local bx = ao:MakeTab({Name = "Custom Anims", Icon = "rbxassetid://12403104094", PremiumOnly = false})
	local a_ = bx:AddSection({Name = " // Custom Emotes"})

	bx:AddDropdown({Name = "Emotes (Animation)", Default = "", Options = {"Idle", "Idle 2", "Walk", "Run", "Jump", "Climb", "Fall", "Swim Idle", "Swim", "Wave", "Laugh", "Cheer", "Point", "Dance", 'Dance 2', 'Dance 3'}, Callback = function(at)
		if Settings.LastEmote == "" then
			w("Failed!", "Selected an Emote First from the (Main) Tab!")
			return
		end
		if at == "Idle" then
			a1("idle1", C[Settings.LastEmote])
			Settings.Custom.Idle = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Idle 2" then
			a1("idle2", C[Settings.LastEmote])
			Settings.Custom.Idle2 = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Walk" then
			a1("walk", C[Settings.LastEmote])
			Settings.Custom.Walk = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Run" then
			a1("run", C[Settings.LastEmote])
			Settings.Custom.Run = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Jump" then
			a1("jump", C[Settings.LastEmote])
			Settings.Custom.Jump = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Climb" then
			a1("climb", C[Settings.LastEmote])
			Settings.Custom.Climb = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Fall" then
			a1("fall", C[Settings.LastEmote])
			Settings.Custom.Fall = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Swim Idle" then
			a1("swimidle", C[Settings.LastEmote])
			Settings.Custom.SwimIdle = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Swim" then
			a1("swim", C[Settings.LastEmote])
			Settings.Custom.Swim = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Wave" then
			a1("wave", C[Settings.LastEmote])
			Settings.Custom.Wave = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Laugh" then
			a1("laugh", C[Settings.LastEmote])
			Settings.Custom.Laugh = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Cheer" then
			a1("cheer", C[Settings.LastEmote])
			Settings.Custom.Cheer = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Point" then
			a1("point", C[Settings.LastEmote])
			Settings.Custom.Point = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Dance" then
			a1("dance", C[Settings.LastEmote])
			Settings.Custom.Dance = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Dance 2" then
			a1("dance2", C[Settings.LastEmote])
			Settings.Custom.Dance2 = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		elseif at == "Dance 3" then
			a1("dance3", C[Settings.LastEmote])
			Settings.Custom.Dance3 = C[Settings.LastEmote]
			Settings.SelectedAnimation = "Custom"
			UpdateFile()
		end
	end})
	bx:AddButton({Name = "Select Random Animations", Callback = function()
		Settings.Custom.Custom = {}
		O()
		for p = 1, 10 do
			task.wait()
			Settings.Custom.Idle = GetRandomAnimation(D).Idle
			Settings.Custom.Idle2 = GetRandomAnimation(D).Idle2
			Settings.Custom.Idle3 = GetRandomAnimation(D).Idle3
			Settings.Custom.Walk = GetRandomAnimation(D).Walk
			Settings.Custom.Run = GetRandomAnimation(D).Run
			Settings.Custom.Jump = GetRandomAnimation(D).Jump
			Settings.Custom.Climb = GetRandomAnimation(D).Climb
			Settings.Custom.Fall = GetRandomAnimation(D).Fall
			Settings.Custom.Swim = GetRandomAnimation(D).Swim
			Settings.Custom.SwimIdle = GetRandomAnimation(D).SwimIdle
			Settings.Custom.Weight = GetRandomAnimation(D).Weight
			Settings.Custom.Weight2 = GetRandomAnimation(D).Weight2
		end
		P(Settings.Custom.Idle, Settings.Custom.Idle2, Settings.Custom.Idle3, Settings.Custom.Walk, Settings.Custom.Run, Settings.Custom.Jump, Settings.Custom.Climb, Settings.Custom.Fall, Settings.Custom.Swim, Settings.Custom.SwimIdle, Settings.Custom.Weight, Settings.Custom.Weight2)
		UpdateFile()
		O()
		Settings.SelectedAnimation = "Custom"
	end})

	bx:AddButton({Name = "Select Random Emote Animations", Callback = function()
		Settings.Custom.Custom = {}
		O()
		for p = 1, 10 do
			task.wait()
			local b8, b9 = b3()
			if p == 1 then
				Settings.Custom.Idle = b9
			elseif p == 2 then
				Settings.Custom.Idle2 = b9
			elseif p == 3 then
				Settings.Custom.Idle3 = b9
			elseif p == 4 then
				Settings.Custom.Walk = b9
			elseif p == 5 then
				Settings.Custom.Run = b9
			elseif p == 6 then
				Settings.Custom.Jump = b9
			elseif p == 7 then
				Settings.Custom.Climb = b9
			elseif p == 8 then
				Settings.Custom.Fall = b9
			elseif p == 9 then
				Settings.Custom.Swim = b9
			elseif p == 10 then
				Settings.Custom.SwimIdle = b9
			end
		end
		P(Settings.Custom.Idle, Settings.Custom.Idle2, Settings.Custom.Idle3, Settings.Custom.Walk, Settings.Custom.Run, Settings.Custom.Jump, Settings.Custom.Climb, Settings.Custom.Fall, Settings.Custom.Swim, Settings.Custom.SwimIdle, Settings.Custom.Weight, Settings.Custom.Weight2)
		UpdateFile()
		O()
		Settings.SelectedAnimation = "Custom"
		Settings.Custom.Name = "Emotes"
	end})

	local a_ = bx:AddSection({Name = " // Custom-Selection Dropdowns"})

	bx:AddDropdown({Name = "Set Idle1 Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = ""
		a1("idle1", D[aW].Idle)
		Settings.Custom.Idle = D[aW].Idle
		Settings.SelectedAnimation = "Custom"
		Settings.Custom.Name = aW
		UpdateFile()
	end})

	bx:AddDropdown({Name = "Set Idle2 Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = ""
		a1("idle2", D[aW].Idle2)
		Settings.Custom.Idle2 = D[aW].Idle2
		Settings.SelectedAnimation = "Custom"
		Settings.Custom.Name = aW
		UpdateFile()
	end})

	bx:AddDropdown({Name = "Set Walk Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = ""
		a1("walk", D[aW].Walk)
		Settings.Custom.Walk = D[aW].Walk
		Settings.SelectedAnimation = "Custom"
		Settings.Custom.Name = aW
		UpdateFile()
	end})

	bx:AddDropdown({Name = "Set Run Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = ""
		a1("run", D[aW].Run)
		Settings.Custom.Run = D[aW].Run
		Settings.SelectedAnimation = "Custom"
		Settings.Custom.Name = aW
		UpdateFile()
	end})

	bx:AddDropdown({Name = "Set Jump Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = ""
		a1("jump", D[aW].Jump)
		Settings.Custom.Jump = D[aW].Jump
		Settings.SelectedAnimation = "Custom"
		Settings.Custom.Name = aW
		UpdateFile()
	end})

	bx:AddDropdown({Name = "Set Climb Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = ""
		a1("climb", D[aW].Climb)
		Settings.Custom.Climb = D[aW].Climb
		Settings.Custom.Name = aW
		UpdateFile()
	end})

	bx:AddDropdown({Name = "Set Fall Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = ""
		a1("fall", D[aW].Fall)
		Settings.Custom.Fall = D[aW].Fall
		Settings.SelectedAnimation = "Custom"
		Settings.Custom.Name = aW
		UpdateFile()
	end})

	bx:AddDropdown({Name = "Set Swim-Idle Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = ""
		a1("swimidle", D[aW].SwimIdle)
		Settings.Custom.SwimIdle = D[aW].SwimIdle
		Settings.SelectedAnimation = "Custom"
		Settings.Custom.Name = aW
		UpdateFile()
	end})

	bx:AddDropdown({Name = "Set Swim Animation", Default = "", Options = I, Callback = function(aW)
		Settings.SelectedAnimation = ""
		a1("swim", D[aW].Swim)
		Settings.Custom.Swim = D[aW].Swim
		Settings.SelectedAnimation = "Custom"
		Settings.Custom.Name = aW
		UpdateFile()
	end})
end
local by = ao:MakeTab({Name = "Settings", Icon = "rbxassetid://8382597378", PremiumOnly = false})
by:AddButton({Name = "Rejoin", Callback = function()
	game:GetService('TeleportService'):Teleport(game.PlaceId)
end})
by:AddButton({Name = "Serverhop", Callback = function()
	game:GetService("TeleportService"):TeleportCancel()
	game:GetService("Players").LocalPlayer:Kick("Serverhopping please wait... | This is to avoid bans in-game.")
	task.wait(.15)
	l()
end})
by:AddButton({Name = "Save Current Animations (File)", Callback = function()
	if game:GetService("Players").LocalPlayer.Character ~= nil and game:GetService("Players").LocalPlayer.Character.Animate ~= nil then
		local a = game:GetService('Players').LocalPlayer.Character.Animate
		local bz = math.random(9e9, 8e8)
		if writefile then
			writefile(game:GetService("Players").LocalPlayer.Name .. "Animations" .. bz .. ".lua", "local Animate = game:GetService('Players').LocalPlayer.Character.Animate" .. "\n" .. "Animate.idle.Animation1.AnimationId = " .. "'" .. a.idle.Animation1.AnimationId .. "'" .. "\n" .. "Animate.idle.Animation2.AnimationId = " .. "'" .. a.idle.Animation2.AnimationId .. "'" .. "\n" .. "Animate.run:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.run:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.walk:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.walk:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.jump:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.jump:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.climb:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.climb:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.fall:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.fall:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.swim:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.swim:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.swimidle:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.swimidle:FindFirstChildOfClass('Animation').AnimationId .. "'")
			z(game:GetService("Players").LocalPlayer.Name .. " @" .. game:GetService("Players").LocalPlayer.DisplayName .. " Animations", "saved to workspace folder!")
		else
			z(game:GetService("Players").LocalPlayer.Name .. " @" .. game:GetService("Players").LocalPlayer.DisplayName .. " Animations", "set to clipboard")
			setclipboard("local Animate = game:GetService('Players').LocalPlayer.Character.Animate" .. "\n" .. "Animate.idle.Animation1.AnimationId = " .. "'" .. a.idle.Animation1.AnimationId .. "'" .. "\n" .. "Animate.idle.Animation2.AnimationId = " .. "'" .. a.idle.Animation2.AnimationId .. "'" .. "\n" .. "Animate.run:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.run:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.walk:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.walk:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.jump:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.jump:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.climb:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.climb:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.fall:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.fall:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.swim:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.swim:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.swimidle:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.swimidle:FindFirstChildOfClass('Animation').AnimationId .. "'")
		end
	end
end})
by:AddTextbox({Name = "Save Animations File (Player)", Default = "", TextDisappear = true, Callback = function(at)
	c = getPlayersByName(at)
	local a = game:GetService('Players')[c].Character.Animate
	local bz = math.random(9e9, 8e8)
	writefile(game:GetService("Players")[c].Name .. "Animations" .. bz .. ".lua", "local Players = game:GetService('Players')" .. "\n" .. "local Animate = Players[" .. c .. "].Character.Animate" .. "\n" .. "Animate.idle.Animation1.AnimationId = " .. "'" .. a.idle.Animation1.AnimationId .. "'" .. "\n" .. "Animate.idle.Animation2.AnimationId = " .. "'" .. a.idle.Animation2.AnimationId .. "'" .. "\n" .. "Animate.run:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.run:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.walk:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.walk:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.jump:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.jump:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.climb:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.climb:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.fall:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.fall:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.swim:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.swim:FindFirstChildOfClass('Animation').AnimationId .. "'" .. "\n" .. "Animate.swimidle:FindFirstChildOfClass('Animation').AnimationId = " .. "'" .. a.swimidle:FindFirstChildOfClass('Animation').AnimationId .. "'")
	z(game:GetService("Players")[c].Name .. " @" .. game:GetService("Players")[c].DisplayName .. " Animations", "saved to workspace folder!")
end})
if a7() == "R15" then
	by:AddTextbox({Name = "Emote Prefix", Default = "", TextDisappear = true, Callback = function(at)
		Settings.EmotePrefix = "/" .. at
		z("Changed", "Emote Prefix: " .. Settings.EmotePrefix)
	end})
	by:AddTextbox({Name = "Animation Prefix", Default = "", TextDisappear = true, Callback = function(at)
		Settings.AnimationPrefix = "/" .. at
		z("Changed", "Animation Prefix: " .. Settings.AnimationPrefix)
	end})
end
by:AddBind({Name = "Toggle UI", Default = Enum.KeyCode.Q, Hold = false, Callback = function()
	if game:GetService("CoreGui").Orion.Enabled then
		game:GetService("CoreGui").Orion.Enabled = false
	else
		game:GetService("CoreGui").Orion.Enabled = true
	end
end})
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("MoveDirection"):Connect(function()
	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection.Magnitude > 0 then
		if a7() == "R15" then
			if _G.LoadAnim and not Settings.PlayAlways then
				game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
				_G.LoadAnim:Stop()
			end
		else
			if _G.LoadAnim and not Settings.PlayAlways then 
				_G.LoadAnim:Stop()
				O()
			end
		end
	end
end)
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(bA)
	repeat
		wait()
	until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate")
	wait(.15)
	M()
	if Settings.SelectedAnimation ~= "" and a7() == "R15" and Settings.SelectedAnimation ~= "Custom" or Settings.LastEmote == "Play" and a7() == "R15" and Settings.SelectedAnimation ~= "Custom" then
		P(D[Settings.SelectedAnimation].Idle or e(1), D[Settings.SelectedAnimation].Idle2 or e(2), D[Settings.SelectedAnimation].Idle3 or e(3), D[Settings.SelectedAnimation].Walk or e(4), D[Settings.SelectedAnimation].Run or e(5), D[Settings.SelectedAnimation].Jump or e(6), D[Settings.SelectedAnimation].Climb or e(7), D[Settings.SelectedAnimation].Fall or e(8), D[Settings.SelectedAnimation].Swim or e(9), D[Settings.SelectedAnimation].SwimIdle or e(10), D[Settings.SelectedAnimation].Weight, D[Settings.SelectedAnimation].Weight2)
		O()
		local a8 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
		local ag = a8:GetPlayingAnimationTracks()
		for u, q in pairs(ag) do
			q:AdjustSpeed(Settings.AnimationSpeed)
		end
	elseif D[Settings.Custom.Name] and (Settings.Custom.Idle or Settings.Custom.Idle2 or Settings.Custom.Idle3 or Settings.Custom.Walk or Settings.Custom.Run or Settings.Custom.Jump or Settings.Custom.Climb or Settings.Custom.Fall or Settings.Custom.Swim or Settings.Custom.SwimIdle) and D[Settings.Custom.Name].Weight and D[Settings.Custom.Name].Weight2 and a7() == "R15" then
		P(Settings.Custom.Idle or OriginalAnimations[1], Settings.Custom.Idle2 or OriginalAnimations[2], Settings.Custom.Idle3 or OriginalAnimations[3] or nil, Settings.Custom.Walk or OriginalAnimations[4], Settings.Custom.Run or OriginalAnimations[5], Settings.Custom.Jump or OriginalAnimations[6], Settings.Custom.Climb or OriginalAnimations[7], Settings.Custom.Fall or OriginalAnimations[8], Settings.Custom.Swim or OriginalAnimations[9], Settings.Custom.SwimIdle or OriginalAnimations[10], D[Settings.Custom.Name].Weight, D[Settings.Custom.Name].Weight2)
		O()
		local a8 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
		local ag = a8:GetPlayingAnimationTracks()
		for u, q in pairs(ag) do
			q:AdjustSpeed(Settings.AnimationSpeed)
		end
	end
	game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("MoveDirection"):Connect(function()
		if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection.Magnitude > 0 then
			if a7() == "R15" then
				if _G.LoadAnim and not Settings.PlayAlways then
					game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
					_G.LoadAnim:Stop()
				end
			else
				if _G.LoadAnim and not Settings.PlayAlways then
					_G.LoadAnim:Stop()
					O()
				end
			end
		end
	end)
end)
if getgenv().AlreadyLoaded then
	while task.wait() do
		if Settings.AnimationSpeedToggle and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or Settings.AnimationSpeedToggle and game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController") then
			local a8 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
			local ag = a8:GetPlayingAnimationTracks()
			for u, q in pairs(ag) do
				q:AdjustSpeed(Settings.AnimationSpeed)
			end
		end
	end
end

print("hello")
