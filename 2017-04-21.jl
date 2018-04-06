push!(LOAD_PATH, string(pwd(), "\\Cat_v2"))

using custom

function phigh(x::Int64, n::Int64)
  p = 1.0
  for i in n:9
    p = p * (x - i)/(100-i)
  end
  return (p)
end

function determine()
  for n in 1:9
    display("----------")
    display(n)
    for x in 1:100
      p = phigh(x, n)
      pair = x => p
      display(pair)
    end
  end
end

function prob()
  p = 0.0
  d = Dict(1 => 93,
                  2 => 93,
                  3 => 92,
                  4 => 90,
                  5 => 88,
                  6 => 86,
                  7 => 82,
                  8 => 74,
                  9 => 55,
                  10 => 1)
  ps = Dict(1 => 1.0)
  for i in 2:10
    t = 0
    ps[i] = pgetto(i, d, ps)
  end
  display(ps)
  for n in 1:9
    for x in d[n]:100
      cp = ps[n] * 1.0/(101.0 - float(n)) * phigh(x, n)
      p += cp
    end
  end
  return p
end

function pgetto(n::Int64, d::Dict{Int64, Int64}, ps::Dict{Int64, Float64})
  t = 0.0
  k = d[n-1] - d[n]
  l = 10
  if k < 10
    l = k
  end
  for i in 0:l
    pio = pioverlap(i, k)
    s = pio * (1 - (101 - d[n-1] - i)/(101 - n))
    t += s
  end

  p = ps[n-1] * t
  return p
end

function pioverlap(i::Int64, k::Int64, l::Int64)
  function f(i::Int64, l::Int64)
    t = 1.0
    for x in 1:i
      t *= (l - x + 1) / (101 - x)
    end
    return t
  end
  function g(i::Int64, k::Int64, l::Int64)
    t = 1.0
    m = l
    if (k - i) < 10
      m = (k-i)
    end
    for x in 1:m
      t *= (101 - k - x)/(101 - i - x)
    end
    return t
  end
  n = 1
  small = i
  big = k - i
  if k - i < i
    small = k - i
    big = i
  end
  for x in 1:(k - big)
    n *= (k - x + 1)
  end
  n = n / factorial(float(small))
  return n * f(l, k) * g(i, k, l)
end




function sim!(data::Dict{Int64, Int64})
  nums = custom.sample_wor(collect(1:100), 10)
  max = maximum(nums)
  highest = 0
  guess_num = 0
  picked = false
  ans_dict = Dict(1 => 93,
                  2 => 93,
                  3 => 92,
                  4 => 90,
                  5 => 88,
                  6 => 86,
                  7 => 82,
                  8 => 74,
                  9 => 55)
  for n in 1:9
    if nums[n] > highest
      highest = nums[n]
      if nums[n] >= ans_dict[n]
        guess_num = n
        picked = true
        break
      end
    end
  end
  if !picked
    guess_num = 10
  end
  for i in 1:guess_num
    data[i] += 1
  end
  if nums[guess_num] == max
    return 1
  else
    return 0
  end
end

function sims(n::Int64)
  t = 0
  d = Dict(i => 0 for i in 1:10)
  for i in 1:n
    if i * 100 % n == 0
      display(i * 100 / n)
    end
    r = sim!(d)
    t += r
  end
  nd = Dict{Int64, Float64}()
  for i in keys(d)
    display(d[i])
    display(n)
    x = d[i] / n
    nd[i] = x
  end
  p = t / n
  return p, nd
end
