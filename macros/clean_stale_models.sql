{% macro clean_stale_models(database=target.database, schema=target.schema, days=7, dry_run=True) %}

    {% set get_drop_commands_query %}
        SELECT
        table_name
        FROM information_schema.tables
        WHERE table_schema = '{{ schema }}';
    {% endset %}

    -- {% do run_query(get_drop_commands_query) %}
    {{ log('\nGenerating cleanup queries...\n', info=True) }}
    {% set drop_queries = run_query(get_drop_commands_query).columns[0].values() %}
    {{log('Drop queries ' ~ drop_queries)}}

    -- Can't execute this with redshift, because information_schema.tables doesn't have last_altered column
    -- {% for drop_query in drop_queries %}
    --     {% if execute and not dry_run %}
    --         {{ log('Dropping table/view with command: ' ~ drop_query, info=True) }}
            -- {% do run_query(drop_query) %}    
    --     {% else %}
    --         {{ log(drop_query, info=True) }}
    --     {% endif %}
    -- {% endfor %}
  
{% endmacro %}