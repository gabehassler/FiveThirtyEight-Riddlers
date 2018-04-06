function bathroom{T<:Int}(i::T)
  occupied = rand([true, false], i)
  person = rand([1, 2, 3], i)
  sign = Vector{Bool}()
  for n in 1:1
    if occupied[n]
      if person[n] == 1
        push!(sign, true)
      elseif person[n] == 2
        push!(sign, true)
      else
        push!(sign, rand([true, false]))
      end
    else
      push!(sign, rand([true, false]))
    end
  end
  for n in 2:i
    if occupied[n]
      if person[n] == 1
        push!(sign, true)
      elseif person[n] == 2
        push!(sign, true)
      else
        if occupied[n-1] & person[n-1] == 1
          push!(sign, false)
        else
          push!(sign, sign[n-1])
        end
      end
    else
      if occupied[n-1]
        if person[n-1] == 1
          push!(sign, false)
        else
          push!(sign, sign[n-1])
        end
      else
        push!(sign, sign[n-1])
      end
    end
  end
  OO = 0
  OV = 0
  VO = 0
  VV = 0
  for n in 1:i
    if occupied[n] & sign[n]
      OO += 1
    elseif occupied[n] & !sign[n]
      OV += 1
    elseif !occupied[n] & sign[n]
      VO += 1
    elseif !occupied[n] & !sign[n]
      VV += 1
    end
  end
  # @time for n in 1:1
  #   wons = ones(i)
  #   Occ = hcat(occupied, wons - occupied)
  #   Sig = hcat(sign, wons - sign)
  #   A = Occ' * Sig
  # end
  said_occupied = sum(sign)
  said_vacant = i - said_occupied
  display("If the sign says 'occupied':")
  Po = OO/said_occupied
  Pv = VO / said_occupied
  x = [Po Pv]
  display(string("Po: ", Po))
  display(string("Pv: ", Pv))
  display("If the sign says 'vacant'")
  Po = OV / said_vacant
  Pv = VV / said_vacant
  x = vcat(x, [Po Pv])
  display(string("Po: ", Po))
  display(string("Pv: ", Pv))
  return x, hcat(occupied, person, sign)
end

function bathroom2{T<:Int}(i::T)
  
