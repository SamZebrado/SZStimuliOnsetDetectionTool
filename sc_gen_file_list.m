% save all measurement in this structure array
file_info = [];

% real setup
i_setup = 1;
file_info(i_setup).name = 'RS_957B';
file_info(i_setup).raw_data = 'Data-21_39_48-24_03_2022';
file_info(i_setup).processed_data = 'ProcessedData-18_19_46-25_03_2022';
file_info(i_setup).processed_var = 'valid_data_segments';
file_info(i_setup).time_var = 'valid_data_time';
% VR setup
i_setup = i_setup + 1;
file_info(i_setup).name = 'VR_Tendon';
file_info(i_setup).raw_data = 'Data-20_21_01-28_04_2022';
file_info(i_setup).processed_data = 'ProcessedData-18_50_06-02_05_2022';
file_info(i_setup).processed_var = 'valid_data_segments';
file_info(i_setup).time_var = 'valid_data_time';

i_setup = i_setup + 1;
file_info(i_setup).name = 'VR_957B_day1';
file_info(i_setup).raw_data = 'Data-06_54_41-13_05_2022';
file_info(i_setup).processed_data = 'ProcessedData-13_30_39-13_05_2022';
file_info(i_setup).processed_var = 'valid_data_segments12';
file_info(i_setup).time_var = 'valid_data_time12';

i_setup = i_setup + 1;
file_info(i_setup).name = 'VR_957B_day2';
file_info(i_setup).raw_data = 'Data-02_45_02-19_05_2022';
file_info(i_setup).processed_data = 'ProcessedData-07_52_53-30_05_2022';
file_info(i_setup).processed_var = 'valid_data_segments12';
file_info(i_setup).time_var = 'valid_data_time12';
