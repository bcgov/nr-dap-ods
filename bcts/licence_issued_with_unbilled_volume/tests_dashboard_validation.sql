select *
from bcts_reporting.licence_issued_with_unbilled_volume_main
where business_area = 'Peace-Liard (TPL)';


-- Unbilled-Active
select sum(unbilled_volume)
from bcts_reporting.licence_issued_with_unbilled_volume_main
where business_area = 'Peace-Liard (TPL)' and harvesting_status = 'Active_Harvesting';

-- Unbilled- No Activity
select sum(unbilled_volume)
from bcts_reporting.licence_issued_with_unbilled_volume_main
where business_area = 'Peace-Liard (TPL)' and coalesce(harvesting_status, '') <> 'Active_Harvesting';

-- Unbilled Expiring > 6 months - No activity
select sum(unbilled_volume - unbilled_volume_expire_in_6_month)
from bcts_reporting.licence_issued_with_unbilled_volume_main
where business_area = 'Peace-Liard (TPL)' and coalesce(harvesting_status, '') != 'Active_Harvesting';

-- Unbilled Expiring  6 months - No activity
select sum(unbilled_volume_expire_in_6_month)
from bcts_reporting.licence_issued_with_unbilled_volume_main
where business_area = 'Peace-Liard (TPL)' and coalesce(harvesting_status, '') != 'Active_Harvesting';
