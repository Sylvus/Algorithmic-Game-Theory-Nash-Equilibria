function [x, exists] = find_solution(A, b)
    % Solves the system of linear equation while making sure that all
    % solutions are positive. Returns the solution and whether it was
    % optimal.
    % Author: Elias Sprengel (eliass@student.ethz.ch) 10/2014.
    
    eps = 10^(-6);
    [x, ~, residual] = lsqnonneg(A, b);
    % exclude all solutions that are not perfect.
    exists = (sum(residual > eps) == 0);
end

