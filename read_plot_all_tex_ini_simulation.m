texture=['ran2000.txt';
        'Cube111.txt';
        'Copper1.txt';
        'S111111.txt';
         'Brass11.txt';
        'Goss111.txt';
        'Textuin.txt'];
BC_name='BC_Nov18th2014';   
% BC_name='BC_July25th2013_1';
% load_type={'AR.COD';'UNI15.COD';'PS15.COD';'BB15.COD';'PS15_TD.COD';'UNI15_TD.COD'};
load_type={'RDT';'PSR';'BBT';'PST';'TDT'};

%load_type=['RDT00';'PSRm1';'PSRm0';'PSR00';'BB000';'PST00';'PSTm0';'PSTm1';'TDT00'];

color_p={[0 0 0],[1 0 0],[0 0 1],[0 0.5 0],[0.5 0 0.5],[1 0 1],[0 1 0],[0 0 0.5]}; %black, red, blue, cyan, green, magenta

label={'U-11';'PS-11';'EB';'PS-22';'U-22'};
tex_label=  {'Random';'Cube';'Copper';'S';'Brass';'Goss'};  

% latent={'COL=2.5','COP=GL=2.5','H=2.5','LC=2.5','COL=COP=GL=H=LC=2.5','SELF'};

latent={'COL=25','COP=GL=25','H=25','LC=25','COL=COP=GL=H=LC=25','SELF'};

        max_int=50;
        int=[0.3:1:max_int]; % intensity of scale bar
    
color_scale=[0.3,max_int];

    step=20; % Options for deformation steps

for run=[4,6]    
figure
run_total=0;
i_run=0;
label_ind=0;
    copyfile('D:\CMU-NIST\Matlab\BC_DOE\tight_subplot.m')
fig_sub=tight_subplot(6,6,[0.01 0.005],[0.01 0.10],[0.08 0.01]);%2x3,0 and 0 gap btw subplot, 0.03 top and 0.04 bottom gaps, 0.1 gap on left, 0.05 on right
set(gcf,'position',[ 38    28   753   758]);

for tex=1:6
label_subfig{tex}=[['(a',num2str(tex),')'];['(b',num2str(tex),')'];['(c',num2str(tex),')'];['(d',num2str(tex),')'];...
    ['(e',num2str(tex),')'];['(f',num2str(tex),')']];
    
cd('D:\CMU-NIST\Matlab for VPSC\Common texture figures')
name=[texture(tex,1:8),'cod'];
fid=fopen(name); % Reading smoothed cod file

m=1;
for n=1:19
smooth_tex{m}= textscan(fid,'%5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f',...
'HeaderLines',2);
for o=1:19
dummy_tex{m}(:,o)=smooth_tex{m}{1,o}(:);
end
m=m+1;
textscan(fid,'%s',1);
end
fclose(fid);
for n=1:19
odf_initial{tex}(:,:,n)=dummy_tex{1,n};
end

    
%%%----------plotting initial texture-------------
if tex==3
%     sl=8;
    sl=8;
elseif tex==4
    sl=10;
elseif tex==5||tex==6
%     sl=10;
    sl=10;
else
    sl=1;    
end
    phi_2=5*(sl-1);
    
    axes(fig_sub(tex+run_total));

axis square
position(1:4)=get(gca,'position');
set(gca,'position',[position(1) position(2)+0.04 position(3) position(4)])
% slice1=slice(odf/1000,1,1,slice_pos(p),'method','cubic');
if tex==2%||tex==6
%     slice1=contourslice(smooth3(odf_initial{tex})/1000,[],[],sl,int);
    slice1=contourslice(smooth3(odf_initial{tex},'box',1)/1000,[],[],sl,int);
    axis([1 19 1 19 1 19])
    view([0 0 1])
elseif tex>=3&&tex<=6
    slice1=contourslice(smooth3(odf_initial{tex},'box',1)/1000,[],sl,[],int);
    view([0 -1 0])
%     slice1=contourslice(smooth3(odf_initial{tex},'box',1)/1000,[],[],sl,int);
%     view([0 0 1])
    axis([1 19 1 19 1 19])
