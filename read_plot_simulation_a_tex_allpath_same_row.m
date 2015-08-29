texture=['ran2000.txt';
        'Cube111.txt';
        'Copper1.txt';
        'S111111.txt';
         'Brass11.txt';
        'Goss111.txt';
        'Textuin.txt'];

    BC_name='BC_Nov30th2013_1';
load_type={'RDT00';'PSR00';'BB000';'PST00';'TDT00'};

%     BC_name='BC_Dec242013_ihardctrl3';
% load_type={'1';   '2';   '3';   '4';   '5';   '6';   '7';   '8';   '9';  '10';...
%             '11';  '12';  '13';  '14';  '15';  '16';  '17';  '18';  '19';  '20';  '21'}; %for near plane strain


% load_type=['RDT00';'PSRm1';'PSRm0';'PSR00';'BB000';'PST00';'PSTm0';'PSTm1';'TDT00'];

color_p={[0 0 0],[1 0 0],[0 0 1],[0 0.5 0],[0.5 0 0.5],[1 0 1],[0 1 0],[0 0 0.5]}; %black, red, blue, cyan, green, magenta

% label={'AR';'U-11';'PS-11';'EB';'PS-22';'U-22'};
label={'U-11';'PS-11';'EB';'PS-22';'U-22'};
tex_label=  {'Random';'Cube';'Copper';'S';'Brass';'Goss';'AA5754-O'};  

int=[1:0.01:5]; % intensity of scale bar
color_scale=[1,5];

tex=7;
cd(['D:\CMU-NIST\AA5754\BC\',BC_name]);
%     copyfile('D:\CMU-NIST\Matlab\BC_DOE/plottex.m')
run=1; %latent hardening run
name='TEX_PH1.cmh';

slice_1st=0; % this is used instead of load_ind to control sub_figue id to deal with near plane explorations

figure
fig_sub=tight_subplot(6,6,[0.01 0.005],[0.01 0.12],[0.1 0.01]);%2x3,0 and 0 gap btw subplot, 0.03 top and 0.04 bottom gaps, 0.1 gap on left, 0.05 on right
set(gcf,'position',[ 38    28   753   758]);

for load_ind=[1:3]%[1,6,11]%1:length(load_type) %for different loading condition
slice_1st=slice_1st+1;
    cd(['D:\CMU-NIST\AA5754\BC\',BC_name,'\',...
        texture(tex,1:7),'\',num2str(run),'\',load_type{load_ind}]) % for PhamHP
    
fid=fopen(name); % Reading smoothed cod file
m=1;
for n=1:19
smooth_tex{m}= textscan(fid,'%6f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f',...
'HeaderLines',2);
for o=1:19
dummy_tex{m}(:,o)=smooth_tex{m}{1,o}(:);
end
m=m+1;
textscan(fid,'%s',1);
end
fclose(fid);
for n=1:19
odf{load_ind}(:,:,n)=dummy_tex{1,n};
end

% plottex(load_type{load_ind},odf{load_ind},int,color_scale);

%%To plot all odf along five strain paths in the same figure
%  set(gcf,'position',[ 5   287   358   279]);
x=1:17; y=1:17; z=1:17;
sl=1;
for p=1:6
    phi_2=15*(p-1);
    slice_pos(p)=sl;
axes(fig_sub(p+6*slice_1st-6));
axis square
position(p,1:4)=get(gca,'position');
% slice1=slice(odf/100,1,1,slice_pos(p),'method','cubic');
slice1=contourslice(odf{load_ind}/100,1,1,slice_pos(p),int);
set(slice1,'linewidth',4)
set(gca,'linewidth',4)

caxis(color_scale) %color scale
set(gca,'XTick',linspace(1,19,7))
set(gca,'YTick',linspace(1,19,7))
set(gca,'TickLength',[0.05 0.03])

if load_ind==1&&p==1
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    set(gca,'XAxisLocation','top')
    colorbar('location','NorthOutside')
    annotation('arrow',[0.03, 0.18],[0.96,0.96],'linewidth',3) %arrow in x dir
    annotation('arrow',[0.03, 0.03],[0.96,0.77],'linewidth',3)
    xlabel('$\varphi_1$','Interpreter','Latex','FontSize',16,'fontweight','b')
    set(gca,'XTick',linspace(1,19,7))
    set(gca,'XTickLabel',0:15:90)
    ylabel('$\Phi$','Interpreter','Latex','FontSize',16,'fontweight','b')
    set(gca,'YTick',linspace(1,19,7))
    set(gca,'YTickLabel',0:15:90)
else
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
end
% set(slice1,'linewidth',5)
set(gca,'Ydir','reverse')
box on

if p==1
        text(7,16,17,label{slice_1st},'FontSize',14,'fontweight','b')
end

if load_ind==1
    text(8,4,17,['($\varphi_2$=',num2str(phi_2),'$\textsuperscript{o}$)'],...
    'Interpreter','Latex','FontSize',14,'fontweight','b')%,'Color','r')%,...
end

axis([1 19 1 19])
set(gca,'FontSize',10,'fontweight','b')

 sl=sl+3;
shading('interp');
end

color_gray=[0.6 0.6 0.6; 0.4 0.4 0.4; 0.9 0.9 0; 0 1 0;0 0.7 0; ...
            0 0.4 0; 0 0 1; 0 0 0.8; 0 0 0.6; 0.5 0 0;.8 0 0;  1 0 0];
colormap(color_gray)

% colormap(hsv)
end %for different loading condition
% saveas(gcf,'collection.fig')
% saveas(gcf,'collection.tif')
% 
% for load_ind=1:length(load_type) %for different loading condition
%     figure(load_ind);
% saveas(gcf,[load_type{load_ind},'.fig'])
% saveas(gcf,[load_type{load_ind},'.tif'])
% end
