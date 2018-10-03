function plot_figure( figure_selector, IMG, OUTPUT )

%% Check Number of Input Arguments
if nargin < 3
    OUTPUT.folder = '';
    OUTPUT.ID = 'default';
end

if nargin < 2
    IMG = 0;
end

if nargin < 1
    figure_selector = 0;
end

%% Select Figure Number
switch figure_selector
    case 0
        figure_number = 100;
    case 1
        figure_number = 101;
    case 2
        figure_number = 102;
	case 3
        figure_number = 201;
    case 4
        figure_number = 202;
    case 5
        figure_number = 301;
    case 6
        figure_number = 302;
    case 7
        figure_number = 401;
    case 8
        figure_number = 402;
    case 9
        figure_number = 501;
    case 10
        figure_number = 502;
    case 11
        figure_number = 601;
    case 12
        figure_number = 602;
    case 13
        figure_number = 603;
    case 14
        figure_number = 604;
    case 15
        figure_number = 605;
    case 16
        figure_number = 701;
    case 17
        figure_number = 702;
    case 18
        figure_number = 703;
    case 19
        figure_number = 704;
    case 20
        figure_number = 705;
    case 21
        figure_number = 706;
    case 22
        figure_number = 801;
    otherwise
        figure_number = 1;
end

FIG = figure(figure_number);
clf(figure_number);

%% Begin Figure Plotting
hold on;

%% Figure Setup
switch figure_selector
    case 0
        FIG.Name = 'Default';
        FILE.description = 'default';
    case 1
        FIG.Name = 'Raw (pixels)';
        FILE.description = 'raw_pixels';
    case 2
        FIG.Name = 'Raw (um)';
        FILE.description = 'raw_metric';
    case 3
        FIG.Name = 'ROI overlay (pixels)';
        FILE.description = 'region_of_interest_pixels';
    case 4
        FIG.Name = 'ROI overlay (mm)';
        FILE.description = 'region_of_interest_metric';
    case 5
        FIG.Name = 'Cropped (pixels)';
        FILE.description = 'cropped_pixels';
    case 6
        FIG.Name = 'Cropped (mm)';
        FILE.description = 'cropped_metric';
    case 7
        FIG.Name = 'Interpolated (pixels)';
        FILE.description = 'interpolated_pixels';
    case 8
        FIG.Name = 'Interpolated (mm)';
        FILE.description = 'interpolated_metric';
    case 9
        FIG.Name = 'Canny Edge';
        FILE.description = 'canny_edge_detection';
    case 10
        FIG.Name = 'Hough Transform';
        FILE.description = 'hough_transform';
    case 11
        FIG.Name = 'ESF - raw';
        FILE.description = 'ESF_raw';
    case 12
        FIG.Name = 'ESF - aligned';
        FILE.description = 'ESF_aligned';
    case 13
        FIG.Name = 'ESF - sorted';
        FILE.description = 'ESF_sorted';
    case 14
        FIG.Name = 'ESF - averaged';
        FILE.description = 'ESF_averaged';
    case 15
        FIG.Name = 'ESF - centered';
        FILE.description = 'ESF_centered';
    case 16
        FIG.Name = 'LSF - raw';
        FILE.description = 'LSF_raw';
    case 17
        FIG.Name = 'LSF - norm';
        FILE.description = 'LSF_normalized';
    case 18
        FIG.Name = 'LSF - fit';
        FILE.description = 'LSF_gauss_fit';
    case 19
        FIG.Name = 'LSF - centered';
        FILE.description = 'LSF_centered';
    case 20
        FIG.Name = 'Mod Hann Window';
        FILE.description = 'modified_hann_window';
    case 21
        FIG.Name = 'LSF - windowed';
        FILE.description = 'LSF_hann_window';
    case 22
        FIG.Name = 'MTF';
        FILE.description = 'MTF';
    otherwise
end

FIG.Visible = 'on';
FIG.WindowStyle = 'docked';
FIG.Colormap = colormap('gray');

