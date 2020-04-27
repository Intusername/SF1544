function retval = exactbweuler(t,h,M,vm,g,d,id)
  n = t/h; %Number of iteration points
  carPos = [];
  carPos(:,1)=id*(1:M); % Initial positions for each car
  for i = 1:n
      carPos(M,i+1)=carPos(M,i)+h.*g; 
      for j=M-1:-1:1
          %Calculating position for all except first care in queue
          if abs(carPos(j,i)-carPos(j+1,i))>d
              carPos(j,i+1)=carPos(j,i)+h*vm;
          %Calculating position of first car in queue    
          else             
              carPos(j,i+1)=1/(1+(h*vm) /d)*...
              carPos(j,i)+1/(1+d/(h*vm))*carPos(j +1, i+1);
          end
      end
  end
  retval = carPos;
end
