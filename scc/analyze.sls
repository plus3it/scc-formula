{%- from tpldir ~ '/map.jinja' import scc with context %}

include:
  - scc

{%- for content in scc.content %}
{%- set name = content.source.split('/')[-1] %}
{%- set fullname = scc.cachedir ~ '\\' ~ name %}
'Manage {{ name }}':
  file.managed:
    - name: '{{ fullname }}'
    - source: {{ content.source }}
    - source_hash: {{ content.source_hash }}
    - makedirs: True
    - require:
      - pkg: 'Install SCC'

'Analyze {{ name }}':
  cmd.run:
    - name: cscc.exe -isr {{ fullname }}
    - cwd: '{{ scc.cwd }}'
    - python_shell: True
    - require:
      - file: 'Manage {{ name }}'
{%- endfor %}
