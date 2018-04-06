function purge()
  houses = [100 for i in 1:1000]
  for n in 1:1000
    x = rand(1:1000)
    while x == n
      x = rand(1:1000)
    end
    houses[n] += houses[x]
    houses[x] = 0
  end
  return houses
end

function sims(n::Int64)
  results = zeros(Int64, 1000)
  zs = 0
  for i in 1:n
    x = purge()
    zs += 1000 - countnz(x)
    results += x
  end
  return results / n, zs / n
end
