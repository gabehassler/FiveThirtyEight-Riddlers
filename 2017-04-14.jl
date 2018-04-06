function vacate!(yr::Float64, time::Float64, bench::Array{Array{Float64, 1}, 1})
  for pair in bench
    if pair[1] == 1.0
      if yr < pair[2] <= yr + time
        pair[1] = 0.0
      end
    end
  end
end

function replace!(yr::Float64, bench::Array{Array{Float64, 1}, 1}, reps::Array{Int64})
  vac_time = 0.0
  for pair in bench
    if pair[1] == 0.0
      d_time = pair[2]
      if yr - d_time >= 0.0
        vac_time += yr - d_time
      end
      pair[1] = 1.0
      pair[2] = 40 * rand() + yr
      reps[1] = reps[1] + 1
      while pair[2] <= yr + 2.0
        pair[2] = 40 * rand() + yr
        reps[1] = reps[1] + 1
      end
    end
  end
  return vac_time
end


function fouryr!(yr::Float64, bench::Array{Array{Float64, 1}, 1}, reps::Array{Int64})
  p, s = rand([true, false], 2)
  vacate!(yr, 2.0, bench)
  vacant_time = 0.0
  if (p && s) || (!p && !s)
    vacant_time += replace!(yr, bench, reps)
  end
  yr += 2.0
  s = rand([true, false])
  vacate!(yr, 2.0, bench)
  if (p && s) || (!p && !s)
    vacant_time += replace!(yr, bench, reps)
  end
  return vacant_time
end

function simulation(admins::Int64)
  reps = [0]
  year = 0.0
  bench = [[1.0, (rand() * 40)] for i in 1:9]
  total_vacancy = 0.0
  for i in 1:admins
    total_vacancy += fouryr!(year, bench, reps)
    year += 4.0
  end
  display(bench)
  display(year)
  display(total_vacancy / reps[1])
  return total_vacancy / (admins * 4.0)
end
