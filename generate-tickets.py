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

for signature in jsoncontent['Settings']['Signatures']['List']:
    assert signature['__type__'] == "Signature"
    outputfile.write(jsoncontent['Settings']['Signatures']['Format'].format(signature['Work'], signature['SignedBy']))

questionNumber = len(jsoncontent["Questions"])
numberOfTickets = min([len(x['Variants']) for x in jsoncontent["Questions"]])
for x in jsoncontent["Questions"]:
    print("Variants: {0}".format(len(x['Variants'])))
# for i in range(0, int(jsoncontent['Settings']['Number-of-tickets'])):
for i in range(0, numberOfTickets):
    content = ""
    for question in jsoncontent["Questions"]:
        content += formatInside(question['Variants'][i]['Content'], jsoncontent['Settings']['Question'])
    ticket = formatInside(content, jsoncontent["Settings"]["Tickets"])
    outputfile.write(ticket)
