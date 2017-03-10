{%- from tpldir ~ '/map.jinja' import scc with context %}

{#- Install SCC -#}
Install SCC:
  pkg.installed:
    - name: {{ scc.name }}
{%- if scc.version %}
    - version: {{ scc.version }}
{%- endif %}
{%- if scc.pkg %}
    - sources:
      - {{ scc.name }}: {{ scc.pkg.source }}
{%- endif %}
    - allow_updates: True
    - skip_verify: True
