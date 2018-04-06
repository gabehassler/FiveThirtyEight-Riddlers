using DataFrames, JLD

import Base.isless

function isless(a::Array{Int8, 1}, b::Array{Int8, 1})
  return false
end

function rand_gen()
  ws = rand(10)
  mult = 100.0/sum(ws)
  soldiers = mult * ws
  soldiers = convert(Array{Int8}, round(soldiers))
  dif = 100 - sum(soldiers)
  x = rand(1:10)
  while soldiers[x] + dif < 0
    x = rand(1:10)
  end
  soldiers[x] += dif
  return transpose(soldiers)
end

function guide_gen(g::Array{Int8, 1})
  ws = rand(length(g))
  for i in 1:length(ws)
    ws[i] = ws[i] * g[i]
  end
  mult = 100.0 / sum(ws)
  soldiers = mult * ws
  soldiers = convert(Array{Int8}, round(soldiers))
  dif = 100 - sum(soldiers)
  x = rand(1:10)
  while soldiers[x] + dif < 0
    x = rand(1:10)
  end
  soldiers[x] += dif
  return transpose(soldiers)
end

function assess(test::Array{Int8, 1}, others::Array{Int8, 2})
  wins = 0.0
  for i in 1:size(others, 1)
    comp = others[i, :]
    difs = test - comp
    for i in 1:length(difs)
      if difs[i] < 0
        difs[i] = -1
      elseif difs[i] > 0
        difs[i] = 1
      end
    end
    netpoints = sum([i * difs[i] for i in 1:length(difs)])
    if netpoints > 0
      wins += 1.0
    elseif netpoints == 0
      wins += .5
    end
  end
  win_perc = wins / size(others, 1)
  return win_perc
end

function reassess(bests::Array{Int8, 2}, cdata::Array{Int8, 2})
  best = bests[1, :]
  b_score = assess(best, cdata)
  records = [b_score => best]
  for i in 2:size(bests, 1)
    to_test = bests[i, :]
    score = assess(to_test, cdata)
    push!(records, score => to_test)
  end
  sort!(records, rev = true)
  records = records[1:100]
  b_score = records[1][1]
  best = records[1][2]
  best100 = transpose(best)
  for i in 2:length(records)
    to_add = transpose(records[i][2])
    best100 = vcat(best100, to_add)
  end
  return best, b_score, best100
end

function rand_strat(n::Int64)
  cdata = load("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\RandCastleVars.jld", "rand_dats")
  best100 = load("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\RandCastleVars.jld", "best100")
  new_rows = rand_gen()
  for i in 2:n
    to_test = rand_gen()
    new_rows = vcat(new_rows, to_test)
  end
  tests = vcat(new_rows, best100)
  cdata = vcat(cdata, new_rows)
  best, score, best100 = reassess(tests, cdata)
  jldopen("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\RandCastleVars.jld", "w") do file
    write(file, "rand_dats", cdata)
    write(file, "rand_best", best)
    write(file, "rand_score", score)
    write(file, "best100", best100)
  end
end

function guided_rand_strat(n::Int64)
  guide = load("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\GuidedRandCastleVars.jld", "best")
  dats = load("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\GuidedRandCastleVars.jld", "dats")
  best100 = load("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\GuidedRandCastleVars.jld", "best100")
  new_rows = guide_gen(guide)
  for i in 2:n
    guided = guide_gen(guide)
    new_rows = vcat(new_rows, guided)
  end
  for i in 1:n
    randed = rand_gen()
    new_rows = vcat(new_rows, randed)
  end
  tests = vcat(best100, new_rows)
  dats = vcat(dats, new_rows)
  best, score, best100 = reassess(tests, dats)
  jldopen("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\GuidedRandCastleVars.jld", "w") do file
    write(file, "dats", dats)
    write(file, "best", best)
    write(file, "score", score)
    write(file, "best100", best100)
  end
  display(best)
end


function rand_setup()
  dats = [10 10 10 10 10 10 10 10 10 10]
  dats = convert(Array{Int8, 2}, dats)
  for i in 2:100
    new_row = rand_gen()
    dats = vcat(dats, new_row)
  bscore = 1.0
  best = transpose(dats)
  save("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\RandCastleVars.jld", "rand_dats", dats, "rand_best", best, "rand_score", bscore, "best100", dats)
  end
end

function guided_rand_setup()
  dats = [10 10 10 10 10 10 10 10 10 10]
  dats = convert(Array{Int8, 2}, dats)
  for i in 2:100
    new_row = rand_gen()
    dats = vcat(dats, new_row)
  best = dats[1, :]
  bscore = 1.0
  save("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\GuidedRandCastleVars.jld", "dats", dats, "best", best, "score", bscore, "best100", dats)
  end
end


function setup()
  cdata = readtable("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\CastleData.txt", separator = ',')
  cdata = cdata[1:10]
  cdata = convert(Array{Int8}, cdata)
  best = [3, 5, 8, 10, 13, 1, 26, 30, 2, 2]
  best = convert(Array{Int8, 1}, best)
  bscore = assess(best, cdata)
  save("C:\\Users\\gabeh\\OneDrive\\Documents\\Programming\\Riddlers\\CastleVars.jld", "data", cdata, "best", best, "bscore", bscore)
end
