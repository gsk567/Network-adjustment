function test = NearTo(checkingNumber,baseNumber,tolerance)

    test = false;
    if (checkingNumber > baseNumber-tolerance && ...
            checkingNumber < baseNumber+tolerance)
        test = true;
    end

end

