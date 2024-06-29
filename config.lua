Config = {}

Config.Jobs = {
    'police',
    'ambulance',
    'mechanic'
}

Config.offJobs = {
    'offpolice',
    'offambulance',
    'offmechanic'
}

Config.Ped = { 
    {
        model = 's_f_y_cop_01',
        job = 'police',
        coords = vec4(428.12, -978.63, 29.71, 87.29),
        manageGrade = 0  --grade od którego można restartować godziny
    },
    {
        model = 'mp_f_bennymech_01',
        job = 'mechanic',
        coords = vec4(428.34, -980.28, 29.71, 94.74),
        manageGrade = 0  --grade od którego można restartować godziny
    },
    {
        model = 's_m_m_scientist_01',
        job = 'ambulance',
        coords = vec4(428.39, -981.94, 29.71, 90.78),
        manageGrade = 0  --grade od którego można restartować godziny
    }
}