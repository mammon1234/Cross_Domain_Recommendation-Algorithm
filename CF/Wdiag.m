function [var]=Wdiag(x,Wi)
var=x*diag(Wi)*x';