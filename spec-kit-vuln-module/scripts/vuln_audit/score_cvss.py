#!/usr/bin/env python3
"""Minimal CVSS v4.0 helper.

This is a stub: for authoritative scoring use FIRST's official materials.
- Spec: https://www.first.org/cvss/v4-0/specification-document
- Calculator: https://www.first.org/cvss/calculator/4.0
"""
import sys

def main():
    if len(sys.argv) < 2:
        print("Usage: score_cvss.py 'AV:N/AC:L/AT:N/PR:N/UI:N/VC:H/VI:H/VA:H'")
        sys.exit(1)
    vector = sys.argv[1]
    print(f"[INFO] Use the official calculator to score: {vector}")
    print("This stub exists to store vectors alongside findings.")

if __name__ == "__main__":
    main()