%% Plots
line_size = 0.25;
point_size = 8;

switch figure_selector
    case 0
        plot([0,0],[1,1]);
    case 1
        surf(IMG.X.index, IMG.Y.index, IMG.Z.raw);
        colorbar;
    case 2
        surf(IMG.X.dist, IMG.Y.dist, IMG.Z.raw);
        colorbar;
    case 3
        surf(IMG.X.index, IMG.Y.index, IMG.Z.raw);
        line(IMG.ROI.index(:,1), IMG.ROI.index(:,2), IMG.ROI.z,... 
            'Color', 'yellow', 'LineWidth', 2);
        colorbar;
    case 4
        surf(IMG.X.dist, IMG.Y.dist, IMG.Z.raw);
        line(IMG.ROI.dist(:,1), IMG.ROI.dist(:,2), IMG.ROI.z,... 
            'Color', 'yellow', 'LineWidth', 2);
        colorbar;
    case 5
        surf(IMG.x.index, IMG.y.index, IMG.Z.crop);
        colorbar;
    case 6
        surf(IMG.x.dist, IMG.y.dist, IMG.Z.crop);
        colorbar;
    case 7
        surf(IMG.x.interp, IMG.y.interp, IMG.Z.interp);
        colorbar;
    case 8
        surf(IMG.x.interp_d, IMG.y.interp_d, IMG.Z.interp);
        colorbar;
    case 9
        surf(IMG.x.dist, IMG.y.dist, double(IMG.Z.edge));
    case 10
        imshow(imadjust(IMG.EDGE.H),[],...
            'XData',IMG.EDGE.theta,...
            'YData',IMG.EDGE.rho,...
            'InitialMagnification','fit')
    case 11
        plot(IMG.ESF.position, IMG.ESF.intensity, '.k', 'MarkerSize', point_size);
    case 12
        plot(IMG.ESF.pos_align, IMG.ESF.intensity, '.k', 'MarkerSize', point_size);
    case 13
        plot(IMG.ESF.sorted_position, IMG.ESF.sorted_intensity, '-k', 'LineWidth', line_size);
    case 14
        plot(IMG.ESF.bins, IMG.ESF.average, '-k', 'LineWidth', line_size);
        plot(IMG.ESF.bins, IMG.ESF.average, '.k', 'MarkerSize', point_size);
    case 15
        plot(IMG.LSF.bins_centered, IMG.ESF.average, '-k', 'LineWidth', line_size);
        plot(IMG.LSF.bins_centered, IMG.ESF.average, '.k', 'MarkerSize', point_size);
    case 16
        plot(IMG.LSF.bins, IMG.LSF.intensity, '-k', 'LineWidth', line_size);
    case 17
        plot(IMG.LSF.bins, IMG.LSF.intensity_norm, '-k', 'LineWidth', line_size);
    case 18
    	plot(IMG.LSF.bins, IMG.LSF.intensity_norm, '.k', 'MarkerSize', point_size);
    	plot(IMG.LSF.bins, IMG.LSF.gauss, '-b');
        legend('location','NorthEast','LSF','Gauss Fit');
    case 19
    	plot(IMG.LSF.bins_centered, IMG.LSF.intensity_norm, '-k', 'LineWidth', line_size);
    case 20
        plot(IMG.LSF.bins_trim, IMG.LSF.window, '-k');
    case 21
        plot(IMG.LSF.bins_trim, IMG.LSF.intensity_window, '-k', 'LineWidth', line_size);
        plot(IMG.LSF.bins_trim, IMG.LSF.intensity_window, '.k', 'MarkerSize', point_size);
    case 22
        plot(IMG.MTF.lim,IMG.MTF.point(2)*[1,1],'--k', 'LineWidth', line_size);
        
        plot(IMG.MTF.x, IMG.MTF.y, '-k');
        plot(IMG.MTF.x, IMG.MTF.y, '.k', 'MarkerSize', point_size);
        
        plot(IMG.MTF.point(1),IMG.MTF.point(2), '.r', 'MarkerSize', 15);
        plot(IMG.MTF.point(1),IMG.MTF.point(2), 'or', 'MarkerSize', 10);
        
        MTF_string_A = sprintf(' = %0.3f lp/mm',IMG.MTF.point(1));
        MTF_string_B = sprintf(' = %0.3f %sm',IMG.MTF.res,'\mu');
        
        txt_x = IMG.MTF.lim(2) * 0.425;
        txt_y = 0.65;
        text(txt_x,txt_y,'MTF_1_0_%','FontSize',14,'HorizontalAlignment','right');
        t = text(txt_x,txt_y,MTF_string_A,'FontSize',14);
        t = text(txt_x,txt_y-0.15,MTF_string_B,'FontSize',14);
    otherwise
