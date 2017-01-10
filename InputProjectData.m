function [projectName,mR,mSa,mSb] = InputProjectData()

    prompt = {'Enter Project Name:','Enter Direction A priori value(mR)[cc]:', ...
        'Enter Distance A priori(A + b[S]):','Enter Distance A priori(a + B[S]):'};
    dlgTitle = 'Input';
    numLines = 1;
    defaultValues = {'New Project','20','5','5'};
    inputData = inputdlg(prompt,dlgTitle,numLines,defaultValues);

    projectName = inputData{1};
    mR = str2double(inputData{2});
    mSa = str2double(inputData{3});
    mSb = str2double(inputData{4});

end

