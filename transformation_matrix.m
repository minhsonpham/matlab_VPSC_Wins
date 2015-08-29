
sum=(b(1)+b(3))/2
diff=(b(1)-b(3))/2
csum=cos(sum)
	cdiff=cos(sum)
	sdiff=sin(diff)
	t2=tan(b(2)/2.)
c
	rodr(1)=t2*cdiff/csum
	rodr(2)=t2*sdiff/csum
	rodr(3)=tan(sum)
    
    pi-0.281

    cr_or=[-0.1040, -0.2560, 0.0096;
                -0.2524, 0.1041, 0.01210467/0.2729;
                0.0447, -0.0079, 0.2729];
dot(cr_or(2,:),cr_or(3,:))
dot(cr_or(2,1:2),cr_or(3,1:2))/cr_or(3,3)

    format long
cs=symmetry('cubic')
ss=symmetry('orthorhombic')
setMTEXpref('EulerAngleConvention','Kocks')

s_Euler=orientation('Miller',[-0.2524, 0.1041, 0.01210467/0.2729],[0.0447, -0.0079, 0.2729],cs,ss)
c=Miller(1,0,0,cs)
    
c=[1 0 0; 0 1 0; 0 0 1];
s=[-0.104, -0.256, 0.010; %face, normal to cross section
0.045, -0.008, 0.2632;  %right
-0.252, 0.104, 0.0416]; %up

-(s(1,1)*s(2,1)+s(1,2)*s(2,2))/s(1,3)
-dot(s(2,1:2),s(3,1:2))/s(2,3)

dot(s(2,:),s(3,:))
s(1,:)*s(2,:)'
c(1,:)*c(2,:)'

Q=[s(1,:)*c(1,:)'/(norm(c(1,:))*norm(s(1,:))), s(1,:)*c(2,:)'/(norm(c(2,:))*norm(s(1,:))),  s(1,:)*c(3,:)'/(norm(c(3,:))*norm(s(1,:)));
    s(2,:)*c(1,:)'/(norm(c(1,:))*norm(s(2,:))), s(2,:)*c(2,:)'/(norm(c(2,:))*norm(s(2,:))),  s(2,:)*c(3,:)'/(norm(c(3,:))*norm(s(2,:)));
    s(3,:)*c(1,:)'/(norm(c(1,:))*norm(s(3,:))), s(3,:)*c(2,:)'/(norm(c(2,:))*norm(s(3,:))),  s(3,:)*c(3,:)'/(norm(c(3,:))*norm(s(3,:)));]

    
Q=[c(1,:)*s(1,:)'/(norm(c(1,:))*norm(s(1,:))), c(1,:)*s(2,:)'/(norm(c(1,:))*norm(s(2,:))),  c(1,:)*s(3,:)'/(norm(c(1,:))*norm(s(3,:)));
    c(2,:)*s(1,:)'/(norm(c(2,:))*norm(s(1,:))), c(2,:)*s(2,:)'/(norm(c(2,:))*norm(s(2,:))),  c(2,:)*s(3,:)'/(norm(c(2,:))*norm(s(3,:)));
    c(3,:)*s(1,:)'/(norm(c(3,:))*norm(s(1,:))), c(3,:)*s(2,:)'/(norm(c(3,:))*norm(s(2,:))),  c(3,:)*s(3,:)'/(norm(c(3,:))*norm(s(3,:)));]

Q*c*transpose(Q)
transpose(Q)*s*Q 