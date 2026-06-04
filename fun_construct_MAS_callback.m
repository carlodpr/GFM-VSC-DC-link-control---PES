function fun_construct_MAS_callback(gcb)
    model = bdroot(gcb);
    block = gcb; % Get the current block name
    mdlWks = get_param(model,'ModelWorkspace'); % Get the model workspace
    set_param([block '/Dynamic/Tertiary Control'], 'LabelModeActiveChoice', 'MAS messages')
    set_param([block '/Dynamic/Tertiary Control/MAS messages/concat'], 'NumInputs', 'length(buses_lf)')
    MAS_BSb = [block '/Dynamic/Tertiary Control/MAS messages'];
    bl_ID = find_system(MAS_BSb, 'MatchFilter', @Simulink.match.allVariants, 'LookUnderMasks', 'on', 'regexp','on', 'SearchDepth', '1', 'Name', 'ID');
    for i=2:length(bl_ID) % Keep first to copy
        delete_block(bl_ID{i})
    end
    % Delete all unconnected lines
    delete_line(find_system(MAS_BSb, 'MatchFilter', @Simulink.match.allVariants, 'LookUnderMasks', 'on', 'FindAll', 'on', 'Type', 'line', 'Connected', 'off'))

    buses_lf = evalin(mdlWks, [get_param(block, 'bvarname') 'buses_lf']);
    for i=2:length(buses_lf)
        add_block([MAS_BSb '/ID1'], [MAS_BSb '/ID' num2str(i)], 'Position', [250 200*i 400 200*i+150], ...
            'ID', num2str(i), 'Leader', 'No leader')
        add_line(MAS_BSb, 'elec/1', ['ID' num2str(i) '/1'])
        add_line(MAS_BSb, ['ID' num2str(i) '/1'], ['concat/' num2str(i)])
    end
    
    bl_ID = find_system(MAS_BSb, 'MatchFilter', @Simulink.match.allVariants, 'LookUnderMasks', 'on', 'regexp','on', 'SearchDepth', '1', 'Name', 'ID');
    for i=1:length(bl_ID)
       set_param(bl_ID{i}, 'Neigh1', num2str(i-1))
       set_param(bl_ID{i}, 'Neigh2', num2str(i+1))
       if i == 1
           set_param(bl_ID{i}, 'Neigh1', num2str(length(buses_lf)))
       elseif i == length(buses_lf)
           set_param(bl_ID{i}, 'Neigh2', '1')
       end
    end
end