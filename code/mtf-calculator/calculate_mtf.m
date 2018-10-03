function calculate_mtf( arg_file, arg_size, arg_roi, arg_vertical )

%% Input Arguments
if nargin < 4
   arg_vertical = true; 
end

%% Setup File Structure
FOLDER = get_FOLDER();
INPUT = get_INPUT( arg_file, FOLDER );
OUTPUT = get_OUTPUT( FOLDER, INPUT );

%% Process Data
IMG = get_IMG( INPUT );
IMG = set_scale( IMG, arg_size );
IMG = set_roi( IMG, arg_roi );
IMG = crop_IMG( IMG );
IMG = interpolate_IMG( IMG, arg_vertical );

IMG = find_edge( IMG );
IMG = get_ESF( IMG );
IMG = sort_ESF( IMG );
IMG = get_LSF( IMG );
IMG = center_LSF( IMG );
IMG = apply_window( IMG );

IMG = get_MTF( IMG );

%% Generate Output Figures
for i = [1:22]
    plot_figure(i,IMG,OUTPUT);% GOT NEUTRONS?
end

end