function settle_score(n, s)
    -- Need to add a condition for checking whether
    -- this tile gives ocean access on both sides, so
    -- that the city could essentially act as a canal
    -- through the land.
    print(n)
    print(s)
    local score = 0

    if n == 0 then
        score = 88877
    else if n == 1 then
        score = 11
    else
        score = 51
    end

    if s > 0 then
        print("Made it here")
        score = 1000
    end

    print(score)

    end return score

end
