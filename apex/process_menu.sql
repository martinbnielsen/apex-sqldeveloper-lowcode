select level,
       p.process_name label,
        'f?p=&APP_ID.:' || nvl(a.page_id,1) || ':'||:APP_SESSION target,
        CASE WHEN :APP_PAGE_ID = a.page_id THEN 'YES' ELSE 'NO' END is_current,
        null image
from lc_processes p
LEFT JOIN apex_application_pages a on a.application_id = :APP_ID and a.page_name = p.process_name
start with parent_process_id is null
connect by prior process_id = parent_process_id
order siblings by process_number