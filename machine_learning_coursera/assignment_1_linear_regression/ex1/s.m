

X=[1;2;3;4];
y=[1;2;3;4];
m=length(X(:,1));
n=length(X(1,:));
X=[ones(m,1), X];
theta=rand(n+1,1);
% hyp = theta'*X'
%hyp=theta'*X';
hyp=X*theta;

%X
%y
%m
%n
%theta
hyp - y
%hyp'-y
