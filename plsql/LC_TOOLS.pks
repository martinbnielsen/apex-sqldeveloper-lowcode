create or replace PACKAGE LC_TOOLS AS 

  PROCEDURE create_features;
  
  PROCEDURE create_feature_type;
 
 function region_help_plugin (
    p_region              in apex_plugin.t_region,
    p_plugin              in apex_plugin.t_plugin,
    p_is_printer_friendly in boolean ) return apex_plugin.t_region_render_result;
  
END LC_TOOLS;