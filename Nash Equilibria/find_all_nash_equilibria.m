function solutions = find_all_nash_equilibria(R, C)
    % Finds all valid Nash Equilibria (pure and mixed) by enumerating all
    % possible supports, calculating the solution and testing the acquired
    % solution on the whole game. The return value is a cell array where
    % the first two cells contain the probabilities for each player to play
    % a certain strategy. The third and forth cell contain the support of
    % each player and the fifth and sixth row contain the payoff matrices
    % for each player that were used to calculate the solution.
    % Author: Elias Sprengel (eliass@student.ethz.ch) 10/2014.
    
    supports_r = combn([false, true], size(R,1));
    supports_c = combn([false, true], size(C,1));
    solutions = {};
    counter = 1;

    for i=1:size(supports_r, 1)
        for j=1:size(supports_c, 1)
            % Skip these because they are trivial.        
            if ( (sum(supports_r(i, :)) == 0) || (sum(supports_c(j, :)) == 0) )
                continue;
            end
            % select the support.
            R_new = generate_supported_matrix(supports_r(i, :)', supports_c(j, :)', R);

            % build b_R:
            b_R = zeros(size(R_new, 1), 1);
            b_R(end) = 1;

            % try to find a solution
            [temp_sol, exists1] = find_solution(R_new, b_R);
            if exists1
                solution_R = zeros(size(R, 2), 1);
                % save the solution ignoring the last value because it just
                % describes the payoff, not a probability.
                solution_R(supports_c(j, :)') = temp_sol(1:end-1);
            end

            % do the same thing for C:
            C_new = generate_supported_matrix(supports_c(j, :)', supports_r(i, :)', C);

            % build b_C:
            b_C = zeros(size(C_new, 1), 1);
            b_C(end) = 1;

            % try to find a solution
            [temp_sol, exists2] = find_solution(C_new, b_C);
            if exists2
                solution_C = zeros(size(C, 2), 1);
                % save the solution ignoring the last value because it just
                % describes the payoff, not a probability.
                solution_C(supports_r(i, :)') = temp_sol(1:end-1);
            end

            if (exists1 && exists2 && is_solution_in_game(R, C, solution_R, solution_C))
               solutions{counter, 1} = solution_R;
               solutions{counter, 2} = solution_C;
               solutions{counter, 3} = supports_c(j, :)';
               solutions{counter, 4} = supports_r(i, :)';
               solutions{counter, 5} = R_new;
               solutions{counter, 6} = C_new;
               counter = counter + 1;
            end
        end
    end
end