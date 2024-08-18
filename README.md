# svtplay-dl-bulk

A wrapper script to automate periodic downloading of many urls using [svtplay-dl](https://svtplay-dl.se/).

# Usage

```bash
Usage: svtplay-dl-bulk.sh -i <yaml_file> [-e <extra_options>]
  -i <yaml_file>      Specify the YAML file containing key-value pairs
  -e <extra_options>  Extra options to pass to the dockerized command
  -h                  Print this help message
```

# Configuration

Specify the urls to download and paths where to save them in a yaml file:

```yaml
/home/user/serier/agenterna: https://www.svt.se/barnkanalen/barnplay/agenterna
/home/user/serier/hunddagiset: https://www.svt.se/barnkanalen/barnplay/hunddagiset  
```

# Automation

Add a cronjob the runs the script.

```bash
0 0 * * * bash /path/to/svtplay-dl-bulk.sh -i list.yaml
```

# Dependencies

Only docker to run the svtplay-dl container.
