local ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    for k, v in pairs(Config.Ped) do
        modelHash = GetHashKey(v.model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(0)
        end
        local ped = CreatePed(1, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, false)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityCanBeDamaged(ped, false)

        exports['qtarget']:AddTargetEntity(ped, {
            options = {
                {
                    label = 'Zakończ Służbę',
                    icon = 'fas fa-clock',
                    job = v.job,
                    event = 'cs_duty:sluzba'
                },
                {
                    label = 'Sprawdź liczbę godzin',
                    icon = 'fas fa-clock',
                    job = v.job,
                    action = function()
                        ESX.TriggerServerCallback('cs_duty:sprawdzczas', function(time)
                            time = (time/60)
                            time = math.floor(time)

                            lib.notify({
                                title = 'Informacja',
                                description = 'Na służbie spędziłeś '..time..' godziny',
                                icon = 'clock',
                                iconAnimation = 'beat',
                                position = 'center-left'
                            })

                        end)
                    end
                },
                {
                    label = 'Zarządzaj godzinami',
                    icon = 'fas fa-clock',
                    job = {[v.job] = v.manageGrade},
                    action = function()
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'zarzadzaj_godzinami', {
                            title = 'Zarządzaj godzinami',
                            align = 'right',
                            elements = {
                                {label = 'Lista Pracowników', value = 'pracownik'}
                            }
                        }, function(data, menu)
                            menu.close()
                            if data.current.value == 'pracownik' then
                                TriggerServerEvent('cs_duty:sprawdzczas', ESX.GetPlayerData().job.name)
                            end
                        end, function(data, menu)
                            menu.close()
                        end)
                    end
                }
            },
            distance = 3.0
        })

        exports['qtarget']:AddTargetEntity(ped, {
            options = {
                {
                    label = 'Zacznij Służbę',
                    icon = 'fas fa-clock',
                    job = Config.offJobs,
                    event = 'cs_duty:sluzba'
                }
            },
            distance = 3.0
        })
        
    end
end)

RegisterNetEvent('cs_duty:listagraczy', function(players)
    local elements = {}
    for k, v in pairs(players) do
        table.insert(elements, {label = v.name..' - '..v.time..' godzin', value = v.identifier})
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'zarzadzaj_godzinami_lista', {
        title = 'Zarządzaj godzinami',
        align = 'right',
        elements = elements
    }, function(data, menu)
        menu.close()
        TriggerServerEvent('cs_duty:resetczas', data.current.value, ESX.GetPlayerData().job.name)

        lib.notify({
            title = 'Informacja',
            description = 'Czas został zresetowany!',
            type = 'success',
            position = 'center-left'
        })

    end, function(data, menu)
        menu.close()
    end)
end)

RegisterNetEvent('cs_duty:sluzba')
AddEventHandler('cs_duty:sluzba', function()
    TriggerServerEvent('cs_duty:onoff')
end)