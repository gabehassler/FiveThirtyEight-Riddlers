function lunch()
  t1, t2 = rand(2)
  if abs(t2 - t1) <= 0.25
    return 1
  else
    return 0
  end
end

sims = 100000
tot = 0
for i in 1:sims
  tot += lunch()
end

display(tot / sims)
