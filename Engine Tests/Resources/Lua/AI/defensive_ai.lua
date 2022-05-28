function settle_score(n, s)
    -- print(n)
    print(s)
    local score = 0

    if n == 0 then
        score = 10
    else if n == 1 then
        score = 11
    else
        score = 51
    end

    if s > 0 then
        print("Made it here in ai settle_score")
        score = 1000
    end

    -- print(score)

    end return score
end
