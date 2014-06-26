function deriv = get_deriv(x,K)

switch K
    case 0
        deriv = x; 
        return
    case 1
        dfilt = [-1 1];
    case 2
        dfilt = [1 -2 1];
    case 4
        dfilt = [1 -4 6 -4 1];
    otherwise
        error('K must be 2 or 4');
end

deriv = conv(x, dfilt, 'same');
