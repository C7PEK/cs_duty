local ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    while true do
        Wait(60000)
        for _, id in pairs(GetPlayers()) do
            local xTarget = ESX.GetPlayerFromId(id)

            if xTarget then
                local counter = false
                for k, v in pairs(Config.Jobs) do
                    if xTarget.job.name == v then
                        counter = true
                    end
                end

                if counter == true then
                    MySQL.Async.fetchAll('SELECT * FROM czaspracy WHERE identifier = @identifier AND job = @job', {
                        ['@identifier'] = xTarget.identifier,
                        ['@job'] = xTarget.job.name
                    }, function(result)
                        if #result > 0 then
                            MySQL.Async.execute('UPDATE czaspracy SET time = time + 1 WHERE identifier = @identifier AND job = @job', {
                                ['@identifier'] = xTarget.identifier,
                                ['@job'] = xTarget.job.name
                            })
                        else
                            MySQL.Async.execute('INSERT INTO czaspracy VALUES (@identifier, @job, @time)', {
                                ['@identifier'] = xTarget.identifier,
                                ['@job'] = xTarget.job.name,
                                ['@time'] = 1
                            })
                        end
                    end)
                end
            end
        end
    end
end)

ESX.RegisterServerCallback('cs_duty:sprawdzczas', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM czaspracy WHERE identifier = @identifier AND job = @job', {
            ['@identifier'] = xPlayer.identifier,
            ['@job'] = xPlayer.job.name
        }, function(result)
            if #result > 0 then
                cb(result[1].time)
            else
                cb(0)
            end
        end)
    end
end)

RegisterServerEvent('cs_duty:sprawdzczas', function(job)
    local _source = source
    local players = {}
    MySQL.Async.fetchAll('SELECT * FROM czaspracy WHERE job = @job', {
        ['@job'] = job
    }, function(result)
        if #result > 0 then
            for k, v in pairs(result) do
                MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
                    ['@identifier'] = v.identifier
                }, function(res)
                    if #res > 0 then
                        table.insert(players, {name = res[1].firstname..' '..res[1].lastname, identifier = v.identifier, time = math.floor(v.time/60)})
                    end
                end)
            end
        end
    end)
    Wait(500)
    TriggerClientEvent('cs_duty:listagraczy', _source, players)
end)

RegisterServerEvent('cs_duty:resetczas', function(identifier, job)
    MySQL.Async.execute('UPDATE czaspracy SET time = 0 WHERE identifier = @identifier AND job = @job', {
        ['@identifier'] = identifier,
        ['@job'] = job
    })
end)

RegisterServerEvent('cs_duty:onoff')
AddEventHandler('cs_duty:onoff', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    
    if job == 'police' or job == 'ambulance' or job == 'mechanic'then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('ox_lib:notify', _source, {title= 'Informacja', description ='Zakończyłeś Służbę', position = 'center-left',type ='success'})
    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('ox_lib:notify', _source, {title= 'Informacja', description ='Zaczołeś Służbę', position = 'center-left',type ='success'})
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        TriggerClientEvent('ox_lib:notify', _source, {title= 'Informacja', description ='Zaczołeś Służbę', position = 'center-left',type ='success'})
    elseif job == 'offmechanic' then
        xPlayer.setJob('mechanic', grade)
        TriggerClientEvent('ox_lib:notify', _source, {title= 'Informacja', description ='Zaczołeś Służbę', position = 'center-left',type ='success'})
    end

end)