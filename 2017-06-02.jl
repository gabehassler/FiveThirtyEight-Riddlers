function aval(x::Float64, n::Int64)
  return x - x/n
end

function bval(y::Float64, n::Int64)
  return y - y/n
end

function aval2(x::Float64, n::Int64)
  n = float(n)
  return (1.0/(x * (n - 1.0))) ^ (1.0 / (n - 2.0))
end

function bval2(x::Float64, n::Int64)
  n = float(n)
  return (1.0/(x * (n - 1.0))) ^ (1.0 / (n - 2.0))
end

function go2(k::Int64)
  xs = rand(k) * 1000
  as = [aval2(xs[1], k)]
  bs = [bval2(xs[i], k) for i in 2:k]
  cuts = vcat(as, bs)
  display(cuts)
  results = -1.0 * cuts
  winner = maximum(cuts)
  i = findin(cuts, winner)
  prize = xs[i] - winner
  results[i] = prize
  return results
end

function sims2(n::Int64, k::Int64)
  t = zeros(k)
  for i in 1:n
    t += go2(k)
  end
  avg = t / n
  return avg
end


function go(k::Int64)
  xs = rand(k) * 1000
  as = [aval(xs[1], k)]
  bs = [bval(xs[i], k) for i in 2:k]
  cuts = vcat(as, bs)
  results = zeros(k)
  winner = maximum(cuts)
  i = findin(cuts, winner)
  prize = xs[i] - winner
  results[i] = prize
  return results
end


function sims(n::Int64, k::Int64)
  t = zeros(k)
  for i in 1:n
    t += go(k)
  end
  avg = t / n
  return avg
end

function biggest(n::Int64)
  a = .4
  nums = rand(n - 1)
  if a > maximum(nums)
    return 1
  else
    return 0
  end
end

function simb(i::Int64, n::Int64)
  t = 0
  for x in 1:i
    t += biggest(n)
  end
  avg = t / i
  return avg
end

function graph(n)
  xs = 1:100
  mat = zeros(100, 100)
  amax = 1 - 1/n
  for x in xs
    for a in 1:x
      mat[x, a] = (a / amax)^(n - 1) * (x - a)
    end
  end
  return mat
end

function test(x::Float64, a::Float64)
