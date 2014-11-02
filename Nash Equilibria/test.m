% Test for different games, including games with pure and mished Nash
% Equilibria.
% Author: Elias Sprengel (eliass@student.ethz.ch) 10/2014.

% One mixed NE.
R = [3 4 0; 2 1 9; 5 1 0];
C = [6 0 2; 0 6 4; 2 2 2];
solutions = find_all_nash_equilibria(R, C);
assert(size(solutions, 1) == 1);
assert(solutions{1,1}(1) - 3/5 <= eps);
assert(solutions{1,2}(1) -1/4 <= eps);

% One mixed NE.
R = [2 4; 5 5; 4 6];
C = [1 2 4; 7 3 0];
solutions = find_all_nash_equilibria(R, C);
assert(size(solutions, 1) == 1);
assert(solutions{1,1}(1) - 1/2 <= eps);
assert(solutions{1,2}(1) -4/5 <= eps);

% One mixed NE.
R = [1 -1; -1 1];
C = [-1 1; 1 -1];
solutions = find_all_nash_equilibria(R, C);
assert(size(solutions, 1) == 1);
assert(solutions{1,1}(1) - 1/2 <= eps);
assert(solutions{1,2}(1) -1/2 <= eps);

% One pure NE (0,0).
R = [0 2 2 2; -2 1 3 3; -2 -1 2 4; -2 -1 0 3];
C = [0 2 2 2; -2 1 3 3; -2 -1 2 4; -2 -1 0 3];
solutions = find_all_nash_equilibria(R, C);
assert(size(solutions, 1) == 1);
assert(solutions{1,1}(1) - 1 <= eps);
assert(solutions{1,2}(1) -1 <= eps);