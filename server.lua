ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('sc_vehiclechecker:server:enteredVehicle')
AddEventHandler('sc_vehiclechecker:server:enteredVehicle', function(plate, seat, displayName, netId)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then return end
    print(('[sc_vehiclechecker] %s (%s) entered %s [%s] (Seat %s, NetID %s)'):format(
        xPlayer.getName(),
        xPlayer.identifier,
        displayName or 'Unknown',
        plate or 'N/A',
        seat or 'N/A',
        netId or 'N/A'
    ))
end)

RegisterNetEvent('sc_vehiclechecker:server:exitedVehicle')
AddEventHandler('sc_vehiclechecker:server:exitedVehicle', function(plate, seat, displayName, netId)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if not xPlayer then return end
    print(('[sc_vehiclechecker] %s (%s) exited %s [%s] (Seat %s, NetID %s)'):format(
        xPlayer.getName(),
        xPlayer.identifier,
        displayName or 'Unknown',
        plate or 'N/A',
        seat or 'N/A',
        netId or 'N/A'
    ))
end)