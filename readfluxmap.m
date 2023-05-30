clear all

%   which rotation rate?
casename='r20'; 

%   read in latitude points
infile=['latitude_fluxmap_',casename,'.txt'];
data=dlmread(infile);
latitude = data(2,:);   %   in degree
num_lat = length(latitude);

%   read in longitude points
infile=['longitude_fluxmap_',casename,'.txt'];
clear data;
data=dlmread(infile);
longitude = data(2,:);  %   in degree
num_long=length(longitude);

%   read in output times 
infile=['timeout_hour_fluxmap_',casename,'.txt'];
clear data;
data=dlmread(infile);
time_hour = data(2,:);  
num_time = length(time_hour);

%   read in the flux map
infile=['fluxmap_',casename,'.txt'];
clear data;
data=dlmread(infile);
fluxmap=zeros(num_long,num_lat,num_time);  
nn=0;
for j=1:num_lat %   loop over latitude
    for i=1:num_long %  loop over longitude
        nn = nn+1;
        fluxmap(i,j,:) = squeeze(data(nn,3:end)); %  put flux in (starting from the 3rd number at each line
    end
end

%   plot
ntime_plot = 1;
figure
contourf(longitude,latitude,squeeze(fluxmap(:,:,ntime_plot))','LineColor','none');
h = colorbar;
set(gca,'fontsize',14);
xlabel('Longitude [degree]');ylabel('Latitude [degree]');
title(h,'Wm^{-2}');
title(['case ',casename,' at time ',num2str(time_hour(ntime_plot),'%.1f'),' hour']);

