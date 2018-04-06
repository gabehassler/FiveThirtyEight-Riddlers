push!(LOAD_PATH, string(pwd(), "\\Cat_v2"))
using custom

function chaos(N::Int64)
  players = Vector(collect(1:N))
  active = Set{Int64}(players)
  sitting = Set{Int64}()
  tag_dict = Dict{Int64, Set{Int64}}(x => Set{Int64}() for x in players)
  turn = 0
  while length(active) > 1
    ter, ted = custom.sample_wor(active, 2)
    delete!(active, ted)
    active = union(active, tag_dict[ted])
    tag_dict[ted] = Set{Int64}()
    push!(tag_dict[ter], ted)

    turn += 1
    # display(active)
    # display(tag_dict)
    # sleep(2)
  end
  return turn
end

function sims(n::Int64, N::Int64)
  total = 0
  for i in 1:n
    total += chaos(N)
  end
  avg = total / n
  return avg
end
