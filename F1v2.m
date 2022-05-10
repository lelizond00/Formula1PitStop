% FORMULA 1 DRY RACE TYRE SIMULATION, ONE AND TWO PITSTOPS

% UNIVERSAL SETUP
clear
clc

format longG
figure('units','normalized','outerposition',[0 0 .8 .8]);
e=2.718281828459045235360287471352;

% Parameters 
LAPS = 55;
PITSTOPTIME=20;
SOFTOPTIMALDRYLAPTIME = 80.00;
MEDIUMOPTIMALDRYLAPTIME = 80.80;
HARDOPTIMALDRYLAPTIME = 81.80;

TRACKTEMPERATURE=(0);
TEMPERATUREDEGRADATION=(-cos(TRACKTEMPERATURE/100)+1);

% Use to see the shape of the curve created by this
% TRACKTEMPERATURE=(0:35) % Choose one value from 0 to 35, add 30 to find
% simulated temperature in Cº
% TEMPERATUREDEGRADATION=(-cos(TRACKTEMPERATURE/100)+1)
% plot(TEMPERATUREDEGRADATION)

SOFTTYREDEGRADATIONCOEFFICIENT = 0.05+TEMPERATUREDEGRADATION*1;
for i=1:LAPS
    SOFTDRYLAP(i,1)=e^(SOFTTYREDEGRADATIONCOEFFICIENT*i)+SOFTOPTIMALDRYLAPTIME-1;
end


MEDIUMTYREDEGRADATIONCOEFFICIENT = 0.025+TEMPERATUREDEGRADATION*0.66;
for i=1:LAPS
    MEDIUMDRYLAP(i,1)=e^(MEDIUMTYREDEGRADATIONCOEFFICIENT*i)+MEDIUMOPTIMALDRYLAPTIME-1;
end


HARDTYREDEGRADATIONCOEFFICIENT = 0.01+TEMPERATUREDEGRADATION*0.33;
for i=1:LAPS
    HARDDRYLAP(i,1)=e^(HARDTYREDEGRADATIONCOEFFICIENT*i)+HARDOPTIMALDRYLAPTIME-1;
end

%% Section One Stop

% ONE STOP SIMULATION

    % plot(MOTHERMATRIX(:,y));
    % plot(SUMOFTIME);

% SOFT | HARD
MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
            SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
end

