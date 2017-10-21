set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.3.00.05'
,p_default_workspace_id=>9776600328733329
,p_default_application_id=>104
,p_default_owner=>'LOWCODE'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/region_type/com_mbndata_region_help
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(14235529676022644)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.MBNDATA.REGION.HELP'
,p_display_name=>'Model Help'
,p_supported_ui_types=>'DESKTOP'
,p_api_version=>2
,p_render_function=>'lc_tools.region_help_plugin'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(14236057275028416)
,p_plugin_id=>wwv_flow_api.id(14235529676022644)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Entities'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>'CARS:CUSTOMERS'
,p_help_text=>'Please enter a list of entities (separated by colon)'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(14236344507031823)
,p_plugin_id=>wwv_flow_api.id(14235529676022644)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Processes'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>'New Dealer:Add Customer'
,p_help_text=>'Please enter a list of Processes (colon separated)'
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
