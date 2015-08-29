%% Schmid tensor
n = zeros(3,12);
b = zeros(3,12);
m = zeros(3,3,12);
n(:,1) = [-1,-1,1];
n(:,2) = [-1,-1,1];
n(:,3) = [-1,-1,1];
n(:,4) = [-1,1,1];
n(:,5) = [-1,1,1];
n(:,6) = [-1,1,1];
n(:,7) = [1,-1,1];
n(:,8) = [1,-1,1];
n(:,9) = [1,-1,1];
n(:,10) = [1,1,1];
n(:,11) = [1,1,1];
n(:,12) = [1,1,1];

b(:,1) = [0,1,1];
b(:,2) = [1,0,1];
b(:,3) = [1,-1,0];

b(:,4) = [0,-1,1];
b(:,5) = [1,0,1];
b(:,6) = [-1,-1,0];

b(:,7) = [0,1,1];
b(:,8) = [-1,0,1];
b(:,9) = [-1,-1,0];

b(:,10) = [0,-1,1];
b(:,11) = [-1,0,1];
b(:,12) = [1,-1,0];

for i = 1:12
    if dot(n(:,i),b(:,i))~=0
        disp(['n.b not equal 0! ',num2str(i)]);
    end
    n(:,i) = n(:,i)/norm(n(:,i));
    b(:,i) = b(:,i)/norm(b(:,i));
    m(:,:,i) = (n(:,i)*b(:,i)'+b(:,i)*n(:,i)')/2;
end

%% Grain orientation
phi1 =  [0,40,32,35,0];
phi =   [0,65,58,45,45];
phi2 =  [0,26,18,0,0];

for j=1:5
x1 = [cosd(phi1(:,j)),sind(phi1(:,j)),0;-sind(phi1(:,j)),cosd(phi1(:,j)),0;0,0,1];
z = [1,0,0;0,cosd(phi(:,j)),sind(phi(:,j));0,-sind(phi(:,j)),cosd(phi(:,j))];
x2 = [cosd(phi2(:,j)),sind(phi2(:,j)),0;-sind(phi2(:,j)),cosd(phi2(:,j)),0;0,0,1];

O = x2*z*x1;

rd=O(:,1);
td=O(:,2);
nd=O(:,3);

tau_0=81;
crss_rd=0;
crss_td=0;
for i=1:12
cos_rd_b(i)=abs(b(:,i)'*rd)/(norm(b(:,i))*norm(rd));
cos_rd_n(i)=abs(n(:,i)'*rd)/(norm(n(:,i))*norm(rd));
schmid_factor(1,i,j)=cos_rd_b(i)*cos_rd_n(i);
crss(1,i,j)=tau_0/schmid_factor(1,i,j);

cos_td_b(i)=abs(b(:,i)'*td)/(norm(b(:,i))*norm(td));
cos_td_n(i)=abs(n(:,i)'*td)/(norm(n(:,i))*norm(td));
schmid_factor(2,i,j)=cos_td_b(i)*cos_td_n(i);
crss(2,i,j)=tau_0/schmid_factor(2,i,j);
end

end
max(schmid_factor(1,:))/max(schmid_factor_td(2,:))

%% Strain rate
D = [1,0,0;0,-0.5,0;0,0,-0.5];
% will need normalization when evm is not 1
Dg = O*D*O';

%%
syms ts a s11 s22 s12 s13 s23 ev
S = [s11,s12,s13;s12,s22,s23;s13,s23,-s11-s22];
t = sym(zeros(12,1));
yf = sym(0);
Dg = sym(Dg);

for i = 1:12
    t(i) = sum(sum(m(:,:,i).*S));
    yf = (t(i)/ts)^a + yf;
end

yf = yf^(1/a);

F(1) = ev*diff(yf,s11) - Dg(1,1);
F(2) = ev*diff(yf,s22) - Dg(2,2);
F(3) = yf - 1;
F(4) = ev*diff(yf,s23) - Dg(2,3);
F(5) = ev*diff(yf,s13) - Dg(1,3);
F(6) = ev*diff(yf, s12) - Dg(1,2);

x(1) = ev;
x(2) = s11;
x(3) = s22;
x(4) = s12;
x(5) = s23;
x(6) = s13;

for i = 1:6
    for j = 1:6
        J(i,j) = diff(F(i),x(j));
    end
end

param = [91.85, 24.49, -12.25, -36.74, 0, 36.74];
ev = param(1);
s11 = param(2);
s22 = param(3);
s12 = param(4);
s23 = param(5);
s13 = param(6);
ts = 30;
a = 8;

F_n = subs(F);
J_n = subs(J);
str = subs(S);
subs(t)
subs(yf)