minimumoptimalonepitstop = min(min(SUMOFTIME));
[x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
softhardstorage=[y,minimumoptimalonepitstop];

% HARD | SOFT 
MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
            SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
end

minimumoptimalonepitstop = min(min(SUMOFTIME));
[x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
hardsoftstorage=[y,minimumoptimalonepitstop];

% SOFT | MEDIUM
MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
            SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
end

minimumoptimalonepitstop = min(min(SUMOFTIME));
[x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
softmediumstorage=[y,minimumoptimalonepitstop];

% MEDIUM | SOFT 
MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
            SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
end

minimumoptimalonepitstop = min(min(SUMOFTIME));
[x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
mediumsoftstorage=[y,minimumoptimalonepitstop];

% MEDIUM | HARD
MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
            SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
end

minimumoptimalonepitstop = min(min(SUMOFTIME));
[x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
mediumhardstorage=[y,minimumoptimalonepitstop];

% HARD | MEDIUM 
MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
            SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
end

minimumoptimalonepitstop = min(min(SUMOFTIME));
[x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
hardmediumstorage=[y,minimumoptimalonepitstop];

onestopstoragetimetotal=zeros(6,1);
onestopstoragetimetotal(1)=softhardstorage(1,end);
onestopstoragetimetotal(2)=hardsoftstorage(1,end);
onestopstoragetimetotal(3)=softmediumstorage(1,end);
onestopstoragetimetotal(4)=mediumsoftstorage(1,end);
onestopstoragetimetotal(5)=mediumhardstorage(1,end);
onestopstoragetimetotal(6)=hardmediumstorage(1,end);

bestonestrategytime = min(min(onestopstoragetimetotal));
[x,y]=find(onestopstoragetimetotal==bestonestrategytime);

if x==[1,2]' | x==1 | x==2

                    % SOFT | HARD
                    MOTHERMATRIX = zeros(LAPS,LAPS);
                    
                    for i=1:LAPS
                        MOTHERMATRIX(:,i)=SOFTDRYLAP;
                            MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
                                SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
                    end
                    
                    minimumoptimalonepitstop = min(min(SUMOFTIME));
                    [x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
                    softhardstorage=[y,minimumoptimalonepitstop];
                    
                    plot(MOTHERMATRIX(:,y));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal One Stop Strategy','Interpreter','latex','FontSize',30);
                    hold;
                    
                    % HARD | SOFT 
                    MOTHERMATRIX = zeros(LAPS,LAPS);
                    
                    for i=1:LAPS
                        MOTHERMATRIX(:,i)=HARDDRYLAP;
                            MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
                                SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
                    end
                    
                    minimumoptimalonepitstop = min(min(SUMOFTIME));
                    [x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
                    hardsoftstorage=[y,minimumoptimalonepitstop];

                    plot(MOTHERMATRIX(:,y));
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Soft - Hard','Hard - Soft','Interpreter','latex','FontSize',29);
                    legend('location','southeast');
clc
disp('Optimal One Stop Strategy: Soft & Hard Tyre Combination')
MESSAGEa = ['Soft Tyre Start, Pit into Hard Tyres in Lap ' num2str(softhardstorage(1,1))];
disp(MESSAGEa)
MESSAGEb = ['Hard Tyre Start, Pit into Soft Tyres in Lap ' num2str(hardsoftstorage(1,1))];
disp(MESSAGEb)

else
    if x==[3,4]' | x==3 | x==4

                    % SOFT | MEDIUM
                    MOTHERMATRIX = zeros(LAPS,LAPS);
                    
                    for i=1:LAPS
                        MOTHERMATRIX(:,i)=SOFTDRYLAP;
                            MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
                                SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
                    end
                    
                    minimumoptimalonepitstop = min(min(SUMOFTIME));
                    [x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
                    softmediumstorage=[y,minimumoptimalonepitstop];
                    
                    plot(MOTHERMATRIX(:,y));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal One Stop Strategy','Interpreter','latex','FontSize',30);
                    hold;
    
                    % MEDIUM | SOFT 
                    MOTHERMATRIX = zeros(LAPS,LAPS);
                    
                    for i=1:LAPS
                        MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
                            MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
                                SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
                    end
                    
                    minimumoptimalonepitstop = min(min(SUMOFTIME));
                    [x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
                    mediumsoftstorage=[y,minimumoptimalonepitstop];
                    
                    plot(MOTHERMATRIX(:,y));
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Soft - Medium','Medium - Soft','Interpreter','latex','FontSize',29);
                    legend('location','southeast');
clc
disp('Optimal One Stop Strategy: Soft & Medium Tyre Combination')
MESSAGEa = ['Soft Tyre Start, Pit into Medium Tyres in Lap ' num2str(softmediumstorage(1,1))];
disp(MESSAGEa)
MESSAGEb = ['Medium Tyre Start, Pit into Soft Tyres in Lap ' num2str(mediumsoftstorage(1,1))];
disp(MESSAGEb)

    else
        if x==[5,6]' | x==5 | x==6

                    % MEDIUM | HARD
                    MOTHERMATRIX = zeros(LAPS,LAPS);
                    
                    for i=1:LAPS
                        MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
                            MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
                                SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
                    end
                    
                    minimumoptimalonepitstop = min(min(SUMOFTIME));
                    [x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
                    mediumhardstorage=[y,minimumoptimalonepitstop];
        
                    plot(MOTHERMATRIX(:,y));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal One Stop Strategy','Interpreter','latex','FontSize',30);
                    hold;
        
                    % HARD | MEDIUM 
                    MOTHERMATRIX = zeros(LAPS,LAPS);
                    
                    for i=1:LAPS
                        MOTHERMATRIX(:,i)=HARDDRYLAP;
                            MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
                                SUMOFTIME(1,i)=sum(MOTHERMATRIX(:,i));
                    end
                    
                    minimumoptimalonepitstop = min(min(SUMOFTIME));
                    [x,y]=find(SUMOFTIME==minimumoptimalonepitstop);
                    hardmediumstorage=[y,minimumoptimalonepitstop];
        
                    plot(MOTHERMATRIX(:,y));
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Medium - Hard','Hard - Medium','Interpreter','latex','FontSize',29);
                    legend('location','southeast');
clc
disp('Optimal One Stop Strategy: Medium & Hard Tyre Combination')
MESSAGEa = ['Medium Tyre Start, Pit into Hard Tyres in Lap ' num2str(mediumhardstorage(1,1))];
disp(MESSAGEa)
MESSAGEb = ['Hard Tyre Start, Pit into Medium Tyres in Lap ' num2str(hardmediumstorage(1,1))];
disp(MESSAGEb)

        end
    end
end
hold off;

%% Section Two Stop

% TWO STOP SIMULATION

ys=zeros(LAPS,1);

% SSM SSH %

    % SSM %
    MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end

for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
%                 ys creates a matrix with two columns, column 1
%                 corresponds to the optimal lap for pitting for softs
%                 after having pitted for hards. The row # tells you when
%                 the car pitted first for hards, so row 5 is for the
%                 outcome when the car pitted for hards in lap 5. The value
%                 of the first column is then the best lap number to pit
%                 a second time (this time for softs), and the number on
%                 the right corresponds to the race time for that given
%                 optimal scenario in seconds
             
end

minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);

% the value in row xz correponds to the optimal lap for a SECOND pit stop
%   the actual row where xz is corresponds to the optimal lap time for the
%   FIRST pitstop

secondpitwindow=ys(xz,1); %Here we index the row number, as per above
minimumtwopitstopcomplete(1,1:3)=["SSM",minimumtwopitstop,1];

    % SSH %
    MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end

for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end

minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);

secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(2,1:3)=["SSH",minimumtwopitstop,2];

% SMS SMM SMH %

    % SMS %
    MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end

for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=SOFTDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;             
end

minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);

secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(3,1:3)=["SMS",minimumtwopitstop,3];

    % SMM %
    MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end

for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;         
end

minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);

secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(4,1:3)=["SMM",minimumtwopitstop,4];

    % SMH %
    MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end

for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end

minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);

secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(5,1:3)=["SMH",minimumtwopitstop,5];

    % SHS SHM SHS %
  % SHS %
    MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end

for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=SOFTDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end

minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);

secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(6,1:3)=["SHS",minimumtwopitstop,6];

  % SHM %
    MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end

for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end

minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);

secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(7,1:3)=["SHM",minimumtwopitstop,7];

 % SHH %
    MOTHERMATRIX = zeros(LAPS,LAPS);

for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end

for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end

minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);

secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(8,1:3)=["SHH",minimumtwopitstop,8];


    % MSS MSM MSH
    % MSS %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=SOFTDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(9,1:3)=["MSS",minimumtwopitstop,9];

    % MSM %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(10,1:3)=["MSM",minimumtwopitstop,10];

    % MSH %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(11,1:3)=["MSH",minimumtwopitstop,11];
    
    % MMS MMH %
    % MMS %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=SOFTDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(12,1:3)=["MMS",minimumtwopitstop,12];

    % MMH %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(13,1:3)=["MMH",minimumtwopitstop,13];

    % MHS MHM MHH
    % MHS %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=SOFTDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(14,1:3)=["MHS",minimumtwopitstop,14];

 % MHM %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(15,1:3)=["MHM",minimumtwopitstop,15];

 % MHH %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(16,1:3)=["MHH",minimumtwopitstop,16];

    % HSS HSM HSH %
    % HSS %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=SOFTDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(17,1:3)=["HSS",minimumtwopitstop,17];

    % HSM %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(18,1:3)=["HSM",minimumtwopitstop,18];

    % HSH %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(19,1:3)=["HSH",minimumtwopitstop,19];

    % HMS HMM HMH
    % HMS %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=SOFTDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(20,1:3)=["HMS",minimumtwopitstop,20];

% HMM %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(21,1:3)=["HMM",minimumtwopitstop,21];

% HMH %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(22,1:3)=["HMH",minimumtwopitstop,22];

% HHS %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=SOFTDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(23,1:3)=["HHS",minimumtwopitstop,23];

% HHM %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=HARDDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(24,1:3)=["HHM",minimumtwopitstop,24];

minimumtwopitstopcompletenumber=double(minimumtwopitstopcomplete);

minimumminimumtwopitstop=min(min(minimumtwopitstopcompletenumber(:,2)));
[xz2,yz2]=find(minimumtwopitstopcompletenumber==minimumminimumtwopitstop);


if xz2 == 1|3|9;

    %SSM
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1);
minimumtwopitstopcomplete(1,1:2)=["SSM",minimumtwopitstop];
  for i=1:LAPS;
        OPTIMALTWOSTOP(:,i)=MOTHERMATRIX(:,xz(1,1));
           OPTIMALTWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                OPTIMALSUMOFTIME2(1,i)=sum(OPTIMALTWOSTOP(:,i))+PITSTOPTIME;
    end
    minimumoptimaltwopitstop = min(min(OPTIMALSUMOFTIME2));
        [xoptimal,yoptimal]=find(OPTIMALSUMOFTIME2==minimumoptimaltwopitstop);

figure('units','normalized','outerposition',[0 0 .8 .8]);plot((OPTIMALTWOSTOP(:,yoptimal)));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal Two Stop Strategy','Interpreter','latex','FontSize',30);
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Soft - Soft - Medium','Interpreter','latex','FontSize',29);
                    legend('location','southeast');

    elseif xz2 == 2|6|17;
%SSH
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=SOFTDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1) %Here we index the row number, as per above
minimumtwopitstopcomplete(2,1:2)=["SSH",minimumtwopitstop];
  for i=1:LAPS;
        OPTIMALTWOSTOP(:,i)=MOTHERMATRIX(:,xz);
           OPTIMALTWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                OPTIMALSUMOFTIME2(1,i)=sum(OPTIMALTWOSTOP(:,i))+PITSTOPTIME;
    end
    minimumoptimaltwopitstop = min(min(OPTIMALSUMOFTIME2));
        [xoptimal,yoptimal]=find(OPTIMALSUMOFTIME2==minimumoptimaltwopitstop);

figure('units','normalized','outerposition',[0 0 .8 .8]);plot((OPTIMALTWOSTOP(:,yoptimal)));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal Two Stop Strategy','Interpreter','latex','FontSize',30);
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Soft - Soft - Hard','Interpreter','latex','FontSize',29);
                    legend('location','southeast');

    elseif xz2 == 4|10|12;

%SMM
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1); %Here we index the row number, as per above
minimumtwopitstopcomplete(4,1:2)=["SMM",minimumtwopitstop];
  for i=1:LAPS
        OPTIMALTWOSTOP(:,i)=MOTHERMATRIX(:,xz);
           OPTIMALTWOSTOP(i+2:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i-1],1);
                OPTIMALSUMOFTIME2(1,i)=sum(OPTIMALTWOSTOP(:,i))+PITSTOPTIME;
    end
    minimumoptimaltwopitstop = min(min(OPTIMALSUMOFTIME2));
        [xoptimal,yoptimal]=find(OPTIMALSUMOFTIME2==minimumoptimaltwopitstop);