%     slice1=slice((smooth3(odf_initial{tex},'box',1))/1000,[],9,[],'nearest');
else
    slice1=contourslice(smooth3(odf_initial{tex},'box',1)/1000,[],[],sl,int);
    axis([1 19 1 19 1 19])
        view([0 0 1])

end

daspect([1 1 1]);
set(slice1,'linewidth',3)

caxis(color_scale) %color scale
set(gca,'XTick',linspace(1,19,7))
set(gca,'YTick',linspace(1,19,7))
set(gca,'ZTick',linspace(1,19,7))
set(gca,'TickLength',[0.05 0.03])

    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    set(gca,'zticklabel',[])
    set(gca,'XAxisLocation','top')
    
    if tex==1
    annotation('arrow',[0.01, 0.18],[0.96,0.96],'linewidth',3) %arrow in x dir
    annotation('arrow',[0.01, 0.01],[0.96,0.77],'linewidth',3)
    xlabel('$\varphi_1$','Interpreter','Latex','FontSize',16,'fontweight','b')
    set(gca,'XTick',linspace(1,19,7))
    set(gca,'XTickLabel',0:15:90)

    elseif tex==2
        colorbar('location','NorthOutside')
    end

    ylabel('$\Phi$','Interpreter','Latex','FontSize',16,'fontweight','b')
    zlabel('$\varphi_2$','Interpreter','Latex','FontSize',16,'fontweight','b')    
    set(gca,'YTick',linspace(1,19,7))
    set(gca,'YTickLabel',0:15:90)
    set(gca,'ZTick',linspace(1,19,7))
    set(gca,'ZTickLabel',0:15:90)
    
% set(slice1,'linewidth',5)
set(gca,'Ydir','reverse')
set(gca,'Zdir','reverse')
box on

        text(7,16,17,tex_label{tex},'FontSize',14,'fontweight','b')

    if tex>=3&&tex<=5
        text(4,10,4,['($\Phi$=',num2str(phi_2),'$\textsuperscript{o}$)'],...
    'Interpreter','Latex','FontSize',18,'fontweight','b')
    else
        text(4,10,17,['($\varphi_2$=',num2str(phi_2),'$\textsuperscript{o}$)'],...
        'Interpreter','Latex','FontSize',18,'fontweight','b')%,'Color','r')%,...
    end

set(gca,'FontSize',10,'fontweight','b')
    text(4,4,4,label_subfig{tex}(1,:),'FontSize',14,'fontweight','b','background','white')

%%%-------Done for plotting initial texture--------------

i_run=i_run+1;
    label_ind=label_ind+1;
 for load_ind=1:length(load_type) %for different loading condition
     run_total=run_total+1;
