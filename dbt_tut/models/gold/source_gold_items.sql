with dedup_query as (
    select
        id,
        name,
        category,
        updateDate,
        row_number() over (partition by id order by updateDate desc) as deduped_id
    from {{ source('source', 'items') }}
)
select
    id,
    name,
    category,
    updateDate
from dedup_query
where deduped_id = 1
;