figure('units','normalized','outerposition',[0 0 .8 .8]);plot((OPTIMALTWOSTOP(:,yoptimal)));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal Two Stop Strategy','Interpreter','latex','FontSize',30);
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Soft - Medium - Medium','Interpreter','latex','FontSize',29);
                    legend('location','southeast');

elseif xz2 == 5|7|11|14|18|20;

%SMH
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1); %Here we index the row number, as per above
minimumtwopitstopcomplete(5,1:2)=["SMH",minimumtwopitstop];
  for i=1:LAPS;
        OPTIMALTWOSTOP(:,i)=MOTHERMATRIX(:,xz);
           OPTIMALTWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                OPTIMALSUMOFTIME2(1,i)=sum(OPTIMALTWOSTOP(:,i))+PITSTOPTIME;
    end
    minimumoptimaltwopitstop = min(min(OPTIMALSUMOFTIME2));
        [xoptimal,yoptimal]=find(OPTIMALSUMOFTIME2==minimumoptimaltwopitstop);

figure('units','normalized','outerposition',[0 0 .8 .8]);plot((OPTIMALTWOSTOP(:,yoptimal)));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal Two Stop Strategy','Interpreter','latex','FontSize',30);
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Soft - Medium - Hard','Interpreter','latex','FontSize',29);
                    legend('location','southeast');

