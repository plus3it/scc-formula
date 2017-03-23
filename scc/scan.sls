{%- from tpldir ~ '/map.jinja' import scc with context %}

include:
  - scc

{%- if scc.outputdir %}
'Create directory {{ scc.outputdir }}':
  file.directory:
    - name: '{{ scc.outputdir }}'
    - makedirs: True
    - require_in:
      - pkg: 'Install SCC'
{%- endif %}

{%- for content in scc.get('content', []) %}
{%- set name = content.source.split('/')[-1] %}
{%- set fullname = scc.cachedir ~ scc.ossep ~ name %}
'Manage {{ name }}':
  file.managed:
    - name: '{{ fullname }}'
    - source: {{ content.source }}
    - source_hash: {{ content.source_hash }}
    - makedirs: True
    - require:
      - pkg: 'Install SCC'

'Disable content other than {{ name }}':
  cmd.run:
    - name: '"{{ scc.cmd }}" -da -q'
    - require:
      - pkg: 'Install SCC'

'Analyze {{ name }}':
  cmd.script:
    - name: {{ scc.retry_script }}
    - args: '5 "{{ scc.cmd }}" -isr {{ fullname }} -q {% if scc.outputdir -%} -u "{{ scc.outputdir }}" {%- endif %}'
    - require:
      - cmd: 'Disable content other than {{ name }}'
      - file: 'Manage {{ name }}'
{%- if scc.outputdir %}
      - file: 'Create directory {{ scc.outputdir }}'
{%- endif %}
{%- endfor %}
