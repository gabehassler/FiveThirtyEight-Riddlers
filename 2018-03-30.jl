struct Card
    color::Int
    value::Int
end

global deck = Array{Card, 1}()
for color = 1:2
    for value = 1:13
        for i = 1:2
            push!(deck, Card(color, value))
        end
    end
end

function draw_cards()
    order = randperm(52)
    first_pass = deck[order[1:7]]
    second_pass = deck[order[8:15]]
    return first_pass, second_pass
end

function legal_move(card1::Card, card2::Card)
    if card1.color == card2.color
        return false
    elseif abs(card1.value - card2.value) == 1
        return true
    else
        return false
    end
end

function check_first_pass(cards::Array{Card, 1})
    for i = 1:6
        for j = (i + 1):7
            if legal_move(cards[i], cards[j])
                return false
            end
        end
    end
    return true
end

function check_second_pass(cards1::Array{Card, 1}, cards2::Array{Card, 1})
    for card1 in cards1
        for card2 in cards2
            if legal_move(card1, card2)
                return false
            end
        end
    end
    return true
end

function impossible_game()
    top_cards, deck_cards = draw_cards()
    if check_first_pass(top_cards)
        if check_second_pass(top_cards, deck_cards)
            return 1
        end
    end
    return 0
end

function simulate_games(n::Int)
    total = 0
    for i = 1:n
        total += impossible_game()
    end
    return total / n
end


function approx()
    product = 1
    for i = 1:(21 + 56)
        product = product * (1279 - i) / (1327 - i)
    end
    return product
end