elseif xz2 == 8|19|23;

% SHH %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=SOFTDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1) ;
minimumtwopitstopcomplete(8,1:3)=["SHH",minimumtwopitstop,8];
for i=1:LAPS;
        OPTIMALTWOSTOP(:,i)=MOTHERMATRIX(:,xz);
           OPTIMALTWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                OPTIMALSUMOFTIME2(1,i)=sum(OPTIMALTWOSTOP(:,i))+PITSTOPTIME;
    end
    minimumoptimaltwopitstop = min(min(OPTIMALSUMOFTIME2));
        [xoptimal,yoptimal]=find(OPTIMALSUMOFTIME2==minimumoptimaltwopitstop);

figure('units','normalized','outerposition',[0 0 .8 .8]);plot((OPTIMALTWOSTOP(:,yoptimal)));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal Two Stop Strategy','Interpreter','latex','FontSize',30);
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Soft - Hard - Hard','Interpreter','latex','FontSize',29);
                    legend('location','southeast');

elseif xz2 == 13|15|21;
    % MMH %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=MEDIUMDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1) ;
minimumtwopitstopcomplete(13,1:3)=["MMH",minimumtwopitstop,13];
for i=1:LAPS;
        OPTIMALTWOSTOP(:,i)=MOTHERMATRIX(:,xz);
           OPTIMALTWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                OPTIMALSUMOFTIME2(1,i)=sum(OPTIMALTWOSTOP(:,i))+PITSTOPTIME;
    end
    minimumoptimaltwopitstop = min(min(OPTIMALSUMOFTIME2));
        [xoptimal,yoptimal]=find(OPTIMALSUMOFTIME2==minimumoptimaltwopitstop);

