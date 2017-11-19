-- Designs and versions
select design_id, design_ovid,  design_name, date_published, published_by, persistence_version
from dmrs_designs d;

-- Get the latest design
select d.design_name, date_published, published_by, persistence_version
from dmrs_designs d
where d.date_published = (select max(d2.date_published) from dmrs_designs d2 where d2.design_id = d.design_id);

-- Diagrams in the design
select d.design_name, date_published, published_by, di.diagram_name
from dmrs_designs d
join DMRS_DIAGRAMS di on di.design_ovid = d.design_ovid
where d.date_published = (select max(d2.date_published) from dmrs_designs d2 where d2.design_id = d.design_id);

-- Designs, digrams and elemements
select d.design_name, date_published, published_by, de.diagram_name, de.type, de.name
from dmrs_designs d
join DMRS_DIAGRAM_ELEMENTS de on DE.DESIGN_OVID = D.DESIGN_OVID
where d.date_published = (select max(d2.date_published) from dmrs_designs d2 where d2.design_id = d.design_id);

-- Domains
select *
from dmrs_domains;

-- Domain value ranges
select d.design_name, date_published, da.*
from dmrs_designs d
join dmrs_domain_avt da on da.design_ovid = d.design_ovid
where d.date_published = (select max(d2.date_published) from dmrs_designs d2 where d2.design_id = d.design_id);

-- diagrams
select * 
from DMRS_DIAGRAMS;

-- Processes
select de.diagram_name, p.process_id, p.parent_process_id, p.process_name, p.process_number,p.*
from dmrs_designs d
join DMRS_DIAGRAMS de on DE.DESIGN_OVID = D.DESIGN_OVID
join dmrs_processes p on p.diagram_id = de.model_id and p.diagram_ovid = de.model_ovid 
where d.date_published = (select max(d2.date_published) from dmrs_designs d2 where d2.design_id = d.design_id);

-- Entities
select *
from DMRS_ENTITIES;

-- Text, notes, comments etc.
select * from datamodel.dmrs_large_text where object_id = 'C60C4646-8AAD-D590-9E3F-C27490F399A3';

-- Entities
select d.design_name, date_published, published_by, e.entity_name, t.text entity_comments
from datamodel.dmrs_designs d
join datamodel.DMRS_ENTITIES e on E.DESIGN_OVID = D.DESIGN_OVID
left join datamodel.dmrs_large_text t on T.DESIGN_OVID = d.design_ovid and t.object_id = e.object_id and t.ovid = e.ovid and t.type = 'Comments'
where d.date_published = (select max(d2.date_published) from datamodel.dmrs_designs d2 where d2.design_id = d.design_id);





