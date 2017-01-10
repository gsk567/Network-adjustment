function collimationError = CollimationError(direction1, direction2)

	if (direction1 < direction2)
        collimationError = (direction1 - (direction2 - 200))/2;
    else
        collimationError = (direction1 - (direction2 + 200))/2;
	end

end

