create or replace PACKAGE lc_tools AS

    PROCEDURE create_features;

    PROCEDURE create_feature_type;

    FUNCTION region_help_plugin (
        p_region                IN apex_plugin.t_region,
        p_plugin                IN apex_plugin.t_plugin,
        p_is_printer_friendly   IN BOOLEAN
    ) RETURN apex_plugin.t_region_render_result;

    PROCEDURE generate_blueprint_json ( p_design_ovid   IN lc_designs.design_ovid%TYPE );

END lc_tools;
