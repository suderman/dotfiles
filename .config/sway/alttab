#!/usr/bin/env python3
# Original: https://gist.github.com/SidharthArya/f4d80c246793eb61be0ae928c9184406

import sys
import json
import subprocess

target_windows = bool(sys.argv[1] == 'window')
direction=bool(sys.argv[2] == 'next')
swaymsg = subprocess.run(['swaymsg', '-t', 'get_tree'], stdout=subprocess.PIPE)
data = json.loads(swaymsg.stdout)

def setup():
    def dig(nodes):
        if nodes["focused"]:
            return True

        for node_type in "nodes", "floating_nodes":
                if node_type in nodes:
                    for node in nodes[node_type]:
                        if node["focused"] or dig(node):
                            return True

        return False

    for monitor in data["nodes"]:
        for workspace in monitor["nodes"]:
            if workspace["focused"] or dig(workspace):
                return monitor, workspace

monitor, workspace = setup()

def getNext(target_list, focus):

    if focus < len(target_list) - 1:
        return focus+1
    else:
        return 0

def getPrev(target_list, focus):

    if focus > 0:
        return focus-1
    else:
        return len(target_list)-1

def makelist_windows(temp, target_list = []):
    for nodes in "floating_nodes", "nodes":
        for i in range(len(temp[nodes])):
            if temp[nodes][i]["name"] is None:
               makelist_windows(temp[nodes][i], target_list)
            else:
               target_list.append(temp[nodes][i])

    return target_list

def makelist_workspaces(workspaces, target_list = []):
    for workspace in monitor["nodes"]:
        target_list.append(workspace)
    
    return target_list

def focused_window(temp_win):
    for i in range(len(temp_win)):
        if temp_win[i]["focused"] == True:
           return i

def focused_workspace(workspaces, current_workspace):
    for i in range(len(workspaces)):
        if workspaces[i]["name"] == current_workspace["name"]:
           return i

if target_windows:
    target_list = makelist_windows(workspace)
    focus = focused_window(target_list)

    if direction:
        attr = "[con_id="+str(target_list[getNext(target_list, focus)]["id"])+"]"
    else:
        attr = "[con_id="+str(target_list[getPrev(target_list, focus)]["id"])+"]"

    sway = subprocess.run(['swaymsg', attr, 'focus'])
    sys.exit(sway.returncode)

else:
    target_list = makelist_workspaces(monitor)
    if len(target_list) > 1:
        focus = focused_workspace(target_list, workspace)

        if direction:
            attr = target_list[getNext(target_list, focus)]["name"]
        else:
            attr = target_list[getPrev(target_list, focus)]["name"]

        sway = subprocess.run(['swaymsg', 'workspace', attr])
        sys.exit(sway.returncode)
