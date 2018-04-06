function weights(n::Int64)
  vals = collect(1:n)
  s = sum(vals)
  un_rounded = 100/s * vals
  x = round(un_rounded)
  scaler = [1/a for a in 1:n]
  M = diagm(scaler)
  y = M * x
  return x, y
end

a = [2 * n - 1 for n in 1:10]
b = [a[n] + 1 for n in 1:10]
