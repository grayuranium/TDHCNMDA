function [result] = casestudy(A,sd,sm,mir_name)
% three case studies
%   {'Breast Neoplasms'}(50),{'Colorectal Neoplasms'}(93) and {'Lung Neoplasms'}(236)
[score]=H2DGCNMDA(A,sm,sd,4,1,1,0,2);

colon_res = score(50,:);
[~,score_index]=sort(colon_res);
score_index = fliplr(score_index);
colon_res = mir_name(score_index(1:50));

kidney_res = score(93,:);
[~,score_index]=sort(kidney_res);
score_index = fliplr(score_index);
kidney_res = mir_name(score_index(1:50));

lymphoma_res = score(236,:);
[~,score_index]=sort(lymphoma_res);
score_index = fliplr(score_index);
lymphoma_res = mir_name(score_index(1:50));

result = [colon_res kidney_res lymphoma_res];
end

