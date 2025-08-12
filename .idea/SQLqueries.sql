--Filtering and Ordering
select
    campaign_id,
    campaign_name
from
    Campaigns
where
    start_date between date'2025-06-01'and date'2025-06-30'and budget>5000.00
order by
    budget desc;

--Cost Per Click
select
    campaign_id,
    device_type,
    case
        when sum(clicks) = 0 or sum(clicks) is null then 0
        else sum(spend) / nullif(sum(clicks), 0)
        end as cost_per_click
from
    AdMetrics
where
    campaign_id in ('CID-ABC111','CID-ABC222','CID-ABC333')
  and report_date between date'2025-06-01'and date'2025-06-30'
group by
    campaign_id,
    device_type;

--Joins and Conditionals
select
    Advertisers.advertiser_id,
    Campaigns.campaign_id,
    Campaigns.campaign_name,
    sum(coalesce(Admetrics.impressions, 0)) as total_impressions,
    sum(coalesce(Admetrics.clicks, 0)) as total_clicks,
    sum(coalesce(Admetrics.spend, 0)) as total_spend
from
    Advertisers
        left join
    Campaigns on Advertisers.advertiser_id = Campaigns.advertiser_id
        left join
    AdMetrics on Campaigns.campaign_id = AdMetrics.campaign_id
where
    Advertisers.advertiser_id in ('ADV-111','ADV-222','ADV-333')
group by
    Advertisers.advertiser_id,
    Campaigns.campaign_id,
    Campaigns.campaign_name
order by
    total_impressions desc,
    total_spend desc;
