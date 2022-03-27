with count_pageviews as (
    select 
        session_key,
        count(page_title) as pageviews
    from {{ref('stg_ga4__event_page_view')}}
    group by 1
),
bounced_sessions as (
    select
        session_key,
        TRUE as is_bounced_session
    from count_pageviews
    where pageviews <= 1 -- session is considered a bounce if there are 0 or 1 pageviews. In GA3, the technical definition is if there are 0 or 1 'interaction hits' which could include more than just pageviews, though pageview is the most common.     
)

select * from bounced_sessions