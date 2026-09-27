local isInVehicle, isEnteringVehicle = false, false
local current = {}

local function GetData(vehicle)
    if not DoesEntityExist(vehicle) then
        return
    end
    local model = GetEntityModel(vehicle)
    local displayName = GetDisplayNameFromVehicleModel(model)
    local netId = VehToNet(vehicle)
    return displayName, netId
end

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        if not isInVehicle and not IsPlayerDead(PlayerId()) then

            if IsPedInAnyVehicle(playerPed, false) then
                -- suddenly appeared in a vehicle, possible teleport
                isEnteringVehicle = false
                isInVehicle = true
                current.vehicle = GetVehiclePedIsUsing(playerPed)
                current.seat = GetPedVehicleSeat(playerPed, current.vehicle)
                current.plate = GetVehicleNumberPlateText(current.vehicle)
                current.displayName, current.netId = GetData(current.vehicle)
                TriggerEvent('sc_vehiclechecker:client:enteredVehicle', current.vehicle, current.plate, current.seat, current.displayName, current.netId)
                TriggerServerEvent('sc_vehiclechecker:server:enteredVehicle', current.plate, current.seat, current.displayName, current.netId)
            end

        elseif isInVehicle then
            if not IsPedInAnyVehicle(playerPed, false) or IsPlayerDead(PlayerId()) then
                TriggerEvent('sc_vehiclechecker:client:exitedVehicle', current.vehicle, current.plate, current.seat, current.displayName, current.netId)
                TriggerServerEvent('sc_vehiclechecker:server:exitedVehicle', current.plate, current.seat, current.displayName, current.netId)
                isInVehicle = false
                current = {}
            end
        end
        Wait(500)
    end
end)

if Config.Debug then
    AddEventHandler('sc_vehiclechecker:client:enteringVehicle', function(vehicle, plate, seat, netId)
        print('sc_vehiclechecker:client:enteringVehicle', 'vehicle', vehicle, 'plate', plate, 'seat', seat, 'netId', netId)
    end)

    AddEventHandler('sc_vehiclechecker:client:enteringVehicleAborted', function()
        print('sc_vehiclechecker:client:enteringVehicleAborted')
    end)

    AddEventHandler('sc_vehiclechecker:client:enteredVehicle', function(vehicle, plate, seat, displayName, netId)
        print('sc_vehiclechecker:client:enteredVehicle', 'vehicle', vehicle, 'plate', plate, 'seat', seat, 'displayName', displayName, 'netId', netId)
    end)

    AddEventHandler('sc_vehiclechecker:client:exitedVehicle', function(vehicle, plate, seat, displayName, netId)
        print('sc_vehiclechecker:client:exitedVehicle', 'vehicle', vehicle, 'plate', plate, 'seat', seat, 'displayName', displayName, 'netId', netId)
    end)
end