local vehicle = script.Parent
local input = game:GetService("UserInputService")
local gyro = vehicle.Gyro

local maxPitch = 45
local maxRoll = 45
local sensitivity = 0.01

local function updateRotation()
    local mouseDelta = input:GetMouseDelta()

    local pitch = math.clamp(mouseDelta.y * sensitivity, -maxPitch, maxPitch)
    local roll = math.clamp(mouseDelta.x * sensitivity, -maxRoll, maxRoll)

    local orientation = gyro.CFrame:ToObjectSpace(vehicle.PrimaryPart.CFrame)

    local newOrientation = CFrame.fromOrientation(math.rad(-pitch), math.rad(roll), 0)

    orientation = orientation * newOrientation

    gyro.CFrame = vehicle.PrimaryPart.CFrame * CFrame.new(orientation:ToVector3() * 10)
end

local function updateVehicle()
    local force = vehicle.PrimaryPart.CFrame:VectorToWorldSpace(Vector3.new(0, 0, 5000))

    vehicle:SetPrimaryPartCFrame(vehicle.PrimaryPart.CFrame + force)
end

game:GetService("RunService").Heartbeat:Connect(updateRotation)
game:GetService("RunService").Heartbeat:Connect(updateVehicle)
