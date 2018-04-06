using JLD, BenchmarkTools

function parse_games()
    cd("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers")
    file = open("NCAA.txt")
    lines = readlines(file)
    close(file)
    n = length(lines)
    dates = Array{Date}(n)
    teams = Array{String}(n, 2)
    for i = 1:n
        line = lines[i]
        year = parse(line[1:4])
        month = parse(line[6:7])
        day = parse(line[9:10])
        team1 = strip(line[13:36])
        team2 = strip(line[42:65])
        dates[i] = Date(year, month, day)
        teams[i, 1:2] = [team1, team2]
    end
    save("ParsedNCAA.jld", "dates", dates, "teams", teams)
end

function get_teams_list(teams::Array{String, 2})
    list = union(teams[:, 1], teams[:, 2])
    list = union(list, list)
    return list
end


#THIS FUNCTION ACTUALLY FINDS THE TRANSITIVE CHAMPIONS
function find_champions(team::String, teams::Array{String, 2}, champions::Array{String, 1})
    games_lost = findin(teams[:, 2], [team]) #finds the indices for the games the team lost
    new_champs = teams[:, 1][games_lost] #gets the team names of the winners of those games
    actually_new = setdiff(new_champs, champions) #ensures that you haven't already accounted for any of the winners
    champions = vcat(champions, actually_new) #merges the previous champions with the new ones
    for champ in actually_new
        new_champs = find_champions(champ, teams, champions) #recursively finds the teams that beach each new transitive champ
        champions = union(champions, new_champs)
    end
    return champions
end

println("Parsing")
parse_games()
d = load("ParsedNCAA.jld")
date = d["dates"]
teams = d["teams"]
teams_list = get_teams_list(teams)
champions = ["Villanova"]
champions = find_champions("Villanova", teams, champions)
println("Number of Teams that are NOT Champions or Transitive Champions:")
println(length(teams_list) - length(champions))
display(@benchmark find_champions("Villanova", teams, champions))
