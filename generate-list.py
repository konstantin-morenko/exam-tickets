#!/usr/bin/env python3

import json

import argparse

parser = argparse.ArgumentParser(description='Generate LaTeX output from Tickets config')
parser.add_argument('inputfile', help='input .json file')
parser.add_argument('outputfile', help='output .tex file')

args = parser.parse_args()

inputfile = open(args.inputfile, "r")
jsoncontent = json.load(inputfile)
outputfile = open(args.outputfile, "w")

def formatInside(content, fmt):
    assert fmt['__type__'] == "Format"
    return "{0}{1}{2}".format(fmt['Prefix'], content, fmt['Suffix'])

outputfile.write(jsoncontent['Settings']['Form']['Subheader'].format(jsoncontent['Settings']['Course']))

content = ""
for question in jsoncontent["Questions"]:
    for variant in question["Variants"]:
        content += formatInside(variant["Content"], jsoncontent['Settings']['Question'])
ticket = formatInside(content, jsoncontent["Settings"]["QuestionList"])
outputfile.write(ticket)
