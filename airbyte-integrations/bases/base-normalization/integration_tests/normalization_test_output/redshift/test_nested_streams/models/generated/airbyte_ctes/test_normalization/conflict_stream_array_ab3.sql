{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = env_var('AIRBYTE_DEFAULT_UNIQUE_KEY', '_airbyte_ab_id'),
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
select
    {{ dbt_utils.surrogate_key([
        'id',
        array_to_string('conflict_stream_array'),
    ]) }} as _airbyte_conflict_stream_array_hashid,
    tmp.*
from {{ ref('conflict_stream_array_ab2') }} tmp
-- conflict_stream_array
where 1 = 1