end

shading flat;
box on;

%% Axes Label Settings
switch figure_selector
    case 0
    case mat2cell([1,3,5],1,ones(1,3))
        micron_size = IMG.pixel * 1000;
        output_value = sprintf('%d', micron_size);
        axis_string = strcat('Pixels (',output_value, ' \mum)');
        FIG.CurrentAxes.XLabel.String = axis_string;
        FIG.CurrentAxes.YLabel.String = axis_string;
        FIG.CurrentAxes.DataAspectRatio = [ 1, 1, 1 ];
    case 7
        micron_size = IMG.pixel * 1000;
        output_value = sprintf('%d', micron_size);
        axis_string = strcat('Pixels (',output_value, ' \mum)');
        FIG.CurrentAxes.XLabel.String = axis_string;
        micron_size = micron_size / IMG.gain;
        output_value = sprintf('%.2f', micron_size);
        axis_string = strcat('Pixels (',output_value, ' \mum)');
        FIG.CurrentAxes.YLabel.String = axis_string;
        FIG.CurrentAxes.DataAspectRatio = [ 1, 1, 1 ];
    case mat2cell([2,4,6,8,9],1,ones(1,5))
        axis_string = 'Distance (mm)';
        FIG.CurrentAxes.XLabel.String = axis_string;
        FIG.CurrentAxes.YLabel.String = axis_string;
        FIG.CurrentAxes.DataAspectRatio = [ 1, 1, 1 ];
    case 10
        FIG.CurrentAxes.XLabel.String = '\theta (degrees)';
        FIG.CurrentAxes.YLabel.String = '\rho (pixels)';
        FIG.CurrentAxes.DataAspectRatio = [ 0.2, 1, 1 ];
        axis on
        axis normal
    case mat2cell([11,12,13,14,15,16,17,18,19,20,21],1,ones(1,11))
        FIG.CurrentAxes.XLabel.String = 'Distance Across Edge (mm)';
        FIG.CurrentAxes.YLabel.String = 'Intensity';  
    case 22
        FIG.CurrentAxes.XLabel.String = 'Spatial Resolution (lp/mm)';
        FIG.CurrentAxes.YLabel.String = 'Modulation Transfer Function';
    otherwise
end

