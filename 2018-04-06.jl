using JLD

function parse_games()
    cd("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers")
    file = open("NCAA.txt")
    lines = readlines(file)
    close(file)
    n = length(lines)
    dates = Array{Date}(n)
    teams = Array{String}(n, 2)
    scores = Array{Int64}(n, 2)
    for i = 1:n
        line = lines[i]
        year = parse(line[1:4])
        month = parse(line[6:7])
        day = parse(line[9:10])
        team1 = strip(line[13:36])
        score1 = parse(line[37:39])
        team2 = strip(line[42:65])
        score2 = parse(line[66:68])
        dates[i] = Date(year, month, day)
        teams[i, 1:2] = [team1, team2]
        scores[i, 1:2] = [score1, score2]
    end
    save("ParsedNCAA.jld", "dates", dates, "teams", teams, "scores", scores)
end

function get_teams_list(teams::Array{String, 2})
    list = union(teams[:, 1], teams[:, 2])
    list = union(list, list)
    return list
end

function find_champions(team::String, teams::Array{String, 2}, scores::Array{Int64, 2}, champions::Array{String, 1})
    games_lost = findin(teams[:, 2], [team])
    new_champs = teams[:, 1][games_lost]
    actually_new = setdiff(new_champs, champions)
    champions = vcat(champions, actually_new)
    for champ in actually_new
        new_champs = find_champions(champ, teams, scores, champions)
        champions = union(champions, new_champs)
    end
    return champions
end


parse_games()
d = load("ParsedNCAA.jld")
date = d["dates"]
teams = d["teams"]
scores = d["scores"]
teams_list = get_teams_list(teams)
champions = ["Villanova"]
champs = find_champions("Villanova", teams, scores, champions)
