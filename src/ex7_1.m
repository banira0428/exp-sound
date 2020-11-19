%% Calculate power spectrums in each frames
% Reference (pattern) speech
x_ref = audioread('../wav/Jan_Par_2.wav');
frame_x_ref = signal2frame(x_ref, 800, 1024);
PowX_dB_ref = calc_powerspec(frame_x_ref, 1024);

% Input speech
x_in = audioread(['../wav/Jan_Par_1.wav']);
frame_x_in = signal2frame(x_in, 800, 1024);
PowX_dB_in = calc_powerspec(frame_x_in, 1024);

[~, n_max] = size(PowX_dB_in);
[~, m_max] = size(PowX_dB_ref);
mn2nodeid = reshape(1:(n_max*m_max), [m_max n_max]);

%% Prepare Adjacency Matrix
A = zeros(n_max*m_max);
for n = 2:n_max
    for m = 1:m_max
        % Calculate distance in frame m in reference speech and frame n in input speech
        d_mn = sqrt( sum( (PowX_dB_ref(:, m) - PowX_dB_in(:, n)).^2 ) );

        dst_nodeid = mn2nodeid(m, n);

        A(mn2nodeid(  m, n-1), dst_nodeid) = d_mn;      % (1)

        if m >= 2
            A(mn2nodeid(m-1, n-1), dst_nodeid) = d_mn;  % (2)
        end

        if m >= 3
            A(mn2nodeid(m-2, n-1), dst_nodeid) = d_mn;  % (3)
        end

        % if m >= 4
        %     A(mn2nodeid(m-3, n-1), dst_nodeid) = d_mn;  % (3)
        % end

        % if m >= 5
        %     A(mn2nodeid(m-4, n-1), dst_nodeid) = d_mn;  % (3)
        % end

        % if m >= 6
        %     A(mn2nodeid(m-5, n-1), dst_nodeid) = d_mn;  % (3)
        % end

        % if m >= 7
        %     A(mn2nodeid(m-6, n-1), dst_nodeid) = d_mn;  % (3)
        % end

        % if m >= 8
        %     A(mn2nodeid(m-7, n-1), dst_nodeid) = d_mn;  % (3)
        % end
    end
end

initial_node = 1;
target_node  = mn2nodeid(end);

% AddNodes: open_listの初期化
open_list = [ struct('id', initial_node, 'parent', 0, 'cost', 0) ];

% closed_listの初期化．空で良い．
closed_list = [];

% オープンリストが空になるまでループする
while ~isempty(open_list)% 探索待ちのノードが存在する限り，探索を続行
    DEBUG_open_list = [[open_list.id]; [open_list.parent]; [open_list.cost]]

    current_node = open_list(1); % 探索対象取得
    open_list(1) = [];
    closed_list = [closed_list current_node];

    if current_node.id == target_node% 目標にたどり着いたら終わり
        disp('finish')
        break;
    end

    hyp_node_ids = find(A(current_node.id, :)); % 探索待ちノードの追加
    hyp_node_ids = hyp_node_ids(~ismember(hyp_node_ids, [closed_list.id]));
    % hyp_node_ids = hyp_node_ids(~ismember(hyp_node_ids, [open_list.id]));

    if isempty(hyp_node_ids)
        disp('No hypothesis: skip updating open_list')
        continue
    end

    hyp_node_costs = A(current_node.id, hyp_node_ids) + current_node.cost;
    hyp_node_parents = repmat(current_node.id, size(hyp_node_ids));

    hyp_nodes = struct('id', num2cell(hyp_node_ids), ...
                       'parent', num2cell(hyp_node_parents), ...
                       'cost', num2cell(hyp_node_costs));

    % P1') AddNodes: update open_list
    open_list = [open_list hyp_nodes];
    [~, idx] = sort([open_list.cost]);           
    open_list = open_list(idx);                  
    [~, idx] = unique([open_list.id], 'first');  
    open_list = open_list(sort(idx));            
end

distance = current_node.cost

%% Back tracking
%   NOTE: The closed_list must contain the target_node.
cur_id = target_node;
route = [];
while cur_id > 0
    route = [cur_id route];                          % routeの先頭に，辿っている途中のノード(cur_node)を追加していく
    array_index = find([closed_list.id] == cur_id);  % 現在のノードがclosed_listに格納されている場所を探して，
    cur_id = closed_list(array_index(1)).parent;     % その親ノードの番号を得る
end
route     % routeに経路上のノードが順番に格納されている

% Debug Search Result
%   cf. AI1-A6: Customize your graph more beautiful
%       AI2-A2: Plot the path

%% 'xy' axis data for gplot function
[X1,Y1] = meshgrid(1:m_max, 1:n_max);
xy = [X1(:) Y1(:)];   % --> xy = [ [1 1]; [1 2]; ...; [m_max n_max] ]

%% Plot the Graph
%   see Section 1D-5 and Appendix AI-A6
[X,Y] = gplot(A, xy);
plot(X,Y, 'o-', 'MarkerSize', 10, 'MarkerFaceColor', 'cyan');

%% Node number
text(xy(:,1)+0.05, xy(:,2)+0.05, num2cell(1:length(xy)), 'Color', 'red', 'FontSize', 11);

%% Highlight 'Initial node' and 'Target node'
% ☆ 'p', 〇 'o'
hold on;
scatter(xy(initial_node,1), xy(initial_node,2), 540, 'r', 'p', 'filled');
scatter(xy(target_node,1), xy(target_node,2), 360, 'r', 'o', 'LineWidth', 2);
hold off;

%% Highlight edges and nodes on the 'route'
%  only if the 'route' variable is defined and it is vector
if exist('route', 'var') ~= 0 && length(route) > 1
    Ax = zeros(size(A));
    for n = 1:length(route)-1
      Ax(route(n), route(n+1)) = 1;
    end

    [X,Y] = gplot(Ax, xy);
    hold on;
    plot(X,Y, 'o-', ...
        'MarkerSize', 10, 'MarkerFaceColor', 'red', ...
        'LineWidth', 2);
    hold off;
end

%% Customize chart objects
xlim([0 n_max+1]); ylim([0 m_max+1]);
xlabel('n (Frame number of Input speech)');
ylabel('m (Frame number of Reference speech)');

%% Chart title
%  (ToDo: Change the chart's title as your objective!!)
if exist('distance', 'var') ~= 0 && length(distance) == 1
  title(['Input: Par_1; ' 'Reference: Par_2; ' 'Total cost = ' num2str(distance)]);
end

saveas(gcf,'../out/7-1.png');

%% Clear temporary variables
clear X Y;