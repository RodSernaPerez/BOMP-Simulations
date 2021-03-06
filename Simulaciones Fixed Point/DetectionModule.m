function I=DetectionModule(x,D,A,nActiveBlocks,int_fp,dec_fp)
%   DETECTIONMODULE: returns the indices of the non-null blocks
%   DetectionModule(y,D,A,nActiveBlocks) returns the indices of the
%   non-null blocks from the signal x, where D is the matrix whose rows
%   show which samples contain each block, A is the matrix used for
%   sampling and nActiveBlocks is the number of non-null blocks

    %Gets the matrix which will sum the correlation of the coloumns which
    %belong to the same block
    SumingMatrix=zeros(size(D,1),size(A,2));
    for i=1:size(SumingMatrix,1)
        SumingMatrix(i,D(i,:))=1;
    end
    
    % Multiplies both matrices to convert it into an unique operation
    S=SumingMatrix*A';
    
    % Computes the score of each block
    S_fp=convertToFixPoint(S,int_fp,dec_fp);
    x_fp=convertToFixPoint(x,int_fp,dec_fp);
    score_of_blocks=S_fp*x_fp;
    
    % Selects the indices of the blocks which score higher
    I=zeros(1,nActiveBlocks);
    for j=1:nActiveBlocks
        [~,i]=max(score_of_blocks);
        I(j)=i;
        
    end

end