%% Axes Limit Settings
switch figure_selector
    case 0
    case mat2cell([1,3],1,ones(1,2))
        FIG.CurrentAxes.XLim = IMG.X.lim;
        FIG.CurrentAxes.YLim = IMG.Y.lim;
    case mat2cell([2,4],1,ones(1,2))
        FIG.CurrentAxes.XLim = IMG.X.lim_d;
        FIG.CurrentAxes.YLim = IMG.Y.lim_d;
    case mat2cell([5,7],1,ones(1,2))
        FIG.CurrentAxes.XLim = IMG.x.lim;
        FIG.CurrentAxes.YLim = IMG.y.lim;
    case mat2cell([6,8,9],1,ones(1,3))
        FIG.CurrentAxes.XLim = IMG.x.lim_d;
        FIG.CurrentAxes.YLim = IMG.y.lim_d;
    case 10
        FIG.CurrentAxes.XLim = [-90, 90];
        FIG.CurrentAxes.YLim = [min(IMG.EDGE.rho),max(IMG.EDGE.rho)];
    case mat2cell([11,12,13,14],1,ones(1,4))
        FIG.CurrentAxes.XLim = IMG.ESF.lim;
      	FIG.CurrentAxes.YLim = [0,1];
    case 15
        FIG.CurrentAxes.XLim = IMG.LSF.lim;
      	FIG.CurrentAxes.YLim = [0,1];
    case 16
        FIG.CurrentAxes.XLim = IMG.ESF.lim;
    case mat2cell([17,18],1,ones(1,2))
        FIG.CurrentAxes.XLim = IMG.ESF.lim;
       	FIG.CurrentAxes.YLim = [-0.1,1.1];
    case mat2cell([19,20,21],1,ones(1,3))
        FIG.CurrentAxes.XLim = IMG.LSF.lim;
        FIG.CurrentAxes.YLim = [-0.1,1.1];
    case 22
        FIG.CurrentAxes.XLim = IMG.MTF.lim ;
      	FIG.CurrentAxes.YLim = [0,1];
    otherwise
end

%% Grid Settings
switch figure_selector
    case mat2cell([11,12,13,14,15,16,17,18,19,20,21,22],1,ones(1,12))
        FIG.CurrentAxes.XGrid = 'on';
        FIG.CurrentAxes.YGrid = 'on';
        FIG.CurrentAxes.ZGrid = 'on';
    otherwise
        FIG.CurrentAxes.XGrid = 'off';
        FIG.CurrentAxes.YGrid = 'off';
        FIG.CurrentAxes.ZGrid = 'off';
end

%% Figure Aspect Ratio and Width
width = 960;

switch figure_selector
    case mat2cell([1,2,3,4],1,ones(1,4))
        aspect_ratio = range(FIG.CurrentAxes.YLim) / range(FIG.CurrentAxes.XLim);
        aspect_ratio = aspect_ratio / 1.1;
        width = width / 2;
    case mat2cell([5,6,7,8],1,ones(1,4))
        aspect_ratio = range(FIG.CurrentAxes.YLim) / range(FIG.CurrentAxes.XLim);
        aspect_ratio = aspect_ratio / 0.85;
        width = width / 2;
    case 9
        aspect_ratio = range(FIG.CurrentAxes.YLim) / range(FIG.CurrentAxes.XLim);
        aspect_ratio = aspect_ratio / 0.80;
        width = width * 3/4;
    case 10
        aspect_ratio = 0.75;
        width = width * 3/4;
    case mat2cell([11,12,13,14,17,18],1,ones(1,6))
        aspect_ratio = range(FIG.CurrentAxes.YLim) / range(FIG.CurrentAxes.XLim);
        aspect_ratio = aspect_ratio / 3.0;
	case mat2cell([15,19,20,21],1,ones(1,4))
        aspect_ratio = range(FIG.CurrentAxes.YLim) / range(FIG.CurrentAxes.XLim);
        aspect_ratio = aspect_ratio / 3.5;
    case 16
        aspect_ratio = 1/3;
    case 22
        aspect_ratio = 1/2.5;
    otherwise
        aspect_ratio = 1;
end
    
%% Save Figure to File
height = ceil( width * aspect_ratio );

FIG.CurrentAxes.FontSize = 12;
FIG.PaperUnits = 'points';
FIG.PaperPosition = [ 150 150 width height ]; % position on screen

FILE.type = 'png';
FILE.number = sprintf('_step_%.2d_', figure_selector);
FILE.ID = strcat(OUTPUT.ID, FILE.number, FILE.description);
FILE.name = strcat(FILE.ID, '.', FILE.type);
FILE.path = fullfile(OUTPUT.folder, FILE.name);

if nargin >= 3
    saveas( FIG, FILE.path, FILE.type );
end

%% End Figure Plotting
hold off;

end

