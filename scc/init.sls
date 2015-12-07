{%- from tpldir ~ '/map.jinja' import scc with context %}

{#- Install SCC -#}
Install SCC:
  pkg.installed:
    - name: 'scc'
{%- if scc.version %}
    - version: {{ scc.version }}
{%- endif %}
    - allow_updates: True
