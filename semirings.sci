//Function: make moons
//Generate synthetic data with the form of two moons (semi-rings) in 2D space
//Arguments:
//n_samples = number of data (required argument)
//noise = size of deviation (common value is 0.1 or 0.05) - (required argument)
//depth = distance between moons. Default value is 0.1 - Optional argument
//rad_moon = radius of moons. Deafult value is 0.75. If size is specified ...
//           ...the data are not scaled in the range (-1,1).
//n_outliers = number of outlier points given in percentage (common value 5) - Optional argument
//Default value of optional arguments can be specified by a empty space ' ', e.g.,
// make_moons(1000,0.1,0.15,,5) - In this example the radius of moons is not specified, so the size of radius is the default value of 0.75
//If not radius is speficied, data are scaled in the open interval (-1,1).

function [X,y] = make_moons(n_samples,noise,depth,rad_moon,n_outliers)
  [lhs,rhs]=argn();
  //Default values
  internal_depth = 0.1;
  radius = 0.75;
  select rhs
    case 3 then
        internal_depth = depth;        
    case 4 then
        if type(depth) ~= 0 then 
            internal_depth = depth;
        end        
        radius = rad_moon;
    case 5 then
        if type(depth) ~= 0 then 
            internal_depth = depth;
        end 
        if type(rad_moon) ~= 0 then 
            radius = rad_moon;
        end        
        outliers = n_outliers;        
  end
   
  center_moons = [0,0];
  center_up   = center_moons + [-0.25,-internal_depth];
  center_down = center_moons + [0.25,internal_depth];
  
  n_samples_up = floor(n_samples / 2);
  n_samples_down = n_samples - n_samples_up ;
  
  angles_up   =  linspace(0,%pi,n_samples_up);
  angles_down =  linspace(0,-%pi,n_samples_down);
  
  moon_up_x = radius*cos(angles_up) + center_up(1); 
  moon_up_y = radius*sin(angles_up) + center_up(2);
  
  moon_down_x = radius*cos(angles_down) + center_down(1); 
  moon_down_y = radius*sin(angles_down) + center_down(2);
  
   X = [moon_up_x,moon_down_x;moon_up_y,moon_down_y]
   y = [zeros(1,n_samples_up), ones(1,n_samples_down)]

  //if shuffle then
  //  X, y = util_shuffle(X, y, random_state=generator)
  //end

  //if noise is not 'none' then
  //  X = X + generator.normal(scale=noise, size=X.shape)
  //end
  X = X + grand(2,n_samples,"unf",-noise,noise);
  //Adding Outliers
  if rhs == 5  
    n_outL = floor((n_samples*outliers)/100);
    idx = grand(1,n_outL,'uin',1,n_samples);
    X(2,idx) = grand(1,n_outL,"unf",-0.5,0.5);
    if type(rad_moon) == 0 then
      X = X./(1.01*max(abs(X))) ;  
    end    
  end
  //scale on the open interval (-1,1)
  if rhs <=3 then
      X = X./(1.01*max(abs(X))) ;
  end
  
endfunction

//Example 
/*
[X,y] = make_moons(500,0.05,0.15,,5);
for i=1:length(y)
    if y(i)== 0
        ycolors(i)='blue';
    else
        ycolors(i)='red';
    end
end
//Color is automatically specified by values in vector 'y'
//scatter(X(1,:),X(2,:),,y) 
//If you want to specify arbitrary colors, create a vector 'ycolors'
scatter(X(1,:),X(2,:),,ycolors)
*/
