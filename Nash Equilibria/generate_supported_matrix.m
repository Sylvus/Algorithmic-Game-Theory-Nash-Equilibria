function A = generate_supported_matrix(support1, support2, B)
    % Given a support generates the new matrix that will be used to solve
    % the linear system of equations. The new matrix has an additional row
    % and column to enforce additional constraints (probabilities sum up to one).
    % Author: Elias Sprengel (eliass@student.ethz.ch) 10/2014.

    A = B(support1, support2);
    % add the condition that all values add up to one.
    A = [A; ones(1, size(A, 2))];
    % add a column to introduce the requirments that all values add up
    % to the same sum.
    A = [A -1 .* ones(size(A, 1), 1)];
    A(end, end) = 0;
end