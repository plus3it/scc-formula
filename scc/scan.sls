{%- from tpldir ~ '/map.jinja' import scc with context %}

include:
  - scc

{%- if scc.outputdir %}
'Create directory {{ scc.outputdir }}':
  file.directory:
    - name: '{{ scc.outputdir }}'
    - makedirs: True
{%- endif %}

{%- for content in scc.get('content', []) %}
{%- set name = content.source.split('/')[-1] %}
{%- set fullname = scc.cachedir ~ '\\' ~ name %}
'Manage {{ name }}':
  file.managed:
    - name: '{{ fullname }}'
    - source: {{ content.source }}
    - source_hash: {{ content.source_hash }}
    - makedirs: True

'Disable content other than {{ name }}':
  cmd.run:
    - name: cscc.bat -da -q
    - cwd: '{{ scc.cwd }}'
    - require:
      - pkg: 'Install SCC'

'Analyze {{ name }}':
  cmd.run:
    - name: cscc.bat -isr {{ fullname }} -q {% if scc.outputdir -%} -u {{ scc.outputdir }} {%- endif %}
    - cwd: '{{ scc.cwd }}'
    - require:
      - cmd: 'Disable content other than {{ name }}'
      - file: 'Manage {{ name }}'
{%- if scc.outputdir %}
      - file: 'Create directory {{ scc.outputdir }}'
{%- endif %}
{%- endfor %}