%             cd(['D:\CMU-NIST\AA5754\BC\',BC_name,'\',...
%         texture(tex,1:7),'\',num2str(run),'\Step_',num2str(step),'\',load_type{load_ind}]) % for PhamHP

%% ************Reading simulated textures*************
cd(['D:\CMU-NIST\AA5754\BC\',BC_name,'\',...
        texture(tex,1:7),'\',num2str(run),'\',load_type{load_ind}]) % for PhamHP

name='TEX_PH1_20.cod';
fid=fopen(name); % Reading smoothed cod file

m=1;
for n=1:19
% smooth_tex{m}= textscan(fid,'%4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f',...
% 'HeaderLines',2);
smooth_tex{m}= textscan(fid,'%5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f %5f',...
'HeaderLines',2);
for o=1:19
dummy_tex{m}(:,o)=smooth_tex{m}{1,o}(:);
end
m=m+1;
textscan(fid,'%s',1);
end
fclose(fid);
for n=1:19
odf{run_total}(:,:,n)=dummy_tex{1,n};
end
%% ************Reading simulated textures-Done*************

%%
% plottex(load_type{load_ind},odf{load_ind},int,color_scale);

%%To plot all odf along five strain paths in the same figure
%  set(gcf,'position',[ 5   287   358   279]);
x=1:17; y=1:17; z=1:17;


p=i_run
    slice_pos(p)=sl;
axes(fig_sub(tex+run_total));
axis square
position(1:4)=get(gca,'position');
set(gca,'position',[position(1) position(2)+0.04 position(3) position(4)])
% slice1=slice(odf/1000,1,1,slice_pos(p),'method','cubic');

if tex==2%||tex==6
    slice1=contourslice(smooth3(odf{run_total},'box',1)/1000,[],[],slice_pos(p),int);
    axis([1 19 1 19 1 19])
    view([0 0 1])
elseif tex>=3&&tex<=6
    slice1=contourslice(smooth3(odf{run_total},'box',1)/1000,[],slice_pos(p),[],int);
    view([0 -1 0])
%      view([0 0 1])
%      slice1=contourslice(smooth3(odf{run_total},'box',1)/1000,[],[],slice_pos(p),int);
    axis([1 19 1 19 1 19])
else
    slice1=contourslice(smooth3(odf{run_total},'box',1)/1000,[],[],slice_pos(p),int);
    axis([1 19 1 19 1 19])
        view([0 0 1])

end

daspect([1 1 1]);
set(slice1,'linewidth',3)


% if tex==1
%     caxis(color_scale/10) %color scale
% else
caxis(color_scale) %color scale
% end

set(gca,'XTick',linspace(1,19,7))
set(gca,'YTick',linspace(1,19,7))
set(gca,'ZTick',linspace(1,19,7))
set(gca,'TickLength',[0.05 0.03])

% if load_ind==1&&p==1
%     set(gca,'xticklabel',[])
%     set(gca,'yticklabel',[])
%     set(gca,'XAxisLocation','top')
%     colorbar('location','NorthOutside')
%     annotation('arrow',[0.03, 0.18],[0.96,0.96],'linewidth',3) %arrow in x dir
%     annotation('arrow',[0.03, 0.03],[0.96,0.77],'linewidth',3)
%     xlabel('$\varphi_1$','Interpreter','Latex','FontSize',16,'fontweight','b')
%     set(gca,'XTick',linspace(1,19,7))
%     set(gca,'XTickLabel',0:15:90)
%     ylabel('$\Phi$','Interpreter','Latex','FontSize',16,'fontweight','b')
%     zlabel('$\varphi_2$','Interpreter','Latex','FontSize',16,'fontweight','b')
%     
%     set(gca,'YTick',linspace(1,19,7))
%     set(gca,'YTickLabel',0:15:90)
%     set(gca,'ZTick',linspace(1,19,7))
%     set(gca,'ZTickLabel',0:15:90)
% else
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    set(gca,'zticklabel',[])
% end
% set(slice1,'linewidth',5)
set(gca,'Ydir','reverse')
set(gca,'Zdir','reverse')
box on

set(gca,'FontSize',10,'fontweight','b')
 
%  sl=sl+3;
% shading('interp');



color_gray=[0.5 0.5 0.5; 0.0 0.0 0.0; 1 1 0; 0.5 0.5 0;...
%             0 1 1; 0 0.5 0.5; ...
            0 1 0; 0 0.5 0; 0 0 1; ...
            0 0 0.5; 0.5 0 0; 1 0 0];
colormap(color_gray)


   text(4,4,4,label_subfig{tex}(1+load_ind,:),'FontSize',14,'fontweight','b','background','white')

%%----plotting 3d at iso-intensity surface---
% sub_3d1=patch(isosurface(odf{18}(:,:,:)/1000,20));
% set(sub_3d1,'EdgeColor','none')
% camlight; lighting phong;
% view(3)
% box on
   
% colormap(hsv)
end %for different loading condition
end % for texture
end

close ('Figure',[8:13])
% saveas(gcf,'collection.fig')
% saveas(gcf,'collection.tif')

for load_ind=1:length(load_type) %for different loading condition
    figure(load_ind);
saveas(gcf,[load_type{load_ind},'.fig'])
saveas(gcf,[load_type{load_ind},'.tif'])
end
