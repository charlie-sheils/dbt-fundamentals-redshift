{% macro grant_select(schema=target.schema, username=target.user) %}

    {% set sql %}
        -- grant select on schema {{ schema }} to role {{ role }};
        -- grant select on all tables in schema {{ schema }} to username {{ username }};
        grant select on all tables in schema {{ schema }} to PUBLIC;
        -- grant select on all views in schema {{ schema }} to PUBLIC;
    {% endset %}


    {{ log('Granting select access to public: ' ~ target.schema, info=True) }}
    {% do run_query(sql) %}
    {{ log('Privileges granted!', info=True) }}

{% endmacro %}
