gitLocalRepo = ''; % Enter the path to your git repo here
maxContributorsToShow = 10; % Max number of contributors to show in the graph

% Execute the command to obtain number of contributions
cd(gitLocalRepo);
[status, commandOutput] = system('git shortlog -s -n | cat');

lines = splitlines(commandOutput);
numContributors = length(lines) - 1; % Last line seems to be empty string so don't consider it

% Init the arrays storing the x and y values
commits = zeros(numContributors);
names = strings(numContributors,1);

% Parse the command output
for i=1:numContributors
   line = lines(i);
   [token, remain] = strtok(line);
   commits(i) = str2double(token);
   names(i) = string(strtrim(remain));
end

% Draw the graph
bar(commits(1:min(numContributors, maxContributorsToShow)));
set(gca,'XTickLabel',names);
set(gca,'XTickLabelRotation',45);
title('Top Contributors');
xlabel('Contributors');
ylabel('Number of Contributions');