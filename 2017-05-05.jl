function race()
  probs = 0.52:0.02:0.90
  h_loc = Dict(p => 0 for p in probs)
  while !(200 in values(h_loc))
    for p in probs
      x = rand()
      if x <= p
        h_loc[p] += 1
      else
        h_loc[p] -= 1
      end
    end
  end
  winners = Vector{Float64}()
  for k in keys(h_loc)
    if h_loc[k] == 200
      push!(winners, k)
    end
  end
  return winners
end

function races(n::Int64)
  probs = 0.52:0.02:0.90
  w_dict = Dict(p => 0.0 for p in probs)
  for i in 1:n
    if i * 100 % n == 0
      println(i*100 / n, "% complete")
    end
    ws = race()
    l = float(length(ws))
    for p in ws
      w_dict[p] += 1.0/l
    end
  end
  ks = sort(collect(keys(w_dict)))
  N = float(n)
  for k in ks
    w_dict[k] = w_dict[k] / N
  end
  disp = collect(w_dict)
  sort!(disp)
  display(disp)
end
