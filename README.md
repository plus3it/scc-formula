[![Travis Build Status](https://travis-ci.org/plus3it/scc-formula.svg?branch=master)](https://travis-ci.org/plus3it/scc-formula)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/plus3it/scc-formula?branch=master&svg=true)](https://ci.appveyor.com/project/plus3it/scc-formula)

# scc-formula
Salt formula to install and configure the SCAP Compliance Checker

## IMPORTANT

The SCAP Compliance Checker is not a publicly available software package. You
must have a U.S. Government CAC, or a .gov or .mil email address, to get access
to the software. See the site below for details.

- http://www.public.navy.mil/spawar/Atlantic/ProductsServices/Pages/SCAP.aspx

## Dependencies

- **Windows**: Package definition for SCC must be available in the winrepo
database. The installer can be obtained from the site(s) listed above.
- **Linux**: Package definition for SCC must be in an available yum repo, or
the rpm must be hosted at the url specified by the pillar
`scc:lookup:pkg:source`.

## Available States

### scc

Install SCAP Compliance Checker

### scc.scan

Execute SCAP scans for the content specified in the pillar configuration.

This state requires the pillar `scc:lookup:content` to be configured as a list
of dictionaries, where each dictionary must have two keys, `source` and
`source_hash`. If the `content` key is not present or is set to an empty list,
then `scc.scan` will execute the `scc` state to install SCC, but no scans
will be performed.


## Configuration
Every option available in the SCC formula can be set via pillar. Below is an
example pillar configuration.

```
    scc:
      lookup:
        version: '4.0.1'
        outputdir: ''
        pkg:
          source: https://url/to/scc.rpm
        content:
          - source: https://url/to/scap-benchmark1.zip
            source_hash: https://url/to/scap-benchmark1.zip.HASH
          - source: https://url/to/scap-benchmark2.zip
            source_hash: https://url/to/scap-benchmark2.zip.HASH
```
