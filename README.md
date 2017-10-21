# apex-sqldeveloper-lowcode
SQLDeveloper, Low Code and APEX Applications:

This session shows how to re-use the information in the data- and process models in SQL Developer to power our APEX applications.
SQLDeveloper model information can be exported into a reporting database schema. This information can then be providing input to the wizard generation of APEX pages, it can control navigation, provide help texts, domains and much more.
The session demo’s several examples of how this technique was used in a large Danish APEX project. It will also demo how easy it is to create data and process models in SQLDeveloper and how Javascript can be used to easily extend our models, to generate code.

## Installation

1. Create the new database schema where the reporting scheme can be exported to. Use sql/create_reporting_schema.sql
2. Export your model into the reporting scheme (SQL Developer -> data Modeller -> File -> Export -> To Reposting Scheme). You can also use the "lowCode model" as an example (you find this in the "model" folder"). 
3. Grant access to reportind scheme tables to you application user. Use sql/grant_model_access.sql
4. Create view for the reporting artifacts you want. Use sql/lowcode_views.sql
5. Install the PL/SQL helper package in your application database schema. Use plsql/LC_TOOLS.pks and LC_TOOLS.pkb
6. Install the demo APEX application in your application workspace. Use apex/f104_lowcode_app.sql.
7. Use the above for inspiration in your own projects.