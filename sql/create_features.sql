-- Create feature type (approval status)
BEGIN
  lc_tools.create_feature_type;
END;
/

-- Create features in APEX Team Development - from the model
BEGIN
  lc_tools.create_features;
END;
/


select * from apex_team_features;

