function coffee(people::Array{Float64})
  l = length(people)
  r = rand(l)
  paired = [rand[n] => people[n] for n in 1:l]
  paired = sort(paired)
  scrambled = [x[i][2] for i in paired]
  pot = 1.0
  n = 1
  drank = Array{}
  while pot > 0.0
    pot -= scrambled[n]
    n += 1
