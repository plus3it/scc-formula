# scc-formula
Salt formula to install and configure the SCAP Compliance Checker for Windows

## IMPORTANT:

The SCAP Compliance Checker is not a publicly available software package. You
must have a U.S. Government CAC, or a .gov or .mil email address, to get access
to the software. See the site below for details.

- http://www.public.navy.mil/spawar/Atlantic/ProductsServices/Pages/SCAP.aspx

## Dependencies

- Package definition for SCC must be available in the winrepo database. The
installer can be obtained from the site(s) listed above.

## Available States

### scc

Install SCAP Compliance Checker for Windows

### scc.scan

Execute SCAP scans for the content specified in the pillar configuration.

This state requires the pillar `scc:lookup:content` to be configured as a list
of dictionaries, where each dictionary must have two keys, `source` and
`source_hash`. If the `content` key is not present or is set to an empty list,
then `scc.scan` will execute the `scc` state to install SCC, but no scans
will be performed.


## Configuration
Every option available in the SCC formula can be set in pillar. Below is an
example pillar configuration.

```
    scc:
      lookup:
        version: '4.0.1'
        outputdir: 'C:\path\to\scap\results'
        content:
          - source: 'https://path/to/scap-content.zip'
            source_hash: 'https://path/to/scap-content.zip.HASH'
```
