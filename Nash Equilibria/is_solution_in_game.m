function is_solution = is_solution_in_game(R, C, solution_R, solution_C)
    % Finds out if a given solution is a valid Nash Equlibirum. R and C are
    % the payoff matrices for the two players, solution_R and solution_C
    % are vectors describing the probabilities of each player to play a
    % certain strategy.
    % Author: Elias Sprengel (eliass@student.ethz.ch) 10/2014.
    
    % Test for each player.
    is_solution = (...
        check_solution_for_one_player(R, solution_R, solution_C) && ...
        check_solution_for_one_player(C, solution_C, solution_R));
end


function valid = check_solution_for_one_player(A, solution_A, solution_B)
    % Initialize variables
    eps = 10^(-6);
    valid = true;
    
    % Given the probabilities of R, what option would be best for C?
    % (We expect they are all equal such that C can also play a mixed
    % strategy but if they are some that are worse then C should never
    % have to play these strategies.
    
    max_found = A(1, :) * solution_A;
    % Save all strategies which are equal or worse.
    equal = 1;
    worse = [];
    for i=2:size(A,1)
        % Player B plays i. Expected payoff:
        new_payoff = A(i, :) * solution_A;
        if (abs(new_payoff - max_found) < eps)
            % This one is equally good.
            equal = [equal; i];
            continue;
        end
        if (new_payoff > max_found + eps)
            max_found = new_payoff;
            worse = [worse; equal];
            equal = i;         
            continue;
        end
        if (new_payoff + eps < max_found)
            worse = [worse; i];
            continue;
        end
    end
    % all strategies that are worse should have a probability of 0 (will
    % never be played).
    for i=1:size(worse,1);
        % player B wan'ts to play a special strategy, is that reported in
        % solution_B?
        if solution_B(worse(i)) > eps
            % no it is not, so this is not a valid set of strategies.
            valid = false;
            return;
        end
    end
end



