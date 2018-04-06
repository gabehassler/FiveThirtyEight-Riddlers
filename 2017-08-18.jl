function series{T<:Int}(n::T)
  s = Vector([3, 3, 3, 2])
  t = time()
  for i in 2:n
    for j in 1:s[i]
      push!(s, 3)
    end
    push!(s, 2)
    if i * 100 % n == 0
      t1 = t
      t = time()
      display(i/n)
      display(t - t1)
    end
  end
  return s
end

function solve{T<:Int}(x::Vector{T})
  s = sum(x)
  l = length(x)
  M = inv([1 1; 2 3])
  V = [l, s]
  twos, threes = M * V
  return threes/twos
end

x = Vector{Float64}()
t1 = time()
t2 = time()
i = 1
while t2 - t1 < 20
  t1 = time()
  s = series(10^i)
  y = solve(s)
  push!(x, y)
  t2 = time()
  i += 1
end
display("____________________________________________")
