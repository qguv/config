# swayoutputctl

A python script for managing outputs in [sway](https://swaywm.org/).

Moving my laptop around using various docks, external monitors and so on, I found it a bit inconvenient having to often reconfigure my outputs in sway. This tool lets you save and activate various output configurations, or "profiles".

It has four modes:
- `save` - save the current running configuration to a profile
- `list` - list known profiles
- `activate` - activate a specific profile
- `auto` - automatically activate a matching profile


Profiles are json files containing a list of outputs and their settings, stored in `$XDG_CONFIG_HOME/swayoutputctl/`. When using the `auto` option, swayoutputctl will select a profile that contains the exact same output names (e.g. "Dell Inc. DELL U2415217CXYYZZ"), and then apply it.


## Usage
`swayoutputctl [-h] {auto,list,activate,save}`

## Examples
Save current running output configuration to "foobar": `swayoutputctl save foobar`

Activate profile "foobar": `swayoutputctl activate foobar`

List all saved profiles: `swayoutputctl list`

Automatically pick a matching profile: `swayoutputctl auto`
