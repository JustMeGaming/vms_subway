if Config.ESX then
    ESX = nil

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)
                ESX = obj
            end)
            Citizen.Wait(0)
        end          
    end)
    
    ESX.RegisterServerCallback('vms_subway:getMoney', function(source, cb, price)
        local xPlayer = ESX.GetPlayerFromId(source)
        local price = math.abs(price) -- simple protection against cheaters
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            cb(true)
        else
            cb(false)
        end
    end)
else
    local QBCore = exports['qb-core']:GetCoreObject()
    QBCore.Functions.CreateCallback('vms_subway:getMoney', function(source, cb, price)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        local price = math.abs(price) -- simple protection against cheaters
        if xPlayer.PlayerData.money.cash >= price then
        -- if Player.getMoney() >= price then
            xPlayer.Functions.RemoveMoney('cash', price)
            cb(true)
        else
            cb(false)
        end   
    end)  
end




-- if Config.esxSettings.enabled then
--     ESX = nil

--     Citizen.CreateThread(function()
--         while ESX == nil do
--             TriggerEvent('esx:getSharedObject', function(obj)
--                 ESX = obj
--             end)
--             Citizen.Wait(0)
--         end

--         while ESX.GetPlayerData().job == nil do
--             Citizen.Wait(10)
--         end

--         ESX.PlayerData = ESX.GetPlayerData()
--         playerJob = ESX.PlayerData.job.name
--     end)

--     RegisterNetEvent('esx:setJob')
--     AddEventHandler('esx:setJob', function(job)
--         ESX.PlayerData.job = job
--         playerJob = job.name
--     end)
-- end