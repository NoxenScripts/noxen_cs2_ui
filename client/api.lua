API = {}

function API.SetScoreTeam1(score)
    CS2_UI.TopScoresTeam1 = score
end

function API.SetScoreTeam2(score)
    CS2_UI.TopScoresTeam2 = score
end

function API.SetTeam(team)
    CS2_UI.CurrentTeam = team
end

function API.AddKill()
    CS2_UI.PlayKillAnimation()
end

function API.ResetKills()
    CS2_UI.Kills = 0
end

function API.Toggle()
    CS2_UI.Toggle()
end

exports('SetScoreTeam1', API.SetScoreTeam1)
exports('SetScoreTeam2', API.SetScoreTeam2)
exports('SetTeam', API.SetTeam)
exports('AddKill', API.AddKill)
exports('ResetKills', API.ResetKills)
exports('Toggle', API.Toggle)