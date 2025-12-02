sigma=10;
rho=28;
beta=8/3;

%equations
lo= @(t,s)[...
     sigma*(s(2)-s(1)) ; %dx/dt
     s(1)*(rho-s(3))-s(2) ; %dy/dt
     s(1)*s(2)-s(3)*beta ];%dz/dy
tspan = [0,50] ;
inicond=[ 1;1;1];

oad= odeset('RelTol',1e-8,'AbsTol',1e-9);
[T,S]= ode45(lo,tspan,inicond,oad);
x=S(:,1);
y=S(:,2);
z=S(:,3);
n=numel(T);

%figure plotting
figure ('color','k');
ax= gca;
hold(ax,'on');
ax.Color = 'k';
ax.Box ='on';
grid on

ax.XColor= [0.9 0.9 0.9];
ax.YColor= [0.9 0.9 0.9];
ax.ZColor= [0.9 0.9 0.9];
ax.GridColor=[0.45 0.45 0.45];

xlabel('X','Color','w');
ylabel('Y','Color','w');
zlabel('Z','Color','w');


title('Lorenz butterfly attractor','Color','g','FontSize',12);
view(45,20);

axis tight

cmap= colormap(ax,"cool") ;
nColors = size(cmap,1);
corIdx = round(linspace(1,nColors,n-1));

%animating
for k=2:n
    plot3(x(k-1:k), y(k-1:k), z(k-1:k),...
        'LineWidth',1.4,...
        'Color',cmap(corIdx(k-1),:));
    drawnow limitrate
end
