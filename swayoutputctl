#!/usr/bin/env python3

import json
import subprocess
import argparse
from xdg import BaseDirectory
from pathlib import Path


def get_output_current():
    output_raw = json.loads(
            subprocess.run(
                ['swaymsg', '-r', '-t', 'get_outputs'],
                capture_output=True, text=True).stdout)
    output_current = {}
    for item in output_raw:
        unique_name = "{} {} {}".format(
                item['make'], item['model'], item['serial'])
        output_current[unique_name] = {}
        output = output_current[unique_name]
        if item.get('active'):
            output['active'] = True
            output['scale'] = item['scale']
            output['primary'] = item['primary']
            output['transform'] = item['transform']
            output['rect'] = item['rect']
            output['current_mode'] = item['current_mode']
        else:
            output['active'] = False
    return output_current


def do_applyProfile(profile):
    for item in profile:
        output = profile[item]
        if output['active']:
            cmd = [
                'swaymsg',
                'output',
                '"{}"'.format(item),
                'transform',
                output['transform'],
                'pos',
                str(output['rect']['x']),
                str(output['rect']['y']),
                'res',
                "{}x{}@{}Hz".format(
                    str(output['current_mode']['width']),
                    str(output['current_mode']['height']),
                    str(output['current_mode']['refresh']),
                    ),
                'enable',
                ]
        else:
            cmd = [
                'swaymsg',
                'output',
                '"{}"'.format(item),
                'disable',
            ]
        subprocess.run(cmd)


def handle_auto(args, path):
    p = Path(path)
    output_current = get_output_current()
    matches = []
    for item in sorted(p.glob('*.json')):
        with open(item, 'r') as f:
            profile_name = item.stem
            output_profile = json.load(f)
            if (sorted(output_profile) == sorted(output_current)):
                print("Profile '{}' matches".format(profile_name))
                matches.append((profile_name, output_profile))
    if len(matches) == 0:
        print("No profiles matched")
    else:
        if len(matches) > 1:
            print("More than one profile matched")
        profile_name, output_profile = matches[0]
        print("Using profile '{}'".format(profile_name))
        if (output_profile == output_current):
            print(
                "Profile '{}' identical".format(profile_name) +
                " to running configuration. Nothing to do.")
        else:
            print(
                "Running configuration does not match" +
                "current configuration. Applying changes.")
            do_applyProfile(output_profile)


def handle_list(args, path):
    p = Path(path)
    for item in sorted(p.glob('*.json')):
        print(item.stem)


def handle_activate(args, path):
    p = Path(path)
    with open("{}/{}.json".format(p, args.name), 'r') as f:
        do_applyProfile(json.load(f))


def handle_save(args, path):
    p = Path(path)
    with open("{}/{}.json".format(p, args.name), 'x') as f:
        print(json.dumps(get_output_current(), indent=2), file=f)


def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest='cmd')
    subparsers.required = True

    parser_auto = subparsers.add_parser('auto')
    parser_auto.set_defaults(func=handle_auto)

    parser_list = subparsers.add_parser('list')
    parser_list.set_defaults(func=handle_list)

    parser_activate = subparsers.add_parser('activate')
    parser_activate.add_argument('name')
    parser_activate.set_defaults(func=handle_activate)

    parser_save = subparsers.add_parser('save')
    parser_save.add_argument('name')
    parser_save.set_defaults(func=handle_save)

    args = parser.parse_args()
    args.func(args, BaseDirectory.save_config_path('swayoutputctl'))


if __name__ == '__main__':
    main()
