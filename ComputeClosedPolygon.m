function [numbers,coordsX,coordsY,fb,fbAllowable,fx,fy,fs,fsAllowable] = ComputeClosedPolygon(data)

    dataLength = length(data(:,1));
    while (data(1,8) == -1)
        data(dataLength+1,:) = data(1,:);
        data(1,:) = [];
    end
    numbers = data(:,1);
    numbers = [numbers(2:dataLength);numbers(1)];
    
    betas = data(:,4) - data(:,5);
    for i = 1:1:length(betas)
       if (betas(i) < 0)
           betas(i) = betas(i) + 400;
       end
    end

    
    if (NearTo(sum(betas),(dataLength-2)*200,10) == true)
        betas = 400 - betas;
        calOutside = true;
    else
        betas = 400 - betas;
        calOutside = false;
    end

    alphaStart = data(1,8) + data(1,5);  
    
    if (alphaStart > 400)
        alphaStart = alphaStart - 400;
    end
    
    if (calOutside == true)
        fb = sum(betas) - (dataLength+2)*200;
    elseif (calOutside == false)
        fb = sum(betas) - (dataLength-2)*200;
    end
    
    
    fbAllowable = 0.015*sqrt(dataLength);
    correctionToBetas = fb/dataLength;
    correctedBetas = betas - correctionToBetas;
    
    alphas = alphaStart;
    if (alphas > 400)
        alphas = alphas - 400;
    end
 
	for i = 2:1:dataLength
        currAlpha = correctedBetas(i) + alphas(i-1);
        if (currAlpha >= 600)
            currAlpha = currAlpha - 600;
        elseif (currAlpha < 200)
            currAlpha = currAlpha + 200;
        elseif (currAlpha > 200)
            currAlpha = currAlpha - 200;
        end
        alphas(i) = currAlpha;
    end

    for i = 1:1:dataLength
       deltaX(i,:) = data(i,7)*cos(alphas(i)/(200/pi));
       deltaY(i,:) = data(i,7)*sin(alphas(i)/(200/pi));
    end
    
    fx = sum(deltaX);
    fy = sum(deltaY);
    fs = sqrt(fx^2 + fy^2);
    fsAllowable = 0.1 + 0.015*sqrt(sum(data(:,7))/1000);
    
    for i = 1:1:dataLength
       deltaX(i,1) = deltaX(i,1) - fx*(data(i,7)/sum(data(:,7)));
       deltaY(i,1) = deltaY(i,1) - fy*(data(i,7)/sum(data(:,7)));
    end
    
    coordsX = data(1,9) + deltaX(1);
    coordsY = data(1,10) + deltaY(1);
    for i = 2:1:dataLength
        coordsX(i,1) = coordsX(i-1,1) + deltaX(i);
        coordsY(i,1) = coordsY(i-1,1) + deltaY(i);
    end

end

