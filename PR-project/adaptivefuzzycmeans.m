function[Ifc,CI, M, oM] = adaptivefuzzycmeans(I,k,Tn, cc)

% This program illustrates the Fuzzy c-means segmentation of an image. 
% Author: Krishna Kumar
%I - input image
%k - no. of clusters required
%Ifc - fuzzy clustering output image
%C - final cluster centers
%Tn - Number of itrations
%sample usage:
%I = imread('cameraman.tif');
%[Ifc,C] = fuzzycmeans(I,4,15)
%--------------------------------------------------------------
I=double(I);
[H,W]=size(I);
Icm = zeros(H,W);
IC = [];
for i=1:k
    IC=cat(3,IC,I);
end

%Random initialization of cluster centers

TFcm=0;
%-----------------------------------------------------------------

while(TFcm<Tn)
    c=[];
    R = [];
    tmp = [];
    P = [];
    D=zeros(H,W,1);
    ic = c;
  for i=1:k  
    U=repmat(cc(i),H,W);
    c=cat(3,c,U);
  end
  
  for i=1:k
    r=repmat(0.000001,H,W);
    R=cat(3,R,r);
  end
   
    distance=IC-c;
    distance=distance.*distance+R;
    
    dS=1./distance;
    
    for i=1:k
        D = D + dS(:,:,i);
    end
    
    for i=1:k
        % normalized distance
        dist(:,:,i)=distance(:,:,i).*D;
        Q(:,:,i)=1./dist(:,:,i);
    end
    
    M = zeros(H,W,k);
    for i = 1 : k
        M(:, :, i) = Q(:,:,i).*Q(:,:,i);
    end
    oM = M;
    
    B = zeros(k, 1);
    for i = 1 : k
        B(i) = cc(i) / sum(sum(M(:, :, i)));
    end
    
%     NB = zeros(k, 1);
%     for i = 1 : k
%         NB(i) = 1 / sum(sum(M(:, :, i)));
%     end    
    
    NB = B ./ sum(B);
    
    for i=1:k        
        e = B(i) - NB(i);
%          disp(mean(mean(M(:, :, i))));
%         mean(mean(0.1 * cc(i) * e))
        
        M(:, :, i) = M(:, :, i) + 0.1 * e * cc(i);
        CI(i) = sum(sum(M(:, :, i).*I))/sum(sum(M(:, :, i)));
    end
    
    
    
    for i=1:k
     tmp = cat(3,tmp,abs(cc(i)-CI(i))/cc(i));
    end
    
    for i=1:k
      P = cat(3,P,Q(:,:,i));
    end
    
    for i=1:H
        for j=1:W
            for l=1:k
                if max(P(i,j,:))==Q(i,j,l)
                    Icm(i,j)=l;
                end
            end
        end
    end
 %------------------------------------------------------------------
   if TFcm > 3 & max(tmp) < 0.0001
         break;
  else
   cc = CI;       %updating cluster centers
  end

%----------------------------------------
 
Ifc=uint8(Icm);

TFcm=TFcm+1;

end%end of while loop


end