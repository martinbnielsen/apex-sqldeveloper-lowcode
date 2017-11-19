-- Designs (only lates verion)
create or replace view lc_designs as
select d.*, t.text note
from datamodel.dmrs_designs d
left join datamodel.dmrs_large_text t on T.DESIGN_OVID = d.design_ovid and t.object_id = d.design_id and t.ovid = d.design_ovid and t.type = 'Note'
where d.date_published = (select max(d2.date_published) from datamodel.dmrs_designs d2 where d2.design_id = d.design_id);

-- Datamodel domains
create or replace view lc_domains as
select d.design_name, da.domain_name, da.sequence, da.value, da.short_description
from lc_designs d
join datamodel.dmrs_domain_avt da on da.design_ovid = d.design_ovid
where d.date_published = (select max(d2.date_published) from datamodel.dmrs_designs d2 where d2.design_id = d.design_id);

-- Processes
create or replace view lc_processes as
select d.design_ovid, d.design_name, date_published, published_by, de.diagram_name, p.process_id, p.parent_process_id, p.process_name, p.process_number, p.process_type, t.text, t2.text note
from lc_designs d
join datamodel.DMRS_DIAGRAMS de on DE.DESIGN_OVID = D.DESIGN_OVID
join datamodel.dmrs_processes p on p.diagram_id = de.model_id and p.diagram_ovid = de.model_ovid 
left join datamodel.dmrs_large_text t on t.ovid = p.process_ovid and t.type = 'Footnote'
left join datamodel.dmrs_large_text t2 on t2.ovid = p.process_ovid and t2.type = 'Note';

-- Entities
create or replace view lc_entities as
select d.design_name, date_published, published_by, e.entity_name, t.text
from lc_designs d
join datamodel.DMRS_ENTITIES e on E.DESIGN_OVID = D.DESIGN_OVID
left join datamodel.dmrs_large_text t on T.DESIGN_OVID = d.design_ovid and t.object_id = e.object_id and t.ovid = e.ovid and t.type = 'Comments';

