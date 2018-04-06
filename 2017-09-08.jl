#simulates a game of war (the card game)

push!(LOAD_PATH, string(pwd(), "\\Cat_v2"))

using custom

cards = Array{Pair{Int64, Int64}}([])
for s in 1:4
  for v in 1:13
    p = Pair(v, s)
    push!(cards, p)
  end
end

function dist!{T<:Vector{Pair{Int64, Int64}}}(w::T, l::T, i::Int64)
  A = w[1:i]
  B = l[1:i]
  deleteat!(w, 1:i)
  deleteat!(l, 1:i)
  for j in 1:i
    push!(w, A[j])
    push!(w, B[j])
  end
end

function one_round{T<:Vector{Pair{Int64, Int64}}}(p1::T, p2::T)
  i = 1
  min = minimum([length(p1), length(p2)])
  while i <= min && p1[i][1] == p2[i][1]
    i += 2
  end
  if i <= min
    a = p1[i][1]
    b = p2[i][1]
    assert(a != b)
    A = p1[1:i]
    B = p2[1:i]
    if a > b
      dist!(p1, p2, i)
    elseif a < b
      dist!(p2, p1, i)
    end
  else
    if p1[min][1] != p2[min][1]
      a = p1[min][1]
      b = p2[min][1]
      A = p1[1:min]
      B = p2[1:min]
      if a > b
        dist!(p1, p2, min)
      elseif a < b
        dist!(p2, p1, min)
      else
        assert(1 == 2)
      end
    else
      p1 = custom.sample_wor(p1, length(p1))
      p2 = custom.sample_wor(p2, length(p2))
    end
  end
  return p1, p2
end

function game{T<:Vector{Pair{Int64, Int64}}}(p1::T, p2::T)
  min = minimum([length(p1), length(p2)])
  N = 0
  while min > 0 && N < 1000
    assert(N < 1000)
    N += 1
    # display(p1)
    # display(p2)
    # display("----------------------------")
    p1, p2 = one_round(p1, p2)
    min = minimum([length(p1), length(p2)])
  end
  # display(N)
  # display(length(p1))
  # display(length(p2))
  # display("____________________________________")
  # if !(length(p1) == 0 || length(p2) == 0)
  #   display(p1)
  #   display(p2)
  # end
  # display(p1)
  # display(p2)
  # display("_____________________________")
  if length(p1) == 0
    return 0.0
  elseif length(p2) == 0
    return 1.0
  else
    return 0.5
    display("_____________")
  end
end

function sims(n::Int64)
  total = 0.0
  for i in 1:n
    if i * 1000 % n == 0
      display(i * 100 / n)
    end
    p1 = Array{Pair{Int64, Int64}}([])
    p2 = Array{Pair{Int64, Int64}}([])
    for s in 1:4
      for v in 1:12
        p = Pair(v, s)
        push!(p2, p)
      end
      p = Pair(13, s)
      push!(p1, p)
    end
    p2 = custom.sample_wor(p2, length(p2))
    total += game(p1, p2)
  end
  avg = total / n
  display(avg)
  return avg
end