figure('units','normalized','outerposition',[0 0 .8 .8]);plot((OPTIMALTWOSTOP(:,yoptimal)));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal Two Stop Strategy','Interpreter','latex','FontSize',30);
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Medium - Medium - Hard','Interpreter','latex','FontSize',29);
                    legend('location','southeast');

elseif xz2 == 16|22|24;
 % MHH %
    MOTHERMATRIX = zeros(LAPS,LAPS);
for i=1:LAPS;
    MOTHERMATRIX(:,i)=MEDIUMDRYLAP;
        MOTHERMATRIX(i:LAPS,i)=HARDDRYLAP(1:[LAPS-i+1],1);
end
for j=1:LAPS;
    for i=1:LAPS;
        TWOSTOP(:,i)=MOTHERMATRIX(:,j);
           TWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                SUMOFTIME2(1,i)=(sum(TWOSTOP(:,i))+PITSTOPTIME);
    end
    minimum = min(min(SUMOFTIME2));
        [x2,y2]=find(SUMOFTIME2==minimum);
                ys(j,1)=y2(1,1);
                ys(j,2)=minimum;
end
minimumtwopitstop=min(min(ys(:,2)));
[xz,yz]=find(ys==minimumtwopitstop);
secondpitwindow=ys(xz,1) ;
minimumtwopitstopcomplete(16,1:3)=["MHH",minimumtwopitstop,16];
for i=1:LAPS;
        OPTIMALTWOSTOP(:,i)=MOTHERMATRIX(:,xz);
           OPTIMALTWOSTOP(i+2:LAPS,i)=HARDDRYLAP(1:[LAPS-i-1],1);
                OPTIMALSUMOFTIME2(1,i)=sum(OPTIMALTWOSTOP(:,i))+PITSTOPTIME;
    end
    minimumoptimaltwopitstop = min(min(OPTIMALSUMOFTIME2));
        [xoptimal,yoptimal]=find(OPTIMALSUMOFTIME2==minimumoptimaltwopitstop);

figure('units','normalized','outerposition',[0 0 .8 .8]);plot((OPTIMALTWOSTOP(:,yoptimal)));
                    set(gca,'FontName','latex','FontSize',20);
                    title('Optimal Two Stop Strategy','Interpreter','latex','FontSize',30);
                    xlabel('Lap','Interpreter','latex','FontSize',29);
                    ylabel('Lap Time (sec)','Interpreter','latex','FontSize',29)
                    legend('Medium - Hard - Hard','Interpreter','latex','FontSize',29);
                    legend('location','southeast');
end

%% Section 3

if minimumoptimaltwopitstop < bestonestrategytime
    MessageAA = ['Overall Optimal Strategy: Two Pit Stops. Gap to One Stop = ' num2str(bestonestrategytime-minimumoptimaltwopitstop) ' seconds'];
    disp(MessageAA);
else
   MessageBB = ['Overall Optimal Strategy: One Pit Stop. Gap to Two Stop = ' num2str(minimumoptimaltwopitstop-bestonestrategytime) ' seconds'];
   disp(MessageBB);
end