create or replace PACKAGE BODY LC_TOOLS AS
  -- Constants
  C_SCHEMA CONSTANT VARCHAR2(30) := 'MBNDATA';
  
  -- Setup workspace context
  PROCEDURE setup IS
     ws_id number;
  BEGIN
    select max (workspace_id)
    into ws_id
    from apex_applications;
    
    wwv_flow_api.set_security_group_id (ws_id);
  END;
  
  -- Create features from the model processes
  PROCEDURE create_features AS
  BEGIN
    setup();
    
    for r in (select p.*, 
                ap.page_id,
                ap.application_id
              from LC_PROCESSES p 
              left join apex_application_pages ap on ap.application_id = 104 and ap.page_name = p.process_name
              where p.process_type = 'Primitive'
              and not exists (
                select 1 from APEX_TEAM_FEATURES f
                where f.feature_name = p.process_name)) LOOP
                
        -- Note: Undocumented API
        wwv_flow_team_api.create_feature(
                    p_feature_name => r.process_name,
                    p_application_id => r.application_id,
                    p_module => r.page_id,
                    p_publishable_description => r.text,
                    p_description => r.text,
                    p_estimated_effort_in_hours => 12, /* Default for now. Change if needed */
                    p_release => '5.1',
                    p_status => 0,
                    p_feature_type_id => 3
        );

    END LOOP;
    
  END create_features;

  -- Create feature type / Approval status
  PROCEDURE create_feature_type IS
  BEGIN
      setup();

      wwv_flow_team_api.create_feature_type (
            p_id                                => 3,
            p_type_id                           => 3,
            p_type_name                         => 'Committed Feature',
            p_type_desc                         => 'Committed Feature',
            p_reporting_default_yn              => 'Y');
  END;
  
  -- region plugin to display help text from the model
  function region_help_plugin (
    p_region              in apex_plugin.t_region,
    p_plugin              in apex_plugin.t_plugin,
    p_is_printer_friendly in boolean ) return apex_plugin.t_region_render_result IS
    l_res apex_plugin.t_region_render_result;
    l_entities  VARCHAR2(2000) := p_region.attribute_01;
    l_processes VARCHAR2(2000) := p_region.attribute_02;
    
    l_list apex_t_varchar2;
    l_name VARCHAR2(1000);
    l_text VARCHAR2(32000);
  begin
  
    -- Render Help for Entities
    IF l_entities IS NOT NULL THEN
      l_list := apex_string.split(l_entities);
      FOR i IN 1..l_list.COUNT LOOP
        -- Fetch the entity information and render this
        SELECT entity_name, text
        INTO   l_name, l_text
        FROM   lc_entities
        WHERE  entity_name = l_list(i);
        
        htp.p('<div class="lc-help-header">' || l_name || '</div>' ||
              '<div class="lc-help-body">'   || l_text || '</div>');
              
      END LOOP;
      
    END IF;
      
    -- render help for processes
    IF l_processes IS NOT NULL THEN
      l_list := apex_string.split(l_processes);
      FOR i IN 1..l_list.COUNT LOOP
        -- Fetch the entity information and render this
        SELECT process_name, text
        INTO   l_name, l_text
        FROM   lc_processes
        WHERE  process_name = l_list(i);
        
        htp.p('<div class="lc-help-header">' || l_name || '</div>' ||
              '<div class="lc-help-body">'   || l_text || '</div>');
              
      END LOOP;
      
    END IF;
    
    return(l_res);
  end;
    
  -- Generate APEX blueprint JSON for a specific design
  PROCEDURE generate_blueprint_json (p_design_ovid in lc_designs.design_ovid%TYPE) IS
    l_page_no integer := 10;
  BEGIN
    for r in (select * from lc_designs where design_ovid = p_design_ovid) loop
    
        -- general Application attributes
        apex_json.open_object();
        apex_json.open_object('application');
       
        apex_json.write('name',                 r.design_name);
        apex_json.write('appShortDescription',  r.version_comments);
        apex_json.write('schema',               C_SCHEMA);
        apex_json.flush;
        
        -- Features, Apperance, Settins from the notes on the design model
        htp.p(',' || r.note);
    
        -- Pages from model processes
        apex_json.open_array('pages');
        
        -- Always supply a blank Home page
        apex_json.open_object;        
        apex_json.write('page',           to_char(l_page_no));
        apex_json.write('pageName',       'Home');
        apex_json.write('help',           'Welcome to ' || r.design_name);
        apex_json.write('pageIcon',       'fa-home');
        apex_json.write('pageType',       'blank');
        apex_json.write('pageIsHomePage',  true);
        apex_json.close_object;
    
        for p in (select process_number, process_name, text, note 
                  from lc_processes  
                  where design_ovid = p_design_ovid
                  and process_type = 'Primitive' 
                  order by process_number) loop
                  
          l_page_no := l_page_no + 10;
          apex_json.open_object;        
          apex_json.write('page',       to_char(l_page_no));
          apex_json.write('pageName',   p.process_name);
          apex_json.write('help',       p.text);
          
          if TRIM(p.note) is not null then
              apex_json.flush;
              htp.p(',' || p.note);
          end if;
          
          apex_json.close_object;
        
        end loop;
        
        apex_json.close_array;
        
        apex_json.close_object; -- application
        apex_json.close_object;
        
     end loop;
  
  END;
  
END LC_TOOLS;