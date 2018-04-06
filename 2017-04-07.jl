function d1p2less(x::Int64)
  y = (-2 * x^3 + 27 * x^2 - 25 * x)/504
  return y
end

function sample_wor{T<:AbstractArray}(a::T, n::Int64)
  assert(n <= length(a))
  a_cop = deepcopy(a)
  results = Vector()
  for i in 1:n
    index = rand(1:length(a_cop))
    push!(results, a_cop[index])
    deleteat!(a_cop, index)
  end
  return results
end

function sim()
  l = collect(0:9)
  nums = sample_wor(l, 4)
  a = false
  b = false
  c = false
  d = false
  A = ' '
  B = ' '
  C = ' '
  D = ' '
  #Draw 1 starts here
  if nums[1] <= 4
    a = true
    A = nums[1]
  else
    b = true
    B = nums[1]
  end
  #Draw 2 starts here
  if a||c #draw 1 is in the 10's col
    if nums[1] < nums[2]
      if nums[2] <= 3
        c = true
        C = nums[2]
      else
        d1s = false
        d2b = false
        if nums[2] > 6
          d2b = true
        end
        if nums[1] <= 2
          d1s = true
        end
        if (d1s && d2b) || (!d1s && !d2b)
          d = true
          D = nums[2]
        else
          b = true
          B = nums[2]
        end
      end
    else
      if nums[2] <= 4
        c = true
        C = nums[2]
      else
        assert(true == false)
      end
    end
  else #draw 1 is in the 1's col
    if nums[1] < nums[2]
      if nums[2] <= 6
        a = true
        A = nums[2]
      else
        d = true
        D = nums[2]
      end
    else
      if nums[2] <= 5
        d2s = false
        d1b = false
        if nums[2] <= 2
          d2s = true
        end
        if nums[1] > 6
          d1b = true
        end
        if (d1b && d2s) || (!d1b && !d2s)
          c = true
          C = nums[2]
        else
          a = true
          A = nums[2]
        end
      else
        d = true
        D = nums[2]
      end
    end
  end
  #Draw 3 starts here
  if (a||c) & (b||d) #If there's 1 in the 10's and 1 in the 1's
    if (nums[1] < nums[3]) && (nums[2] < nums[3])
      if nums[3] <= 5
        if a
          c = true
          C = nums[3]
        else
          a = true
          A = nums[3]
        end
      else
        if b
          d = true
          D = nums[3]
        else
          b = true
          B = nums[3]
        end
      end
    elseif ((nums[1] < nums[3]) && (nums[2] > nums[3])) || ((nums[1] > nums[3]) && (nums[2] < nums[3]))
      if nums[3] <= 4
        if a
          c = true
          C = nums[3]
        else
          a = true
          A = nums[3]
        end
      else
        if b
          d = true
          D = nums[3]
        else
          b = true
          B = nums[3]
        end
      end
    else
      if nums[3] <= 3
        if a
          c = true
          C = nums[3]
        else
          a = true
          A = nums[3]
        end
      else
        if b
          d = true
          D = nums[3]
        else
          b = true
          B = nums[3]
        end
      end
    end
  elseif a && c #if both 10's are occupied
    s = sort(nums[1:3])
    d3b = false
    Ab = true
    if nums[3] == s[3]
      if nums[3] > 5
        d3b = true
      end
    elseif nums[3] == s[2]
      if nums[3] > 4
        d3b = true
      end
    else
      if nums[3] > 3
        d3b = true
      end
    end
    if A > C
      Ab = true
    end
    if (d3b && Ab) && (!d3b && !Ab)
      b = true
      B = nums[3]
    else
      d = true
      D = nums[3]
    end
  else
    s = sort(nums[1:3])
    d3b = false
    Bb = false
    if nums[3] == s[3]
      if nums[3] > 5
        d3b = true
      end
    elseif nums[3] == s[2]
      if nums[3] > 4
        d3b = true
      end
    else
      if nums[3] > 3
        d3b = true
      end
    end
    if B > D
      Bb = true
    end
    if (d3b && Bb) && (!d3b && !Bb)
      a = true
      A = nums[3]
    else
      c = true
      C = nums[3]
    end
  end
  #Draw 4 starts here
  if !a
    a = true
    A = nums[4]
  elseif !b
    b = true
    B = nums[4]
  elseif !c
    c = true
    C = nums[4]
  else
    d = true
    D = nums[4]
  end
  x = (10 * A + B) * (10 * C + D)
  return x
end

function rsim()
  l = collect(0:9)
  nums = sample_wor(l, 4)
  product = (nums[1] * 10 + nums[2]) * (nums[3] * 10 + nums[4])
  return product
end

function sims(n::Int64)
  total = 0
  for i in 1:n
    total += sim()
  end
  return total / n
end

function rsims(n::Int64)
  total = 0
  for i in 1:n
    total += rsim()
  end
  return total / n
end
